-- ====================================================================
--
--	File Name:		Swap.vhd
--	Description:	Swap 2 numbers according to SEL bit. SEL=1 -> Out1=Y2,
--                Out2=Y1 else Out1=Y1,Out2=Y2.
--
--
--	Date:			29/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity Swap is
    generic(N: positive := 8); --defualt value for N is 8
    port (
           SEL: in  std_logic;
           Y1 : in  signed (N-1 downto 0);
           Y2 : in  signed (N-1 downto 0);
           Out1  : out signed (N-1 downto 0)
           Out2 :  out signed (N-1 downto 0));
end Swap;

 -- Architecture Definition
architecture Behavioral of Swap is
begin
----------------------------------------
process(SEL,Y1,Y2)
begin
    if (SEL = '0') then
      Out1 <= Y1;
      Out2 <= Y2;
    elsif (SEL = '1') then
      Out1 <= Y2;
      Out2 <= Y1;
    else
      Out1 <= (others => '0');
      Out2 <= (others => '0');
    end if;
end process;
----------------------------------------
end Behavioral;

--EndOfFile
