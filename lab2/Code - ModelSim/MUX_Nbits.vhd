-- ====================================================================
--
--	File Name:		MUX_Nbits.vhd
--	Description:	2N-N MUX, if SEL='0' then Y = Y1 else Y= Y2
--
--
--	Date:			10/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity MUX_Nbits is
    generic(N: positive := 8); --defualt value for N is 8
    port (
           SEL: in  std_logic;
           Y1 : in  signed (N-1 downto 0);
           Y2 : in  signed (N-1 downto 0);
           Y  : out signed (N-1 downto 0));
end MUX_Nbits;

 -- Architecture Definition
architecture Behavioral of MUX_Nbits is
begin
----------------------------------------
process(SEL,Y1,Y2)
begin
    if (SEL = '0') then
      Y <= Y1;
    elsif (SEL = '1') then
      Y <= Y2;
    else
      Y <= (others => '0');
    end if;
end process;
----------------------------------------
end Behavioral;

--EndOfFile
