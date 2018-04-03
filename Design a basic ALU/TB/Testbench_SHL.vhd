-- ====================================================================
--
--	File Name:		Testbench_SHL.vhd
--	Description:	test bench for Shift left : input : N bits A, N bits B ,output : N bits S
--
--
--	Date:			03/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
--
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Testbench_SHL IS
END Testbench_SHL;

ARCHITECTURE behavior OF Testbench_SHL IS

 -- Component Declaration

 component SHL
 generic(N: integer := 8); --defualt value for N is 8
 port (
       A :     in std_logic_vector(N-1 downto 0);
       B :     in std_logic_vector(N-1 downto 0);
       Shift :   out std_logic_vector(N-1 downto 0)
 );
end component;



 constant N : integer := 8;
 --Inputs
 signal A : std_logic_vector(N-1 downto 0);
 signal B : std_logic_vector(N-1 downto 0);

 --Outputs
 signal Shift : std_logic_vector(N-1 downto 0);
begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: SHL PORT MAP (
   A => A,
   B => B,
   Shift => Shift
   );

   -- Stimulus process
   stim: process
   begin
     wait for 100 ns;
     A <= "00011000", "00010001" after 50 ns, "00101100" after 100 ns,"01001111" after 150 ns;
     B <= "00000010", "00000011" after 50 ns, "00000110" after 100 ns,"00000100" after 150 ns;
     wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;
