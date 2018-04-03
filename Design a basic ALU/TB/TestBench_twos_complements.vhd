-- ====================================================================
--
--	File Name:		test_twoscomplement.vhd
--	Description:	test bench for twoscomplement VHDL (twos complement for binary signed number)
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
entity TestBench_twos_complements is
end entity;

-- Architecture Definition
architecture test of TestBench_twos_complements is
    signal A : signed (7 downto 0);
    signal Y : signed(7 downto 0);
begin
----------------------------------------
    stage : entity work.twoscomplement port map (X => A, Y=>Y);

    process
    begin
       for i in 0 to 255 loop
         A <= to_signed(i, A'length);
         wait for 1 ns;
         assert to_integer(Y) = -i severity error;
       end loop;
       report "tests done";
       wait;
     end process;
----------------------------------------
end architecture;
--EndOfFile
