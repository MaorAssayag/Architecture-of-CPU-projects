-- ====================================================================
--
--	File Name:		FullAdder.vhd
--	Description:	2 bit full adder with carry in\out
--					
--
--	Date:			25/03/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
 
 -- entity Definition
entity FullAdder is
      Port ( 
          a : in std_logic; 
          b : in std_logic;
          Cin : in std_logic;
          s : out std_logic;
          Cout : out std_logic
          );
end FullAdder;

 -- Architecture Definition
architecture gate_level of FullAdder is
begin
     S <= a XOR b XOR Cin ;
     Cout <= (a AND b) OR (Cin AND a) OR (Cin AND b) ;
end gate_level;

--EndOfFile