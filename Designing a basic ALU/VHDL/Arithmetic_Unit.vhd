-- ====================================================================
--
--	File Name:		Arithmetic_Unit.vhd
--	Description:	Arithmetic_Unit
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
        A  : in signed((N-1) downto 0);
        B  : in signed((N-1) downto 0);
        OP : in std_logic_vector (2 downto 0);
        MAC_HI_IN : in signed((N-1) downto 0);
        MAC_LO_IN : in signed((N-1) downto 0);
        HI : out signed ((N-1) downto 0);
        LO : out signed ((N-1) downto 0)
        FLAGS : out std_logic_vector(5 downto 0)
       );
end Arithmetic_Unit;

 -- Architecture Definition
architecture gate_level of Arithmetic_Unit is
-------------------------------
component ADD_SUB
   generic (N: integer := 8 ); --defualt value for N is 8
   port(
     addORsub :   in std_logic;
     FLAG : inout std_logic_vector(5 downto 0);
     A :     in signed ((N-1) downto 0);
     B :     in signed ((N-1) downto 0);
     SUM :   out signed ((N-1) downto 0)
    );
 end component;
 component MUL
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
        A :     in signed((N-1) downto 0);
        B :     in signed((N-1) downto 0);
        HI :   out signed((N-1) downto 0);
        LO : out signed((N-1) downto 0)
     );
  end component;
  component MAX_MIN
  generic(N: integer := 8); --defualt value for N is 8
  port (
    maxORmin : in  std_logic;
    FLAG : inout std_logic_vector(7 downto 0);
    A, B :     in  signed(N-1 downto 0);
    result :   out signed(N-1 downto 0)
  );
  end component;
  component shift_Nbits
  generic(N: integer := 8); --defualt value for N is 8
  port (
    dir :    in std_logic;
    enable : in std_logic;
    A :      in signed(N-1 downto 0);
    Aout :   out signed(N-1 downto 0));
 end component;
 component MAC
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
          A :     in signed((N-1) downto 0);
          B :     in signed((N-1) downto 0);
          MACHI :   in signed((N-1) downto 0);
          MACLO : in signed((N-1) downto 0);
          HI :   out signed((N-1) downto 0);
          LO : out signed((N-1) downto 0)
     );
  end component;
  component Arithmetic_selector
     generic(N: positive := 8); --defualt value for N is 8
     port(
        OP :   in std_logic_vector (2 downto 0);
        MUL_HI : in signed ((N-1) downto 0);
        MUL_LO : in signed ((N-1) downto 0);
        MAC_HI : in signed ((N-1) downto 0);
        MAC_LO : in signed ((N-1) downto 0);
        MAX_LO : in signed ((N-1) downto 0);
        MIN_LO : in signed ((N-1) downto 0);
        ADD_LO : in signed ((N-1) downto 0);
        SUB_LO : in signed ((N-1) downto 0);
        HI : out signed ((N-1) downto 0);
        LO : out signed ((N-1) downto 0)
        );
   end component;




signal  MUL_HI : out signed ((N-1) downto 0);
signal  MUL_LO : out signed ((N-1) downto 0);
signal  MAC_HI : out signed ((N-1) downto 0);
signal  MAC_LO : out signed ((N-1) downto 0);
signal  MAX_LO : out signed ((N-1) downto 0);
signal  MIN_LO : out signed ((N-1) downto 0);
signal  ADD_LO : out signed ((N-1) downto 0);
signal  SUB_LO : out signed ((N-1) downto 0);
begin
----------------------------------------
MACFUN :  MAC  generic map(N)
  port map (A ,B ,MAC_HI_IN,MAC_LO_IN,MAC_HI,MAC_LO);
ADDFUN :  ADD_SUB  generic map(N)
  port map ('0', FLAGS, A ,B ,ADD_LO);
SUBFUN :  ADD_SUB  generic map(N)
  port map ('1', FLAGS, A ,B ,SUB_LO);


----------------------------------------
end gate_level;

--EndOfFile
