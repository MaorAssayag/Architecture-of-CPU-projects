-- ====================================================================
--
--	File Name:		FloatingPointConvertor.vhd
--	Description: Floating Point convertor :  8 bit binary number
--                                        ( MSB sign, 6to2 integer, 1 to 0 fraction) to 32 ieee 754
--
--
--	Date:			06/05/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity FloatingPointConvertor is
    generic(N: positive := 8); --defualt value for N is 8
    port (
       A : in  signed (N-1 downto 0);
       B : in  signed (N-1 downto 0);
       Out1  : out signed (31 downto 0);
       Out2 :  out signed (31 downto 0));
end FloatingPointConvertor;


 -- Architecture Definition
architecture gate_level of FloatingPointConvertor is

  -- components decleration
  component LeadingZeros_counter
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

  component shift_unit
      generic(N: integer := 8); --defualt value for N is 8
      port(
         dir :    in std_logic;
         A :      in signed(N-1 downto 0);
         B :      in signed(5 downto 0);
         result : out signed(N-1 downto 0));
  end component;

-- temp signal's
signal zeroesCount1 : signed (5 downto 0) := (5 downto 0 => '0');
signal zeroesCount2 : signed (5 downto 0) := (5 downto 0 => '0');
signal tempdir : std_logic;
signal bias : signed(7 downto 0);
signal exponent1 : signed (7 downto 0);
signal exponent2 : signed (7 downto 0);
signal fraction1_extractMSB : signed ( 4 downto 0);
signal fraction2_extractMSB : signed ( 4 downto 0);
signal fraction1_extendLSB : signed ( 23 downto 0);
signal fraction2_extendLSB : signed ( 23 downto 0);
signal LSB1_shift : signed (5 downto 0) := (5 downto 0 => '0');
signal LSB2_shift : signed (5 downto 0) := (5 downto 0 => '0');
signal tmp1 : signed (4 downto 0); -- avoid warnings about static number
signal tmp2 : signed (4 downto 0); -- avoid warnings about static number
signal tmp3 : signed (23 downto 0); -- avoid warnings about static number
signal tmp4 : signed (23 downto 0); -- avoid warnings about static number
signal tmp5 : signed (22 downto 0); -- avoid warnings about static number
signal tmp6 : signed (22 downto 0); -- avoid warnings about static number

begin
----------------------------------------
-- 0. sign bit
Out1(31) <= A(7);
Out2(31) <= B(7);
exponent1 <= (1 downto 0 => '0') & zeroesCount1;
exponent2 <= (1 downto 0 => '0') & zeroesCount2;
bias <= "10000011"; -- (=131),  bias = 127, bias + (6 - leading zeroes - 2) = 131 - leading zeros

-- 1. find out number of leading zeroes
stage_1 :  LeadingZeros_counter generic map(5)
              port map(A(6 downto 2), zeroesCount1);
stage_2 :  LeadingZeros_counter generic map(5)
              port map(B(6 downto 2), zeroesCount2);

-- 3. find the exponent
stage_3 : ADD_SUB generic map(8)
              port map('1', Bias, exponent1, Out1(30 downto 23));
stage_4 : ADD_SUB generic map(8)
              port map('1', Bias, exponent2, Out2(30 downto 23));

--4. gain the MSB of the mantisa from the integer part (after divide by 2 zeroesCount1 times)
tmp1 <= '0' & A(5 downto 2);
tmp2 <= '0' & B(5 downto 2);
stage_5 : shift_unit generic map(5)
              port map ('0',tmp1,zeroesCount1,fraction1_extractMSB);
stage_6 : shift_unit generic map(5)
              port map ('0',tmp2,zeroesCount2,fraction2_extractMSB);

--5. gain the number of new MSB bits for the mantisa
stage_11 : ADD_SUB generic map(6)
              port map('1', "000100", zeroesCount1, LSB1_shift);
stage_12 : ADD_SUB generic map(6)
              port map('1', "000100", zeroesCount2, LSB2_shift);

--6. extend the fraction bits to 22 bit with the correct place for the final mantisa
tmp3 <= '0' & A(1 downto 0) & (20 downto 0 =>'0');
tmp4 <= '0' & B(1 downto 0) & (20 downto 0 =>'0');
stage_7 : shift_unit generic map(24)
              port map ('1',tmp3,LSB1_shift,fraction1_extendLSB);
stage_8 : shift_unit generic map(24)
              port map ('1',tmp4,LSB2_shift,fraction2_extendLSB);

--7. add the fraction part & the integer bits part for the final mantisa
tmp5 <= fraction1_extractMSB(3 downto 0) & (18 downto 0 =>'0');
tmp6 <= fraction2_extractMSB(3 downto 0) & (18 downto 0 =>'0');
stage_9 : ADD_SUB generic map(23)
              port map('0', tmp5, fraction1_extendLSB(22 downto 0), Out1(22 downto 0));
stage_10 : ADD_SUB generic map(23)
              port map('0', tmp6, fraction2_extendLSB(22 downto 0), Out2(22 downto 0));
----------------------------------------
end gate_level;

--EndOfFile
