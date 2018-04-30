-- ====================================================================
--
--	File Name:		MUL_FPU.vhd
--	Description:	MUL_FPU command, currently support N bit's IEEE Standard 754 Floating Point Numbers
--  Floating Point Components       Sign   	Exponent  	Fraction
--               Single Precision 	1 [31] 	8 [30–23] 	23 [22–00]
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- TODO : test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity MUL_FPU is
    generic(N: integer := 32); --defualt value for N is 32
    Port(
       A :     in signed((N-1) downto 0);
       B :     in signed((N-1) downto 0);
       SUM :   out signed((N-1) downto 0));
end MUL_FPU;

 -- Architecture Definition
architecture gate_level of MUL_FPU is

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

component MUL
    generic(N: integer := 8); --defualt value for N is 8
    Port(
       A :     in signed(N-1 downto 0);
       B :     in signed(N-1 downto 0);
       result: out signed(2*N-1 downto 0));
end component;

--floating point components extraction signals
signal signA: std_logic;
signal signB: std_logic;
signal expA: signed(8 downto 0);
signal expB: signed(8 downto 0);
signal fractionA: signed(22 downto 0); -- original value
signal fractionB: signed(22 downto 0); -- original value
signal bias : signed(7 downto 0) := "01111111"; -- bias = 127

--temp connection signals
signal expTemp: signed(8 downto 0); -- exponentA + exponentB
signal expResult : signed(8 downto 0); -- expTemp - bias
signal expResultNorm : signed(8 downto 0); -- expTemp - bias + Normlize
signal tempFraction_result : signed(47 downto 0); -- after 1 shift to the right if needed
begin
----------------------------------------
    -- Floating point components extraction
    signA <= A(31);
    signB <= B(31);
    expA <= '0' & A(30 downto 23);
    expB <= '0' & B(30 downto 23);
    fractionA <= A(22 downto 0);
    fractionB <= B(22 downto 0);

    -- 1. Obtaining the sign; i.e. s1 xor s2
    SUM(31) <= signA xor signB;

    -- 2. Multiplying the significand(1.M1*1.M2 )
    stage_2 : MUL generic map (24)
              port map ('1' & fractionA, '1' & fractionB, tempFraction_result);

    -- 3. Normlize the fraction result
    SUM(22 downto 0) <= tempFraction_result(45 downto 23);

    -- 4. Adding the exponents; i.e. (E1 + E2 – Bias) + Normlize from the fraction
    stage_0 : ADD_SUB generic map (9)
              port map ('0', expA, expB, expTemp); -- E1+E2
    stage_1 : ADD_SUB generic map (9)
              port map ('1', expTemp, bias, expResult); -- E1+E2 -bias
    stage_3 : ADD_SUB generic map (9)
              port map ('0', expResult, (8 downto 1 =>'0') & tempFraction_result(48), expResultNorm);--result + fraction normlize

    SUM (30 downto 23) <= expResultNorm(7 downto 0);
----------------------------------------
end gate_level;

--EndOfFile
