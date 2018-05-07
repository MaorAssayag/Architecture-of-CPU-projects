-- ====================================================================
--
--	File Name:		Testbench_LeadingZeroes_counter.vhd
--	Description: test bench for LeadingZeroes_counter
--
--
--	Date:			29/04/2018
--	Designer's:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_LeadingZeroes_counter is
end Testbench_LeadingZeroes_counter;

architecture behavior of Testbench_LeadingZeroes_counter is

 -- Component Declaration
 component LeadingZeroes_counter
     port (
        Cin: in  std_logic;
        X :  in  signed (21 downto 0);
        dir: out std_logic;
        Y  : out signed (5 downto 0));
 end component;

 signal Cin :  std_logic := '0';
signal X :   signed (21 downto 0);
signal dir:  std_logic;
signal Y  :  signed (5 downto 0);

begin
----------------------------------------
  uut :  LeadingZeroes_counter
    port map (Cin,X,dir,Y);

  stim: process
  begin
    wait for 50 ns;
    X <= "0000001111101010101010" ;
    wait for 20 ns;

    X <= "0001010101010101010111" ;
    wait for 20 ns;

    X <= "0000000000000101010111" ;
    wait for 20 ns;

    X <= "0000001111101010101010" ;
    wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;

--EndOfFile
