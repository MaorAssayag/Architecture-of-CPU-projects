-- ====================================================================
--
--	File Name:		Testbench_MUL_FPU.vhd
--	Description: test bench for MUL_FPU
--
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_MUL_FPU is
end Testbench_MUL_FPU;

architecture behavior of Testbench_MUL_FPU is

 -- Component Declaration
 component MUL_FPU
     generic(N: integer := 32); --defualt value for N is 32
     Port(
        A :     in signed((N-1) downto 0);
        B :     in signed((N-1) downto 0);
        SUM :   out signed((N-1) downto 0));
 end component;

 signal A :    signed(31 downto 0);
 signal B :    signed(31 downto 0);
 signal SUM :  signed(31 downto 0);
 signal expected : signed(31 downto 0);

begin
----------------------------------------
  uut :  MUL_FPU
    port map (A,B,SUM);

  stim: process
  begin
    wait for 50 ns;
    
    A <= "01000011000001100001000000000000" ; -- (=134.0625)
    B <= "11000000000100000000000000000000" ; -- (=-2.25)
    expected <= "11000011100101101101001000000000"; -- (=-301.640625)
    wait for 20 ns;

    A <= "11000001011010000000000000000000" ; -- (=-14.5)
    B <= "10111110110000000000000000000000" ; -- (=-0.375)
    expected <= "01000000101011100000000000000000"; -- (=5.4375)
    wait for 20 ns;

    A <= "01000000111100000000000000000000" ; -- (=7.5)
    B <= "01000001011110000000000000000000" ; -- (=15.5)
    expected <= "01000010111010001000000000000000"; -- (=116.25)
    wait for 50 ns;

  end process stim;
----------------------------------------
end behavior;

--EndOfFile
