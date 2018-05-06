-- ====================================================================
--
--	File Name:		Arithmetic_Unit.vhd
--	Description:	Arithmetic_Unit, MAC need one call (with the OPP "000") to initialize
--
--
--	Date:			10/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1. we need to out the carry?
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 -- entity Definition
entity Arithmetic_Unit is
    generic(N: positive := 8); --defualt value for N is 8
    port(
        clk : in std_logic;
        A  : in signed(N-1 downto 0);
        B  : in signed(N-1 downto 0);
        OPP : in std_logic_vector (2 downto 0);
        LO : out signed (N-1 downto 0);
        HI : out signed (N-1 downto 0);
        FLAGS : out signed(5 downto 0);
        FLAG_en : out std_logic); -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
end Arithmetic_Unit;

 -- Architecture Definition
architecture gate_level of Arithmetic_Unit is
-------------------------------
component ADD_SUB
   generic (N: integer := 8 ); --defualt value for N is 8
   port(
      addORsub :   in std_logic;
      A :     in signed ((N-1) downto 0);
      B :     in signed ((N-1) downto 0);
      SUM :   out signed ((N-1) downto 0);
      Cout  : out std_logic);
 end component;

 component MUL
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
        A :   in signed((N-1) downto 0);
        B :   in signed((N-1) downto 0);
        result: out signed(2*N-1 downto 0));
  end component;

  component MAX_MIN
    generic(N: integer := 8); --defualt value for N is 8
    port (
      maxORmin : in  std_logic;
      A, B :     in  signed(N-1 downto 0);
      result :   out signed(N-1 downto 0));
    end component;

 component MAC
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
      mac_rst : in std_logic;
      clk :     in std_logic;
      enable :  in std_logic;
      LO_bits : in signed(N-1 downto 0);
      HI_bits : in signed(N-1 downto 0);
      MAC_result :  out signed(2*N-1 downto 0));
  end component;

  component MUX_Nbits
      generic(N: positive := 8); --defualt value for N is 8
      port (
             SEL: in  std_logic;
             Y1 : in  signed (N-1 downto 0);
             Y2 : in  signed (N-1 downto 0);
             Y  : out signed (N-1 downto 0));
  end component;

  component Arithmetic_selector
     generic(N: positive := 8); --defualt value for N is 8
     port(
      clk : in std_logic;
       OPP :   in std_logic_vector (2 downto 0);
       MUL_result : in signed (2*N-1 downto 0);
       MAX_MIN_LO : in signed ((N-1) downto 0);
       ADD_SUB_result : in signed (2*N-1 downto 0);
       LO : out signed ((N-1) downto 0);
       HI : out signed ((N-1) downto 0);
       FLAG_en : out std_logic); -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
   end component;

-- aid signals
signal  MUL_result :  signed (2*N-1 downto 0) := (others => '0');
signal  MAC_result :  signed (2*N-1 downto 0) := (others => '0');
signal  ADD_SUB_result :  signed (2*N-1 downto 0);

signal  MAX_MIN_LO :  signed ((N-1) downto 0); -- OPP MAX : 010 OPP MIN: 011 then max or min by OP(0)

signal  selected_A : signed (2*N-1 downto 0);
signal  selected_B : signed (2*N-1 downto 0);

signal extendedA, extendedB : signed (2*N -1 downto 0);

signal  mac_rst, mac_enable : std_logic;
signal carry : std_logic;
begin
----------------------------------------
mac_rst <= (OPP(2) and OPP(1)) and (NOT OPP(0)); -- MAC = 0 if OPP= RST
mac_enable <= ((NOT OPP(0)) and (NOT OPP(1))) and (NOT OPP(2));
extendedA(2*N-1 downto N) <= (others => A(N-1)); -- pad A to be 2N bits
extendedA(N-1 downto 0) <= A;
extendedB(2*N-1 downto N) <= (others => B(N-1)); -- pad B to be 2N bits
extendedB(N-1 downto 0) <= B;

-- mul component , MUL_result = A*B (signed number)
mul_component :  MUL  generic map(N) port map (A, B, MUL_result);

-- select A,B for the add_sub hardware. the choice is between the inputs(A,B) and numbers(MUL_result,MAC register)
mux_bits_A : MUX_Nbits generic map(2*N) port map (mac_enable, extendedA, MAC_result, selected_A); -- num1 : A or MAC register
mux_bits_B : MUX_Nbits generic map(2*N) port map (mac_enable, extendedB, MUL_result, selected_B); -- num2 : B or A*B

-- add/sub component, ADD_SUB_result = selected_A +/- selected_B & flags if it was sub
add_sub_component : ADD_SUB generic map(2*N)
                     port map (OPP(0), selected_A, selected_B, ADD_SUB_result,carry); -- OPP : SUB = 101, ADD= 100, then add or sub by OP(0) (& mac OPP = 000)

-- mac component, save the add_sub result (accumlate) if the OPP = MAC
mac_component : MAC generic map(N)
               port map (mac_rst, clk, mac_enable, ADD_SUB_result(N-1 downto 0), ADD_SUB_result(2*N-1 downto N), MAC_result);

-- max/min component, MAX_MIN_LO = max/min(A,B). (MAX OPP code : 100, MIN : 101)
max_min_component : MAX_MIN generic map(N)
              port map (OPP(0), A, B, MAX_MIN_LO);

-- will output the right HI&LO bits according to the OPP code
arithmetic_selector_component :  Arithmetic_selector  generic map(N)
  port map (clk, OPP, MUL_result, MAX_MIN_LO, ADD_SUB_result, LO, HI, FLAG_en);

  flag_handle : process(ADD_SUB_result)
      variable FLAG : signed(5 downto 0) := "000000";
      begin
        FLAGS <= FLAG; -- will assign at the end of process
        FLAG(0) := '1'; -- is A=B ?
        eachBit: for i in 0 to (N-1) loop
          FLAG(0) := (FLAG(0) AND (NOT ADD_SUB_result(i)));
        end loop;
        FLAG(1) := NOT FLAG(0); -- A!=B
        FLAG(2) := NOT ADD_SUB_result(N-1);--A >= B if tempSUM(N-1)=0 then
        FLAG(3) := FLAG(2) AND FLAG(1); -- A>B if A>=B & A!=B
        FLAG(4) := NOT FLAG(3);-- A<=B if !(A>B)
        FLAG(5) := FLAG(4) AND FLAG(1); -- A<B if (A<=B & A!=B)
  end process flag_handle;
----------------------------------------
end gate_level;

--EndOfFile
