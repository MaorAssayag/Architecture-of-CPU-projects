-- ====================================================================
--
--	File Name:		Testbench_SHL_ONE.vhd
--	Description:	test bench for Shift left : input : N bits A ,output : N bits S
--
--
--	Date:			08/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.ALL;

entity Testbench_SHL_ONE is
end Testbench_SHL_ONE;

architecture behavior of Testbench_SHL_ONE is

 -- Component Declaration

 component SHL_ONE
 generic(N: integer := 8); --defualt value for N is 8
 port (
       A :     in signed(N-1 downto 0);
       Aout :  out signed(N-1 downto 0));
end component;

 constant N : integer := 8;
 signal A : signed((N-1) downto 0); --Inputs
 signal Aout : signed(N-1 downto 0);  --Outputs
begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: SHL_ONE port map (A => A, Aout => Aout);

   -- Stimulus process
   stim: process
   begin
     wait for 100 ns;
     A <= "10010010", "00010101" after 50 ns, "00001100" after 100 ns,"00001111" after 150 ns;
     wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;
