-- ====================================================================
--
--	File Name:		SHR_ONE.vhd
--	Description:	1 bit right
--
--
--	Date:			03/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;

 -- entity Definition
entity SHR_ONE is
  generic(N: integer := 8); --defualt value for N is 8
      Port (
          A :in signed(N-1 downto 0);
          Aout : out signed(N-1 downto 0)
          );
end SHR_ONE;

 -- Architecture Definition
architecture gate_level of SHR_ONE is
begin
     loopforshift: for i in 1 to N-1 generate
       Aout(N-i-1) <= A(N-i);
     end generate;
     Aout(N-1) <= A(N-1) ; -- signed numbers
end gate_level;

--EndOfFile
