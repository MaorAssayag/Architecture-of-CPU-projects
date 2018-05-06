-- ====================================================================
--
--	File Name:		TestBench_reg_8bit.vhd
--	Description:	test bench for reg_8bit
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TestBench_reg_8bit is
END TestBench_reg_8bit;

ARCHITECTURE behavior OF TestBench_reg_8bit IS

 -- Component Declaration

 component reg_8bit
 port (
     clk : in std_logic;
     en : in std_logic;
     rst : in std_logic;
     d : in STD_LOGIC_VECTOR(7 DOWNTO 0);
     q : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

 --Inputs
 signal clk : std_logic := '0';
 signal en : std_logic := '0';
 signal rst : std_logic := '0';
 signal d : STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";


 --Outputs
 signal q : STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: reg_8bit port map (clk, en,rst, d, q);

   -- Stimulus process
   stim: process
   begin
   -- hold reset state for 10 ns.
   wait for 10 ns;

   clk <= '1';
   en <= '1';
   rst <= '0';
   d <= "01000000";
   wait for 10 ns;

   clk <= '0';
   en <= '1';
   rst <= '0';
   d <= "00100000";
   wait for 10 ns;

   clk <= '1';
   en <= '1';
   rst <= '0';
   d <= "00000001";
   wait for 10 ns;

   clk <= '0';
   en <= '1';
   rst <= '0';
   d <= "00000100";
   wait for 10 ns;

   clk <= '1';
   en <= '0';
   rst <= '0';
   d <= "00000010";
   wait for 10 ns;

   clk <= '0';
   en <= '1';
   rst <= '0';
   d <= "00000011";
   wait for 10 ns;

   clk <= '1';
   en <= '1';
   rst <= '0';
   d <= "00000011";
   wait for 10 ns;

   clk <= '0';
   en <= '1';
   rst <= '0';
   d <= "11110000";
   wait for 10 ns;

   clk <= '1';
   en <= '1';
   rst <= '1';
   d <= "00111000";
   wait for 10 ns;

  end process stim;
----------------------------------------
end behavior;
