-- ====================================================================
--
--	File Name:		TestBench_MAX_MIN.vhd
--	Description: test bench for MAX_MIN opp
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.check in MODELSIM
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_MAX_MIN is
end Testbench_MAX_MIN;

architecture behavior of Testbench_MAX_MIN is

 -- Component Declaration
 component MAX_MIN
 port (
     generic    (N: INTEGER:=8); --defualt value for N is 8
     maxORmin : in  std_logic;
     A, B :     in  std_logic_vector(N-1 downto 0);
     result :   out std_logic_vector(N-1 downto 0));
 );
 end component;

 signal maxORmin : std_logic;
 signal A, B, result : std_logic_vector(7 downto 0);

begin
----------------------------------------
  stim: process
  begin
    for i in 1 to 2**7-1 loop
      maxORmin <= i mod 2; -- 0 or 1 for MAX or MIN commands
      A <= std_logic_vector(TO_UNSIGNED(i,7));
      B <= std_logic_vector(TO_UNSIGNED((i - 1),7)); -- B=A-1
      wait for 50 ns;
    end loop;
    wait;
  end process stim;

  UUT_MIN_MAX :  MAX_MIN  generic map(8)
    port map (maxORmin, A, B, result);
----------------------------------------
end;

--EndOfFile
