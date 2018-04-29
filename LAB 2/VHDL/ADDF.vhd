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

component full_adder port (
          a :    in std_logic;
          b :    in std_logic;
          Cin :  in std_logic;
          sum :  out std_logic;
          Cout : out std_logic
          );
end component;


-- signals
--floating point components extraction
signal signA: std_logic;
signal signB: std_logic;
signal expA: std_logic_vector(7 downto 0);
signal expB: std_logic_vector(7 downto 0);
signal fractionA: std_logic_vector(22 downto 0);
signal fractionB: std_logic_vector(22 downto 0);



begin
----------------------------------------
    signA <= A(31);
    signB <= B(31);
    expA <= A(30 downto 23);
    expB <= B(30 downto 23);
    fractionA <= A(22 downto 0);
    fractionB <= B(22 downto 0);

    Array_Of_full_adders: for i in 0 to (N-1) generate
        stage_i : full_adder port map (A(i) , B(i) , tmp(i), SUM(i), tmp(i+1));
    end generate;
----------------------------------------
end gate_level;

--EndOfFile
