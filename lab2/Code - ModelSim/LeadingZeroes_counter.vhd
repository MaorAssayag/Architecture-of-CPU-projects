-- ====================================================================
--
--	File Name:		LeadingZeroes_counter.vhd
--	Description: return the number of leading zeroes, i.e: for "0011" return 2. for "0111" return 1.
--
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity LeadingZeroes_counter is
    generic(N: positive := 8); --defualt value for N is 8
    port (
       X :  in  signed (N-1 downto 0);
       Y  : out signed (5 downto 0));
end LeadingZeroes_counter;

 -- Architecture Definition
architecture Behavioral of LeadingZeroes_counter is
begin
----------------------------------------
process(X)
variable count : integer :=0;
begin
  count := 0;
  for i in N-1 downto 0 loop
    if X(i)='1' then
      exit;
    elsif X(i)='0' then
      count := count + 1;
    else
      exit;
    end if;
  end loop;
   Y <= to_signed(count,7)(5 downto 0);
end process;
----------------------------------------
end Behavioral;
--EndOfFile
