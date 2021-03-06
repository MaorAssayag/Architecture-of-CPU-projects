-- ====================================================================
--
--	File Name:		TestBench_FPU_UNIT.vhd
--	Description: test bench for FPU_UNIT
--
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_FPU_UNIT is
end TestBench_FPU_UNIT;

architecture behavior of TestBench_FPU_UNIT is

 -- Component Declaration
 component FPU_Unit
     generic(N: positive := 32); --defualt value for N is 8
     port(
         OPP : in std_logic_vector (2 downto 0);
         A  : in signed(N-1 downto 0);
         B  : in signed(N-1 downto 0);
         result : out signed (N-1 downto 0));
 end component;

 signal OPP : std_logic_vector(2 downto 0) := "010"; -- ADD
 signal A :    signed(31 downto 0);
 signal B :    signed(31 downto 0);
 signal result :  signed(31 downto 0);
 signal expected : signed(31 downto 0);
begin
----------------------------------------
  uut :  FPU_Unit
    port map (OPP,A,B,result);

  stim: process
  begin
    -- ADD
    wait for 50 ns;
    A <= "01000011100000000000000000000000" ;
    B <= "01000011000000000000000000000011" ;
    expected <= "01000011110000000000000000000010";
    wait for 20 ns;

    A <= "01000011010000000000000000000011" ;
    B <= "01000011000000000000000000000110" ;
    expected <= "01000011101000000000000000000101";
    wait for 20 ns;

    -- MUL
    OPP <= "100";
    A <= "01000000111100000000000000000000" ; -- (=7.5)
    B <= "01000001011110000000000000000000" ; -- (=15.5)
    expected <= "01000010111010001000000000000000"; -- (=116.25)
    wait for 20 ns;

    A <= "11000001011010000000000000000000" ; -- (=-14.5)
    B <= "10111110110000000000000000000000" ; -- (=-0.375)
    expected <= "01000000101011100000000000000000"; -- (=5.4375)

  end process stim;
----------------------------------------
end behavior;

--EndOfFile
