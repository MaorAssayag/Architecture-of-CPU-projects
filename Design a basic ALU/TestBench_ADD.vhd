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
 component ADD
    Port(
       generic (N: INTEGER:=8); --defualt value for N is 8
       A :     in std_logic_vector(N-1 downto 0);
       B :     in std_logic_vector(N-1 downto 0);
       SUM :   out std_logic_vector(N-1 downto 0);
       CARRY : out std_logic
     );
    end component;

 signal CARRY : std_logic;
 signal x, y, result : std_logic_vector(7 downto 0);

begin
----------------------------------------
  stim: process
  begin
    x <= “00000000”, “00000001” after 50 ns, “00000101”, after 100 ns;
    y <= “00000010”, “00000011” after 50 ns, “00001010”, after 100 ns;
    wait;
  end process stim;

  UUT_ADDER :  ADD  generic map(8)
    port map (x, y, result, CARRY);
----------------------------------------
end;

--EndOfFile
