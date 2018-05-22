-- ====================================================================
--	File Name:		slt_FPU.vhd
--	Description:	slt (set if less than) FPU command , currently support N bit's IEEE Standard 754 Floating Point Numbers
--  Floating Point Components       Sign   	Exponent  	Fraction
--               Single Precision 	1 [31] 	8 [30–23] 	23 [22–00]
--
--	Date:			22/05/2018
--	Designers:		Maor Assayag, Refael Shetrit
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity slt_FPU is
    generic(N: integer := 32); --defualt value for N is 32
    Port(
      A :     in signed((N-1) downto 0);
      B :     in signed((N-1) downto 0);
      result :   out std_logic);
end slt_FPU;

 -- Architecture Definition
architecture gate_level of slt_FPU is

-- Components
component ADD_SUB_FPU
    generic(N: integer := 32); --defualt value for N is 32
    Port(
      OPP : in std_logic;
      A :     in signed((N-1) downto 0);
      B :     in signed((N-1) downto 0);
      SUM :   out signed((N-1) downto 0));
end component;

--temp connection signals
signal SUB_result: signed(31 downto 0); -- A - B
begin
----------------------------------------
    -- Find the difference between A and B -> A-B
    stage_0 : ADD_SUB_FPU
              port map ('1', A, B, SUB_result);

    -- result is the sign bit
    result <= SUB_result(31);
----------------------------------------
end gate_level;

--EndOfFile
