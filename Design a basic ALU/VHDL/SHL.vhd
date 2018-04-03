-- ====================================================================
--
--	File Name:		SHL.vhd
--	Description:	Shift left command, currently support N bit's
--
--
--	Date:			03/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- use ieee.Std_logic_arith.all;

 -- entity Definition
entity SHL is
    generic(N: integer := 8); --defualt value for N is 8
    port(
       A :     in std_logic_vector(N-1 downto 0);
       B :     in std_logic_vector(N-1 downto 0);
       Shift :   out std_logic_vector(N-1 downto 0)
       );
end SHL;

 -- Architecture Definition
architecture gate_level of SHL is
begin
----------------------------------------
Shift <= std_logic_vector(A srl conv_integer(B));

----------------------------------------
end gate_level;

--EndOfFile
