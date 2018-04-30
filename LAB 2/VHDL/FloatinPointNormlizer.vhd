-- ====================================================================
--
--	File Name:		FloatinPointNormlizer.vhd
--	Description: Floatin Point Normlizer 8 bit number to 32 ieee 754
--
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity FloatinPointNormlizer is
    generic(N: positive := 8); --defualt value for N is 8
    port (
       A : in  signed (N-1 downto 0);
       B : in  signed (N-1 downto 0);
       Out1  : out signed (31 downto 0);
       Out2 :  out signed (31 downto 0));
end FloatinPointNormlizer;


 -- Architecture Definition
architecture gate_level of FloatinPointNormlizer is

  -- components decleration
  component shift_unit
      generic(N: integer := 8); --defualt value for N is 8
      port(
        dir :    in std_logic;
        A :      in signed(N-1 downto 0);
        B :      in signed(5 downto 0);
        result : out signed(N-1 downto 0));
  end component;

  component LeadingZeroes_counter
      generic(N: positive := 8); --defualt value for N is 8
      port (
         X :  in  signed (N-1 downto 0);
         Y  : out signed (5 downto 0));
  end component;

  component ADD_SUB
      generic(N: positive := 8); --defualt value for N is 8
      port(
         addORsub :  in std_logic;
         A :     in signed ((N-1) downto 0);
         B :     in signed ((N-1) downto 0);
         SUM :   out signed ((N-1) downto 0);
         Cout  :  out std_logic);
  end component;

signal zeroesCount1 : signed (5 downto 0) := 0;
signal zeroesCount2 : signed (5 downto 0) := 0;
signal tempdir : std_logic;

begin
----------------------------------------
-- 0. sign bit
Out1(31) <= A(7);
Out2(31) <= B(7);

-- 1. find out number of leading zeroes
stage_1 :  LeadingZeroes_counter generic map(5)
              port map(A(6 downto 2), zeroesCount1);
stage_2 :  LeadingZeroes_counter generic map(5)
              port map(B(6 downto 2), zeroesCount2);

-- 2. find the mantisa
Out1(22 downto 0) <= A(6-to_integer(zeroesCount1) downto 2) & A(1 downto 0) & (16 + to_integer(zeroesCount1) downto 0 =>'0');
Out2(22 downto 0) <= B(6-to_integer(zeroesCount2) downto 2) & B(1 downto 0) & (16 + to_integer(zeroesCount2) downto 0 =>'0');

-- 3. find the exponent
stage_3 : LeadingZeroes_counter generic map(5)
              port map(B(6 downto 2), zeroesCount2);



----------------------------------------
end gate_level;

--EndOfFile
