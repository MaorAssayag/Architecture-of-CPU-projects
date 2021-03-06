-- ====================================================================
--
--	File Name:		dff_1bit.vhd
--	Description:	1 bit dff
--
--
--	Date:			12/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;

 -- entity Definition
entity dff_1bit is
    port (
        clk : in std_logic;
        en : in std_logic;
        rst : in std_logic;
        d : in std_logic;
        q : out std_logic);
end dff_1bit;

 -- Architecture Definition
architecture behavioral of dff_1bit is
signal clock_tmp : std_logic;
begin
----------------------------------------
process(clk)
begin
  if rising_edge(clk) then
    if (rst = '1') then
        q <= '0';
	 elsif (en = '1') then
        q <= d;
    end if;
  end if;
end process;
----------------------------------------
end behavioral;

--EndOfFile
