-- ====================================================================
--
--	File Name:		TestBench_MAC.vhd
--	Description: test bench for MAC opp
--
--
--	Date:			10/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_MAC is
end Testbench_MAC;

architecture behavior of Testbench_MAC is

 -- Component Declaration
 component MAC
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
        A :     in signed((N-1) downto 0);
        B :     in signed((N-1) downto 0);
        MACHI :   in signed((N-1) downto 0);
        MACLO : in signed((N-1) downto 0);
        HI :   out signed((N-1) downto 0);
        LO : out signed((N-1) downto 0)
     );
  end component;

 constant N : integer := 8;
 signal x, y,MACHI,MACLO, HI,LO : signed((N-1) downto 0) ;

begin
----------------------------------------
  uut :  MAC  generic map(N)
    port map (A => x,B => y,MACHI => MACHI,MACLO =>MACLO,HI => HI,LO => LO);

  stim: process
  begin
    wait for 100 ns;
    x <= "01000000", "11100001" after 50 ns, "01001100" after 100 ns,"11001111" after 150 ns;
    MACHI <="01000000", "11101001" after 50 ns, "01001100" after 100 ns,"11011111" after 150 ns;
    MACLO <= "01001000", "11100001" after 50 ns, "11001100" after 100 ns,"11001111" after 150 ns;
    y <= "00000010", "00000011" after 50 ns, "11000010" after 100 ns,"00010001" after 150 ns;
    wait;
  end process stim;
----------------------------------------
end behavior;

--EndOfFile
