-- ====================================================================
--
--	File Name:		ADD_SUB_FPU.vhd
--	Description:	ADD\SUB command, currently support N bit's IEEE Standard 754 Floating Point Numbers
--  Floating Point Components       Sign   	Exponent  	Fraction
--               Single Precision 	1 [31] 	8 [30–23] 	23 [22–00]
--               OPP=1 -> SUB, OPP=0 -> ADD
--
--	Date:			29/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- TODO : test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity ADD_SUB_FPU is
    generic(N: integer := 32); --defualt value for N is 32
    Port(
       OPP : in std_logic;
       A :     in signed((N-1) downto 0);
       B :     in signed((N-1) downto 0);
       SUM :   out signed((N-1) downto 0));
end ADD_SUB_FPU;

 -- Architecture Definition
architecture gate_level of ADD_SUB_FPU is

-- Components
component ADD_SUB
    generic(N: positive := 8); --defualt value for N is 8
    port(
       addORsub :  in std_logic;
       A :     in signed ((N-1) downto 0);
       B :     in signed ((N-1) downto 0);
       SUM :   out signed ((N-1) downto 0);
       Cout  :  out std_logic);
end component;

component Swap
    generic(N: positive := 8); --defualt value for N is 8
    port (
       SEL: in  std_logic;
       Y1 : in  signed (N-1 downto 0);
       Y2 : in  signed (N-1 downto 0);
       Out1  : out signed (N-1 downto 0);
       Out2 :  out signed (N-1 downto 0));
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

component MAX_MIN
    generic (N: INTEGER := 8); --defualt value for N is 8
    port(
        maxORmin : in  std_logic;
        A, B :     in  signed(N-1 downto 0);
        result :   out signed(N-1 downto 0));
end component;

--floating point components extraction signals
signal signA: std_logic;
signal signB: std_logic;
signal expA: signed(7 downto 0);
signal expB: signed(7 downto 0);
signal fractionA: signed(22 downto 0); -- original value
signal fractionB: signed(22 downto 0); -- original value

--temp connection signals
signal expDiff: signed(7 downto 0); -- exponentA - exponentB
signal maxExponent : signed(7 downto 0);
signal fraction1: signed(22 downto 0); -- First number fraction
signal fraction2: signed(24 downto 0); -- Second number fraction after alignment
signal temp_fraction2: signed(22 downto 0); -- Second number fraction before alignment
signal tempFraction_result : signed(24 downto 0); -- after 1 shift to the right if needed
signal tempFraction_result2 : signed(24 downto 0); -- after shift Correction
signal tempFraction_result3 : signed(24 downto 0); -- after add Correction
signal SUBorADD: std_logic;
signal carryFractions: std_logic;
signal temp2 : std_logic;
signal temp : std_logic;
begin
----------------------------------------
    signA <= A(31);
    signB <= B(31);
    expA <= A(30 downto 23);
    expB <= B(30 downto 23);
    fractionA <= A(22 downto 0);
    fractionB <= B(22 downto 0);
    SUBorADD <= OPP xor A(31) xor B(31);

    -- Find the difference between the Exponent of A and B : expA - expB, default N=8 bits
    stage_0 : ADD_SUB
              port map ('1', expA, expB, expDiff);

    -- Exponent alligenment preparation : Prepare the fraction of the Number with the min exponent to be shifted
    -- if expDiff(7)=0 -> exponentA-exponentB > 0, shift right fraction B.
    stage_1 : Swap generic map (23)
              port map (expDiff(7), fractionA, fractionB, fraction1, temp_fraction2);

    -- Exponent alligenment : shift right the fraction of the Number with the min exp
    stage_2 : shift_unit generic map(25)
              port map ('1', '0' & '1' & temp_fraction2, expDiff(5 downto 0), fraction2);

    -- Add/Sub the fractions, save the carry and the temp result for the next step
    stage_3 : ADD_SUB generic map(25)
              port map (SUBorADD, '0' & '1' & fraction1, fraction2, tempFraction_result, carryFractions);

    -- if the sum of the 1.fractionA + (1.fractionB >> diff) >1 -> add 1 to Exponent
    stage_4 : ADD_SUB generic map(8)
                  port map ('0', maxExponent, (7 downto 1 => '0') & tempFraction_result(24), SUM(30 downto 23), temp);

    -- if the sum of the 1.fractionA + (1.fractionB >> diff) >1 -> shift right once the fraction result
    stage_5 : shift_unit generic map(25)
              port map ('1', tempFraction_result, (5 downto 1 => '0') & tempFraction_result(24), tempFraction_result2);

    -- Correction to the fraction result, gain more accuracy (usualy more 0.00002 accuracy)
    stage_6 :  ADD_SUB generic map(25)
                  port map ('0', tempFraction_result2, (24 downto 1 => '0') & tempFraction_result(0), tempFraction_result3, temp2);

    -- Find the max exponent, for the exponent component of the result
    stage_7 : MUX_Nbits generic map(8)
              port map (expDiff(7), expA, expB, maxExponent);

    SUM(22 downto 0) <= tempFraction_result3(22 downto 0);

    SUM(31) <=   ((tempFraction_result2(23) OR expDiff(7)) and (((not OPP) and signB) OR ((not signB) and OPP)))
                  OR ((not expDiff(7)) and (not tempFraction_result2(23)) and signA);
----------------------------------------
end gate_level;

--EndOfFile
