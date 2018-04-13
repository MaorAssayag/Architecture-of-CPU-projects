-- ====================================================================
--
--	File Name:		SHR_ONE.vhd
--	Description:	1 bit right
--
--
--	Date:			08/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.synthesize 2.png test bench 3. fill with '0' in Aout(0) ?
-- ====================================================================


-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity SHL_ONE is
  generic(N: integer := 8); --defualt value for N is 8
  port (
      A :in signed(N-1 downto 0);
      Aout : out signed(N-1 downto 0));
end SHL_ONE;

 -- Architecture Definition
architecture gate_level of SHL_ONE is
begin
-------------------------------------------
   Aout(N-1) <= A(N-1); -- signed number
   loopforshiftLEFT: for i in N-2 downto 1 generate
      Aout(i) <= A(i-1);
   end generate;
   Aout(0) <= '0' ;
-------------------------------------------
end gate_level;

--EndOfFile
