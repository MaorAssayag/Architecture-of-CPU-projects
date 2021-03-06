-- ====================================================================
--
--	File Name:		Testbench_SHR_ONER.vhd
--	Description:	test bench for Shift righ : input : N bits A ,output : N bits S
--
--
--	Date:			03/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.ALL;

ENTITY Testbench_SHR_ONE IS
END Testbench_SHR_ONE;

ARCHITECTURE behavior OF Testbench_SHR_ONE IS

 -- Component Declaration

 component SHR_ONE
 generic(N: integer := 8); --defualt value for N is 8
 port (
       A :     in signed(N-1 downto 0);
       Aout :   out signed(N-1 downto 0)
 );
end component;

 constant N : integer := 8;
 --Inputs
 signal A : signed((N-1) downto 0) ;

 --Outputs
 signal Aout : signed(N-1 downto 0);
begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: SHR_ONE PORT MAP (
   A => A,
   Aout => Aout
   );

   -- Stimulus process
   stim: process
   begin
     wait for 100 ns;
     A <= "10010010", "00010101" after 50 ns, "00001100" after 100 ns,"00001111" after 150 ns;
     wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;
