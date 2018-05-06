-- ====================================================================
--
--	File Name:		counter.vhd
--	Description:	counter - aid component for testing hardware like the mac
--
--
--	Date:			06/05/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

 -- entity Definition
entity counter is port (
	clk,enable : in std_logic;
  HEX1 : out std_logic_vector (6 downto 0));
end counter;

 -- Architecture Definition
architecture rtl of counter is
signal q_int : std_logic_vector (31 downto 0):=x"00000000";
begin
----------------------------------------
    process (clk)
    begin
        if (rising_edge(clk)) then
           if enable = '1' then
		        q_int <= q_int + 1;
           end if;
	     end if;
    end process;
		HEX1 <= q_int(16 downto 10);
----------------------------------------
end rtl;

--EndOfFile
