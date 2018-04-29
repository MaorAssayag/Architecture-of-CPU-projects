-- ====================================================================
--
--	File Name:		ADD_SUB_FPU.vhd
--	Description:	ADD\SUB command, currently support N bit's IEEE Standard 754 Floating Point Numbers
--  Floating Point Components       Sign   	Exponent  	Fraction
--               Single Precision 	1 [31] 	8 [30–23] 	23 [22–00]
--               OPP=1 -> SUB, OPP=0 -> ADD
--
--	Date:			29/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
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
       SUM :   out signed((N-1) downto 0);
       Cout :  out std_logic);
end ADD_SUB_FPU;

 -- Architecture Definition
architecture gate_level of ADD_SUB_FPU is

-- Components
component ADD_SUB is
    generic(N: positive := 8); --defualt value for N is 8
    port(
       addORsub :   in std_logic;
       A :     in signed ((N-1) downto 0);
       B :     in signed ((N-1) downto 0);
       SUM :   out signed ((N-1) downto 0));
end component;


--floating point components extraction signals
signal signA: std_logic;
signal signB: std_logic;
signal expA: std_logic_vector(7 downto 0);
signal expB: std_logic_vector(7 downto 0);
signal fractionA: std_logic_vector(22 downto 0);
signal fractionB: std_logic_vector(22 downto 0);

--temp connection signals
signal expDiff: std_logic_vector(7 downto 0);


begin
----------------------------------------
    signA <= A(31);
    signB <= B(31);
    expA <= A(30 downto 23);
    expB <= B(30 downto 23);
    fractionA <= A(22 downto 0);
    fractionB <= B(22 downto 0);

    -- Find the difference between the Exponent of A and B : expA - expB, default N=8 bits
    stage_0 : ADD_SUB
              port map ('1', expA, expB, expDiff);

    -- Exponent alligenment preparation : Prepare the fraction of the Number with the min exponent to be shifted

----------------------------------------
end gate_level;

--EndOfFile
