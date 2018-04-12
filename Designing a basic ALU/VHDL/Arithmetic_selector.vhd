-- ====================================================================
--
--	File Name:		Arithmetic_selector.vhd
--	Description:	Arithmetic_selector
--
--
--	Date:			12/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 -- entity Definition
entity Arithmetic_selector is
    generic(N: positive := 8); --defualt value for N is 8
    port(
      clk : in std_logic;
      OPP :   in std_logic_vector (2 downto 0);
      MUL_result : in signed (2*N-1 downto 0);
      MAX_MIN_LO : in signed ((N-1) downto 0);
      ADD_SUB_result : in signed (2*N-1 downto 0);
      HI : out signed ((N-1) downto 0);
      LO : out signed ((N-1) downto 0);
      FLAG_en : out std_logic); -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
end Arithmetic_selector;

 -- Architecture Definition
architecture gate_level of Arithmetic_selector is
begin
----------------------------------------
process (clk, OPP, MUL_result, MAX_MIN_LO, ADD_SUB_result)
begin
  if rising_edge(clk) then
  case OPP is
      when "000" =>
        HI <= ADD_SUB_result(2*N-1 downto N); -- MAC OPP
        LO <= ADD_SUB_result(N-1 downto 0);
        FLAG_en <= '0';

        when "001" =>
        HI <= MUL_result(2*N-1 downto N); -- MUL OPP
        LO <= MUL_result(N-1 downto 0);
        FLAG_en <= '0';

       when "010" | "011" =>
        HI <= (others => '0'); -- MAX/MIN OPP
        LO <= MAX_MIN_LO;
        FLAG_en <= '0';

        when "100" | "101"=>
        HI <= (others => '0'); -- ADD\SUB OPP
        LO <= ADD_SUB_result(N-1 downto 0);
        FLAG_en <= OPP(0); -- if SUB then update SYSTEM FLAGS

       when others =>
        HI <=(others => '0');
        LO <=(others => '0');
        FLAG_en <= '0';

      end case;
  end if;
end process;
----------------------------------------
end gate_level;

--EndOfFile
