-- ====================================================================
--
--	File Name:		Testbench_shift_unit.vhd
--	Description:	test bench for Shift left/right : input : N bits A, N bits B ,output : N bits S
--
--
--	Date:			08/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 -- entity Definition
entity Testbench_shift_unit is
end Testbench_shift_unit;

ARCHITECTURE behavior OF Testbench_shift_unit IS

 -- Component Declaration
 component shift_unit
    generic(N: integer := 8); --defualt value for N is 8
    port(
      dir :    in std_logic;
      A :      in signed(N-1 downto 0);
      B :      in signed(5 downto 0);
      result : out signed(N-1 downto 0));
end component;

 constant N : integer := 8;
 signal A : signed(N-1 downto 0);  --Inputs
 signal B : signed(5 downto 0);
 signal dir : std_logic := '0';
 signal result : signed(N-1 downto 0);  --Output
begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   shift_comp : shift_unit generic map (N) port map (dir,A, B,result);

   -- Stimulus process
   stim: process
   begin
     wait for 10 ns;
     A <= "10010011", "00010110" after 100 ns, "10010011" after 150 ns, "00010110" after 200 ns;
     B <= "000101", "000100" after 100 ns, "000100" after 150 ns, "000100" after 200 ns;
     dir <= '1' after 150 ns, '1' after 200 ns;
     wait;
  end process stim;
----------------------------------------
end behavior;
