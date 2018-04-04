-- ====================================================================
--
--	File Name:		MUX_addORsub.vhd
--	Description:	MUX, if SEL='1' then in ADD B = twoscomplement else no change to B
--  B1 = B, B2 = twoscomplement(B)
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity MUX_addORsub is
    generic(N: positive := 8); --defualt value for N is 8
    Port (
           SEL: in  std_logic;
           Y1 : in  signed (N-1 downto 0);
           Y2 : in  signed (N-1 downto 0);
           Y  : out signed (N-1 downto 0)
    );
end MUX_addORsub;

 -- Architecture Definition
architecture Behavioral of MUX_addORsub is
begin
----------------------------------------
    Y <= Y2 when (SEL = '1') else Y1;
----------------------------------------
end Behavioral;

--EndOfFile
