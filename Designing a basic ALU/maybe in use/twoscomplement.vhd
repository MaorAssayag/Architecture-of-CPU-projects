-- ====================================================================
--
--	File Name:		twoscomplement.vhd
--	Description:	twos complement for binary signed number
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;

-- entity Definition
entity twoscomplement is
  generic (N : positive := 8 );
  Port (
     X : in  signed (N-1 downto 0);
     Y : out signed (N-1 downto 0)
  );
end entity twoscomplement;

-- Architecture Definition
architecture gate_level of twoscomplement is
begin
----------------------------------------
  Y <= -signed(X);
----------------------------------------
end architecture;
