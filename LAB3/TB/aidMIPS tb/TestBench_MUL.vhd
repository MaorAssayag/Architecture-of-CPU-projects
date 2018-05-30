-- ====================================================================
--
--	File Name:		TestBench_MUL.vhd
--	Description: test bench for MUL opp
--
--
--	Date:			10/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_MUL is
end Testbench_MUL;

architecture behavior of Testbench_MUL is

 -- Component Declaration
 component MUL
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
        A :     in signed((N-1) downto 0);
        B :     in signed((N-1) downto 0);
        result: out signed(2*N-1 downto 0));
  end component;

 constant N : integer := 8;
 signal x, y: signed((N-1) downto 0) ;
 signal result: signed((2*N-1) downto 0) ;

begin
----------------------------------------
  uut :  MUL  generic map(N)
    port map (x, y, result);

  stim: process
  begin
    wait for 100 ns;
    x <= "01000000", "11100001" after 50 ns, "01001100" after 100 ns,"11001111" after 150 ns;
    y <= "00000010", "00000011" after 50 ns, "11000010" after 100 ns,"00010001" after 150 ns;
    wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;

--EndOfFile
