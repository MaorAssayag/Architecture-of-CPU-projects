-- ====================================================================
--
--	File Name:		Testbench_full_adder.vhd
--	Description:	test bench for full adder : input : 1 bit A, 1 bit B, 1 bit C_in
-- output : S 1 bit, c_out 1 bit
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Testbench_full_adder IS
END Testbench_full_adder;

ARCHITECTURE behavior OF Testbench_full_adder IS

 -- Component Declaration

 component full_adder
 port (
     A: IN std_logic;
     B : IN std_logic;
     Cin : IN std_logic;
     sum : OUT std_logic;
     Cout : OUT std_logic
 );
end component;

 --Inputs
 signal A : std_logic := '0';
 signal B : std_logic := '0';
 signal Cin : std_logic := '0';

 --Outputs
 signal S : std_logic;
 signal Cout : std_logic;

begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: full_adder PORT MAP (
   A => A,
   B => B,
   Cin => Cin,
   sum => S,
   Cout => Cout
   );

   -- Stimulus process
   stim: process
   begin
   -- hold reset state for 100 ns.
   wait for 100 ns;

   -- insert stimulus here
   A <= '1';
   B <= '0';
   Cin <= '0';
   wait for 10 ns;

   A <= '0';
   B <= '1';
   Cin <= '0';
   wait for 10 ns;

   A <= '1';
   B <= '1';
   Cin <= '0';
   wait for 10 ns;

   A <= '0';
   B <= '0';
   Cin <= '1';
   wait for 10 ns;

   A <= '1';
   B <= '0';
   Cin <= '1';
   wait for 10 ns;

   A <= '0';
   B <= '1';
   Cin <= '1';
   wait for 10 ns;

   A <= '1';
   B <= '1';
   Cin <= '1';
   wait for 10 ns;

  end process stim;
----------------------------------------
end behavior;
