-- ====================================================================
--
--	File Name:		Testbench_SHR.vhd
--	Description:	test bench for Shift righ : input : N bits A, N bits B ,output : N bits S
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
--
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY Testbench_SHR IS
END Testbench_SHR;

ARCHITECTURE behavior OF Testbench_SHR IS

 -- Component Declaration

 component SHR
 generic(N: integer := 8); --defualt value for N is 8
 port (
       A :     in signed(N-1 downto 0);
       B :     in signed(N-1 downto 0);
       result :   out signed(N-1 downto 0)
 );
end component;



 constant N : integer := 8;
 --Inputs
 signal A : signed(N-1 downto 0);
 signal B : signed(N-1 downto 0);

 --Outputs
 signal result : signed(N-1 downto 0);
begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   shift_comp : SHR PORT MAP (
   A => A,
   B => B,
   result => result
   );

   -- Stimulus process
   stim: process
   begin
     wait for 100 ns;
     A <= "10010000", "00010000" after 100 ns;
     B <= "00000101", "00000100" after 100 ns;
     wait;
  end process stim;
----------------------------------------
end behavior;
