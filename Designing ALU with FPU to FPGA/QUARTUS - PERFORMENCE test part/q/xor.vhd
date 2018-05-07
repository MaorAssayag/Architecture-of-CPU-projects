-- ====================================================================
--
--	File Name:		xor_gate.vhd
--	Description:	xor gate
--
--
--	Date:			08/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- entity Definition
entity xor_gate is
  port(
    a,b:in std_logic;
    c : out std_logic);
end xor_gate;

 -- Architecture Definition
architecture gate_level of xor_gate is
  begin
  -------------------------------------------
  c<=a xor b;
  -------------------------------------------
end gate_level;

--EndOfFile
