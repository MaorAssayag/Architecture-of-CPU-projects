-- ====================================================================
--
--	File Name:		TestBench_HAZARD.vhd
--	Description: test bench for ALU unit
--
--
--	Date:			11/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_HAZARD is
end TestBench_HAZARD;

architecture behavior of TestBench_HAZARD is
  component HAZARD
  port (
        Instruction 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        data_hazard_en 		 : OUT 	STD_LOGIC;
        clock, reset	: IN 	STD_LOGIC
  );
 end component;

constant N : integer := 8;
signal clk : std_logic := '0';
signal Instruction :STD_LOGIC_VECTOR( 31 DOWNTO 0 );
signal data_hazard_en : std_logic;
--SIGNAL  dataH1,dataH2,dataH3	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
begin
----------------------------------------
  clock1: process
  begin
    clk <= '0';
    while (0 = 0) loop
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    clk <= '0';
    end loop;
  end process;
  uut :  HAZARD
    port map (
  Instruction => Instruction,
  data_hazard_en => data_hazard_en,
  clock => clk,
  reset => '0'
);

  INS: process
  begin
    wait for 10 ns;
    Instruction <= "10110110100010010001100001000000";
    wait for 20 ns;
    Instruction <= "10001000011001111111000000000001";
    wait for 100 ns;

  end process;
----------------------------------------
end behavior;

--EndOfFile
