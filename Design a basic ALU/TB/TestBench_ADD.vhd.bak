-- ====================================================================
--
--	File Name:		TestBench_ADD.vhd
--	Description: test bench for MAX_MIN opp
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.check in MODELSIM
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_ADD is
end Testbench_ADD;

architecture behavior of Testbench_ADD is

 -- Component Declaration
 component ADD
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
      OPP :   in std_logic;
      A :     in signed ((N-1) downto 0);
      B :     in signed ((N-1) downto 0);
      SUM :   out signed ((N-1) downto 0);
      CARRY : out std_logic
     );
  end component;

 constant N : integer := 8;
 signal C : std_logic;
 signal x, y, result : signed((N-1) downto 0) ;

begin
----------------------------------------
  uut :  ADD  generic map(N)
    port map (A => x,B => y,SUM => result,CARRY => C);

  stim: process
  begin
    wait for 100 ns;
    x <= "00000000", "00000001" after 50 ns, "00001100" after 100 ns,"00001111" after 150 ns;
    y <= "00000010", "00000011" after 50 ns, "00000010" after 100 ns,"00010000" after 150 ns;
    wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;

--EndOfFile
