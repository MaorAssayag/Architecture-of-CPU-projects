-- ====================================================================
--
--	File Name:		TestBench_dff_1bit.vhd
--	Description:	test bench for dff_1bit
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TestBench_dff_1bit is
END TestBench_dff_1bit;

ARCHITECTURE behavior OF TestBench_dff_1bit IS

 -- Component Declaration

 component dff_1bit
 port (
     clk : in std_logic;
     rst : in std_logic;
     d : in std_logic;
     q : out std_logic);
end component;

 --Inputs
 signal clk : std_logic := '0';
 signal rst : std_logic := '0';
 signal d : std_logic := '0';

 --Outputs
 signal q : std_logic;

begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: dff_1bit port map (clk, rst, d, q);

   -- Stimulus process
   stim: process
   begin
   -- hold reset state for 10 ns.
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   d <= '0';
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   d <= '0';
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   d <= '1';
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   d <= '1';
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   d <= '1';
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   d <= '1';
   wait for 10 ns;

   clk <= '1';
   rst <= '1';
   d <= '1';
   wait for 10 ns;

  end process stim;
----------------------------------------
end behavior;
