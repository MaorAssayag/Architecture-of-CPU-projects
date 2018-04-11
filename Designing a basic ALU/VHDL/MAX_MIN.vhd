-- ====================================================================
--
--	File Name:		MAX_MIN.vhd
--	Description: In VHDL there are two built-in functions
--  MAXIMUM and MINIMUM that can be used to find the maximum or minimum
--  of two values respectively. These functions work on scalar types such as
--  STD_LOGIC_VECTOR and INTEGER as well as discrete array types
--  (arrays with INTEGER or enum types).
--  maxORmin = 0 -> C=max(A,B) , maxORmin = 1 -> C=min(A,B)
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity Definition
entity MAX_MIN is
    generic (N: INTEGER := 8); --defualt value for N is 8
    port(
        maxORmin : in  std_logic;
        FLAG : inout signed(5 downto 0);
        A, B :     in  signed(N-1 downto 0);
        result :   out signed(N-1 downto 0));
end entity MAX_MIN;

-- Architecture Definition
architecture gate_level of MAX_MIN is

  component ADD_SUB
      generic(N: positive := 8); --defualt value for N is 8
      port(
         addORsub :   in std_logic;
         FLAG : inout signed(5 downto 0);
         A :     in signed ((N-1) downto 0);
         B :     in signed ((N-1) downto 0);
         SUM :   out signed ((N-1) downto 0)
         );
  end component;
  signal tempSUM : signed(N-1 downto 0);
  begin
  ----------------------------------------
    stage_0 :  ADD_SUB  generic map(N)
      port map (addORsub => '1',FLAG => FLAG,A => A,B => B,SUM => tempSUM); -- A-B

    result <= B when (((maxORmin = '0') AND (FLAG(5) = '1')) OR ((maxORmin = '1') and (FLAG(3) = '1'))) else A;
  ----------------------------------------
  end gate_level;

--EndOfFile
