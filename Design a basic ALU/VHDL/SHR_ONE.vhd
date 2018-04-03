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
use ieee.std_logic_1164.all;

 -- entity Definition
entity SHR_ONE is
  generic(N: integer := 8); --defualt value for N is 8
      Port (
          A :in std_logic_vector(N-1 downto 0);
          Aout : out std_logic_vector(N-1 downto 0)
          );
end SHR_ONE;

 -- Architecture Definition
architecture gate_level of SHR_ONE is
begin
  Aout <= A;
     -- loopforshift: for i in 1 to N-1 generate
     --   Aout(N-i) <= Aout(N-i-1);
     -- end generate;
     Aout(0) <= ;
end gate_level;

--EndOfFile
