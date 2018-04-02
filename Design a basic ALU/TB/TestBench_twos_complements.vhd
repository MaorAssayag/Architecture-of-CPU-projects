entity test_twoscomplement is
end entity;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
architecture test of test_twoscomplement is
    signal A : signed (7 downto 0);
    signal Y : signed(7 downto 0);
begin
    dut : entity work.twoscomplement port map (A => A, Y=>Y); 

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
end architecture;