-- ====================================================================
--
--	File Name:		ALU.vhd
--	Description: ALU_TOP design
--
--	Date:			11/04/2018
--	Designers:  Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity ALU is
    generic(N: positive := 8); --defualt value for N is 8
    port (
       clk:     in  std_logic;
       OPP:     in  signed (3 downto 0);
       A:       in  signed (N-1 downto 0);
       B :      in  signed (N-1 downto 0);
       LO :     out signed (N-1 downto 0);
       HI :     out signed (N-1 downto 0);
       STATUS : out signed (5 downto 0));
end ALU;

 -- Architecture Definition
architecture structural of ALU is

component Output_Selector
    generic(N: positive := 8); --defualt value for N is 8
    port (
       SEL:             in  std_logic;
       FLAG_en :        in  std_logic;
       arithmetic_LO:   in  signed (N-1 downto 0);
       arithmetic_HI:   in  signed (N-1 downto 0);
       arithmetic_FLAG: in  signed (5 downto 0);
       shift_LO :       in  signed (N-1 downto 0);
       LO :             out signed (N-1 downto 0);
       HI :             out signed (N-1 downto 0);
       STATUS :         out signed (5 downto 0));
end component;

component Arithmetic_Unit
    generic(N: positive := 8); --defualt value for N is 8
    port(
        A  : in signed((N-1) downto 0);
        B  : in signed((N-1) downto 0);
        OP : in std_logic_vector (2 downto 0);
        MAC_HI_IN : in signed((N-1) downto 0);
        MAC_LO_IN : in signed((N-1) downto 0);
        HI : out signed ((N-1) downto 0);
        LO : out signed ((N-1) downto 0);
        FLAGS : out std_logic_vector(5 downto 0);
        FLAG_en : out std_logic); -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
end component;

component shift_unit
    generic(N: integer := 8); --defualt value for N is 8
    port(
       dir :    in std_logic;
       A :      in signed(N-1 downto 0);
       B :      in signed(5 downto 0);
       result : out signed(N-1 downto 0));
end component;

component MUX_Nbits
    generic(N: positive := 8); --defualt value for N is 8
    port (
       SEL: in  std_logic;
       Y1 : in  signed (N-1 downto 0);
       Y2 : in  signed (N-1 downto 0);
       Y  : out signed (N-1 downto 0));
end component;

-- global signals
signal MAC_LO :  signed(N-1 downto 0) := (others => '0');
signal MAC_HI :  signed(N-1 downto 0) := (others => '0');
signal FLAGS :   signed(5 downto 0) := (others => '0');
signal FLAG_en : std_logic := '0';
signal mac_update : std_logic := '0';

-- temp results from the units
signal arithmetic_LO : signed(N-1 downto 0);
signal arithmetic_HI : signed(N-1 downto 0);
signal shift_LO : signed(N-1 downto 0);
begin
----------------------------------------
ArithmeticUnit : Arithmetic_Unit generic map (N) port map (A, B, OPP(2 downto 0), MAC_HI, MAC_LO, arithmetic_HI, arithmetic_LO, FLAGS, FLAG_en);
ShiftUnit :      shift_unit      generic map (N) port map (OPP(0), A, B(5 downto 0), shift_LO);
OutputSelector : Output_Selector generic map (N) port map (OPP(3), FLAG_en, arithmetic_LO, arithmetic_HI, FLAGS, shift_LO, LO, HI, STATUS);

process
begin
  wait on LO;
  wait on HI;
  if OPP = "001" then
  MAC_LO <= LO;
  MAC_HI <= HI;
  end if;
end process
----------------------------------------
end structural;

--EndOfFile
