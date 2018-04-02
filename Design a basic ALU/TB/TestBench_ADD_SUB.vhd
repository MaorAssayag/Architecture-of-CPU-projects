-- ====================================================================
--
--	File Name:		TestBench_ADD_SUB.vhd
--	Description: test bench for ADD & SUB opp
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_ADD_SUB is
end Testbench_ADD_SUB;

architecture behavior of Testbench_ADD_SUB is

 -- Component Declaration
 component ADD_SUB
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
  signal OPP : std_logic := '1';
  signal x, y, result : signed((N-1) downto 0) ;

  begin
  ----------------------------------------
   uut :  ADD_SUB  generic map(N)
     port map (OPP => OPP, A => x,B => y,SUM => result,CARRY => C);

   stim: process
   begin
     wait for 100 ns;
     x <= "00000000", "00000001" after 50 ns, "00001100" after 100 ns,"00010000" after 150 ns,"00000000" after 200 ns;
     y <= "00000010", "00000011" after 50 ns, "00000010" after 100 ns,"00000100" after 150 ns,"00000011" after 200 ns;
     wait for 50 ns;
   end process stim;
  ----------------------------------------
  end behavior;

  --EndOfFile