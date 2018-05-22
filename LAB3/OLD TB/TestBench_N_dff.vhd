-- ====================================================================
--
--	File Name:		TestBench_N_dff.vhd
--	Description:	test bench for dff_1bit
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY TestBench_N_dff is
END TestBench_N_dff;

ARCHITECTURE behavior OF TestBench_N_dff IS

 -- Component Declaration

 component N_dff
     generic(N: integer := 8); --defualt value for N is 8
     port (
         clk : in std_logic;
         rst : in std_logic;
         D : in signed(N-1 downto 0);
         Q : out signed(N-1 downto 0));
 end component;

-- Global
constant N : integer := 8;
 --Inputs
 signal clk : std_logic := '0';
 signal rst : std_logic := '0';
 signal D : signed(N-1 downto 0);

 -- Outputs
 signal Q : signed(N-1 downto 0);

begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: N_dff port map (clk, rst, D, Q);

   -- Stimulus process
   stim: process
   begin
   -- hold reset state for 10 ns.
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   D <= "00000000";
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   D <= "00000011";
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   D <= "00000011";
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   D <= "00001100";
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   D <= "00110000";
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   D <= "00110000";
   wait for 10 ns;

   clk <= '1';
   rst <= '1';
   D <= "00110000";
   wait for 10 ns;

  end process stim;
----------------------------------------
end behavior;
