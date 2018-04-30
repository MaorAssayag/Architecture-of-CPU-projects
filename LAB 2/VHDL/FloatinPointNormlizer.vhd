-- ====================================================================
--
--	File Name:		FloatinPointNormlizer.vhd
--	Description: Floatin Point convertor :  8 bit binary number
--                                        ( MSB sign, 6to2 integer, 1 to 0 fraction) to 32 ieee 754 
--
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- TODO : TB
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

-- temp signal's
signal zeroesCount1 : signed (5 downto 0) := (5 downto 0 => '0');
signal zeroesCount2 : signed (5 downto 0) := (5 downto 0 => '0');
signal tempdir : std_logic;
signal bias : signed(7 downto 0) := "10000011"; -- (=131),  bias = 127, bias + (6 - leading zeroes - 2) = 131 - leading zeros
signal exponent1 : signed (7 downto 0);
signal exponent2 : signed (7 downto 0);

begin
----------------------------------------
-- 0. sign bit
Out1(31) <= A(7);
Out2(31) <= B(7);
exponent1 <= (1 downto 0 => '0') & zeroesCount1;
exponent2 <= (1 downto 0 => '0') & zeroesCount2;

-- 1. find out number of leading zeroes
stage_1 :  LeadingZeroes_counter generic map(5)
              port map(A(6 downto 2), zeroesCount1);
stage_2 :  LeadingZeroes_counter generic map(5)
              port map(B(6 downto 2), zeroesCount2);

-- 2. find the mantisa
Out1(22 downto 0) <= A((5-to_integer(zeroesCount1)) downto 2) & A(1 downto 0) & ((16 + to_integer(zeroesCount1)) downto 0 =>'0');
Out2(22 downto 0) <= B((5-to_integer(zeroesCount2)) downto 2) & B(1 downto 0) & ((16 + to_integer(zeroesCount2)) downto 0 =>'0');

-- 3. find the exponent
stage_3 : ADD_SUB generic map(8)
              port map('1', Bias, exponent1, Out1(30 downto 23));
stage_4 : ADD_SUB generic map(8)
              port map('1', Bias, exponent2, Out2(30 downto 23));
----------------------------------------
end gate_level;

--EndOfFile
