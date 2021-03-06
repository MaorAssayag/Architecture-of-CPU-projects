-- ====================================================================
--
--	File Name:		full_adder.vhd
--	Description:	2 bit full adder with carry in\out
--
--
--	Date:			25/03/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;

 -- entity Definition
entity full_adder is
      Port (
          a : in std_logic;
          b : in std_logic;
          Cin : in std_logic;
          sum : out std_logic;
          Cout : out std_logic
          );
end full_adder;

 -- Architecture Definition
architecture gate_level of full_adder is
begin
     sum <= a XOR b XOR Cin ;
     Cout <= (a AND b) OR (Cin AND a) OR (Cin AND b) ;
end gate_level;

--EndOfFile
