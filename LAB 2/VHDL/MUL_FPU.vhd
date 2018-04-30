-- ====================================================================
--
--	File Name:		MUL_FPU.vhd
--	Description:	MUL_FPU command (OPP=1100), currently support N bit's IEEE Standard 754 Floating Point Numbers
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

component LeadingZeroes_counter
    generic(N: positive := 8); --defualt value for N is 8
    port (
       X :  in  signed (N-1 downto 0);
       Y  : out signed (5 downto 0));
end component;


--floating point components extraction signals
signal signA: std_logic;
signal signB: std_logic;
signal expA: signed(8 downto 0);
signal expB: signed(8 downto 0);
signal fractionA: signed(24 downto 0); -- original value Normlize with 1 at MSB
signal fractionB: signed(24 downto 0); -- original value Normlize with 1 at MSB
signal bias : signed(8 downto 0) := "001111111"; -- bias = 127

--temp connection signals
signal expTemp: signed(8 downto 0); -- exponentA + exponentB
signal expResult : signed(8 downto 0); -- expTemp - bias
signal expResultNorm : signed(8 downto 0); -- expTemp - bias + Normlize
signal tempFraction_result : signed(49 downto 0); -- after 1 shift to the right if needed
signal Norm : signed(8 downto 0);
signal zeroesCount : signed (5 downto 0);
begin
----------------------------------------
    -- Floating point components extraction
    signA <= A(31);
    signB <= B(31);
    expA <= '0' & A(30 downto 23);
    expB <= '0' & B(30 downto 23);
    fractionA <= '0' & '1' & A(22 downto 0);
    fractionB <= '0' &'1' & B(22 downto 0);
    Norm <= (8 downto 1 => '0') & tempFraction_result(47);

    -- 1. Obtaining the sign; i.e. s1 xor s2
    SUM(31) <= signA xor signB;

    -- 2. Multiplying the significand(1.M1*1.M2 )
    stage_0 : MUL generic map (25)
              port map (fractionA, fractionB, tempFraction_result);

    -- 3. Normlize the fraction result
    stage_1 : LeadingZeroes_counter generic map (22)
              port map(tempFraction_result(49 downto 28),zeroesCount);

    SUM(22 downto 0) <= tempFraction_result((48-to_integer(zeroesCount)) downto (26-to_integer(zeroesCount)));

    -- 4. Adding the exponents; i.e. (E1 + E2 – Bias) + Normlize from the fraction
    stage_2 : ADD_SUB generic map (9)
              port map ('0', expA, expB, expTemp); -- E1+E2
    stage_3 : ADD_SUB generic map (9)
              port map ('1', expTemp, bias, expResult); -- E1+E2 -bias
    stage_4 : ADD_SUB generic map (9)
              port map ('0', expResult, Norm, expResultNorm);--result + fraction normlize

    SUM (30 downto 23) <= expResultNorm(7 downto 0);
----------------------------------------
end gate_level;

--EndOfFile
