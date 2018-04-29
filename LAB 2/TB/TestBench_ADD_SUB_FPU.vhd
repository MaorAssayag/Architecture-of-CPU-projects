-- ====================================================================
--
--	File Name:		Testbench_ADD_SUB_FPU.vhd
--	Description: test bench for ADD_SUB_FPU
--
--
--	Date:			29/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_ADD_SUB_FPU is
end Testbench_ADD_SUB_FPU;

architecture behavior of Testbench_ADD_SUB_FPU is

 -- Component Declaration
 component ADD_SUB_FPU
     generic(N: integer := 32); --defualt value for N is 32
     Port(
        OPP : in std_logic;
        A :     in signed((N-1) downto 0);
        B :     in signed((N-1) downto 0);
        SUM :   out signed((N-1) downto 0));
 end component;

 signal OPP :  std_logic := '0';
 signal A :    signed(31 downto 0);
 signal B :    signed(31 downto 0);
 signal SUM :  signed(31 downto 0);

begin
----------------------------------------
  uut :  ADD_SUB_FPU
    port map (OPP,A,B,SUM);

  stim: process
  begin
    wait for 50 ns;
    A <= "01000011100000000000000000000000" ;
    B <= "01000011000000000000000000000011" ;
    wait for 20 ns;

    A <= "01000011010000000000000000000011" ;
    B <= "01000011000000000000000000000110" ;
    wait for 20 ns;

    A <= "01000111010000000000000000000011" ;
    B <= "01000011100000000000000000000110" ;
    wait for 20 ns;

    A <= "01000011000000000000000000001011" ;
    B <= "01000011000000000000000000000110" ;
    wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;

--EndOfFile
