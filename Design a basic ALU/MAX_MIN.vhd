-- ====================================================================
--
--	File Name:		MAX_MIN.vhd
--	Description: In VHDL there are two built-in functions
--  MAXIMUM and MINIMUM that can be used to find the maximum or minimum
--  of two values respectively. These functions work on scalar types such as
--  STD_LOGIC_VECTOR and INTEGER as well as discrete array types
--  (arrays with INTEGER or enum types).
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;

-- entity Definition
entity MAX_MIN is
    Port(
        generic    (N: INTEGER:=8); --defualt value for N is 8
        Min_Max :  in  std_logic;
        A, B :     in  std_logic_vector(N-1 downto 0);
        result :   out std_logic_vector(N-1 downto 0));
end entity MAX_MIN;

-- Architecture Definition
architecture gate_level of MAX_MIN is

  begin
----------------------------------------

  process (A, B, Min_Max)
  begin
    if Min_Max = '0' then
      result <= MINIMUM(A, B);
    else
      result <= MAXIMUM(A, B);
    end if;
  end process;

----------------------------------------
end  gate_level;

--EndOfFile
