-- ====================================================================
--
--	File Name:		TestBench_FloatinPointNormlizer.vhd
--	Description: test bench for FloatinPointNormlizer
--
--
--	Date:			30/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_FloatinPointNormlizer is
end TestBench_FloatinPointNormlizer;

architecture behavior of TestBench_FloatinPointNormlizer is

 -- Component Declaration
 component FloatinPointNormlizer
     generic(N: positive := 8); --defualt value for N is 8
     port (
        A : in  signed (N-1 downto 0);
        B : in  signed (N-1 downto 0);
        Out1  : out signed (31 downto 0);
        Out2 :  out signed (31 downto 0));
 end component;

 signal A :    signed(7 downto 0);
 signal B :    signed(7 downto 0);
 signal Out1 : signed(31 downto 0);
 signal Out2 : signed(31 downto 0);
 signal expected1 : signed(31 downto 0);
 signal expected2 : signed(31 downto 0);
begin
----------------------------------------
  uut :  FloatinPointNormlizer
    port map (A,B,Out1, Out2);

  stim: process
  begin
    wait for 50 ns;
    A <= "01010111" ;
    B <= "01000101" ;
    expected1 <= "01000001101011100000000000000000";
    expected2 <= "01000001100010100000000000000000";
    wait for 20 ns;

    A <= "11010111" ;
    B <= "11000101" ;
    expected1 <= "11000001101011100000000000000000";
    expected2 <= "11000001100010100000000000000000";
    wait for 20 ns;

    A <= "00010111" ;
    B <= "00001101" ;
    expected1 <= "01000000101110000000000000000000";
    expected2 <= "01000000010100000000000000000000";
    wait for 20 ns;

  end process stim;
----------------------------------------
end behavior;

--EndOfFile
