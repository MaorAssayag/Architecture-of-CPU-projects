-- ====================================================================
--
--	File Name:		FPU_selector.vhd
--	Description:	FPU_selector
--
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 -- entity Definition
entity FPU_selector is
  port(
    OPP :   in std_logic_vector (2 downto 0);
    MUL_result : in signed (N-1 downto 0);
    ADD_SUB_result : in signed (N-1 downto 0);
    result : out signed (N-1 downto 0));
end FPU_selector;

 -- Architecture Definition
architecture gate_level of FPU_selector is
begin
----------------------------------------
process (all)
begin
  if rising_edge(clk) then
  case OPP is
       when "010" =>
        result <= ADD_SUB_result;

        when "100"=>
        result <= MUL_result;

       when others =>
        result <=(others => '0');
      end case;
  end if;
end process;
----------------------------------------
end gate_level;

--EndOfFile
