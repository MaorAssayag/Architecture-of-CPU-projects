-- ====================================================================
--
--	File Name:		MAX_MIN.vhd
--	Description:
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;

-- entity Definition
entity MAX_MIN is
  port (
      mm   : in  std_logic;
      A, B : in  std_logic_vector(2 downto 0);
      C    : out std_logic_vector(2 downto 0));
end entity MAX_MIN;

-- Architecture Definition
architecture gate_level of MAX_MIN is
  signal S1 : NATURAL;
  signal S2 : CHARACTER;
  signal S3 : CHARACTER;
begin
----------------------------------------

  process (A, B, MM)
  begin
    if MM = '0' then
      C <= MINIMUM(A, B);
    else
      C <= MAXIMUM(A, B);
    end if;
  end process;

----------------------------------------
end  gate_level;

--EndOfFile
