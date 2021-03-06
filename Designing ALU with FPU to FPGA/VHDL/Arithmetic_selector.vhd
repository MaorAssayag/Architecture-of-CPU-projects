-- ====================================================================
--
--	File Name:		Arithmetic_selector.vhd
--	Description:	Arithmetic_selector
--
--
--	Date:			06/05/2018
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
      LO : out signed ((N-1) downto 0);
      HI : out signed ((N-1) downto 0);
      FLAG_en : out std_logic); -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
end Arithmetic_selector;

 -- Architecture Definition
architecture gate_level of Arithmetic_selector is
begin
----------------------------------------
process (all)
variable mac_temp : std_logic := '0';
begin
  if rising_edge(clk) then
  case OPP is
        when "000" =>
          if (mac_temp) then
            HI <= ADD_SUB_result(2*N-1 downto N); -- MAC OPP
            LO <= ADD_SUB_result(N-1 downto 0);
            FLAG_en <= '0';
            mac_temp := '0';
          else
            mac_temp := '1';
          end if;

        when "001" =>
        HI <= MUL_result(2*N-1 downto N); -- MUL OPP
        LO <= MUL_result(N-1 downto 0);
        FLAG_en <= '0';

        when "010" =>
        HI <= (others => '0'); -- MAX OPP
        LO <= MAX_MIN_LO;
        FLAG_en <= '0';

        when "011" =>
        HI <= (others => '0'); -- MIN OPP
        LO <= MAX_MIN_LO;
        FLAG_en <= '0';

        when "100"=>
        HI <= (others => '0'); -- ADD OPP
        LO <= ADD_SUB_result(N-1 downto 0);
        FLAG_en <= '0'; -- if SUB then update SYSTEM FLAGS

        when "101"=>
        HI <= (others => '0'); -- SUB OPP
        LO <= ADD_SUB_result(N-1 downto 0);
        FLAG_en <= '1'; -- if SUB then update SYSTEM FLAGS

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
