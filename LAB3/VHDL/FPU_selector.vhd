-- ====================================================================
--
--	File Name:		FPU_selector.vhd
--	Description:	FPU_selector
--
--
--	Date:			30/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 -- entity Definition
entity FPU_selector is
  generic(N: positive := 32);
  port(
    OPP :            in std_logic_vector (2 downto 0);
    MUL_result :     in signed (N-1 downto 0);
    ADD_SUB_result : in signed (N-1 downto 0);
    result :         out signed (N-1 downto 0));
end FPU_selector;

 -- Architecture Definition
architecture gate_level of FPU_selector is
begin
----------------------------------------
process (all)
begin
  case OPP is

    -- ALU performs FPU ADD, Function_opcode = 50 = 110010, ALU_ctl(OPP in this file) = 011
       when "011" =>
        result <= ADD_SUB_result;

    -- ALU performs FPU SUB, Function_opcode = 45 = 101101, ALU_ctl(OPP in this file) = 100
    -- ALU performs FPU slt, Function_opcode = 61 = 111101, ALU_ctl(OPP in this file) = 100
      when "100" =>
        result <= ADD_SUB_result; -- ADD FPU OPP "1010"

    -- ALU performs FPU MUL, Function_opcode = 47 = 101111, ALU_ctl(OPP in this file) = 101
       when "101"=>
        result <= MUL_result; -- MUL FPU OPP "1100"

       when others =>
        result <=(others => '0');
      end case;
end process;
----------------------------------------
end gate_level;

--EndOfFile
