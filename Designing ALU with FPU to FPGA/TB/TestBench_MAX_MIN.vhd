-- ====================================================================
--
--	File Name:		TestBench_MAX_MIN.vhd
--	Description: test bench for MAX_MIN opp
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_MAX_MIN is
end Testbench_MAX_MIN;

architecture behavior of Testbench_MAX_MIN is

 -- Component Declaration
 component MAX_MIN
 generic(N: integer := 8); --defualt value for N is 8
 port (
   maxORmin : in  std_logic;
   A, B :     in  signed(N-1 downto 0);
   result :   out signed(N-1 downto 0));
 end component;

 signal maxORmin : std_logic;
 signal A, B, result : signed(7 downto 0);

begin
----------------------------------------
  stim: process
  begin
    for i in 1 to 2**4-1 loop
      maxORmin <= '0';
      A <= to_signed(i,8);
      B <= to_signed(i - 1,8); -- B=A-1
      wait for 1 ns;
    end loop;
    for i in 1 to 2**4-1 loop
      maxORmin <= '1';
      A <= to_signed(i,8);
      B <= to_signed(i - 1,8); -- B=A-1
      wait for 1 ns;
    end loop;
    wait;
  end process stim;

  UUT_MIN_MAX :  MAX_MIN  generic map(8)
    port map (maxORmin, A, B, result);
----------------------------------------
end;

--EndOfFile
