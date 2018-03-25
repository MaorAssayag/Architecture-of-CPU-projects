-- ====================================================================
--
--	File Name:		counter.vhd
--	Description:	counter 
--					
--
--	Date:			25/03/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================
-- Test Bench for Counter.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity CounterTest is
end CounterTest;

architecture rtl of CounterTest is  

component counter port(
	clk,enable : in std_logic;	
	q  : out std_logic_vector (7 downto 0)); 
end component;  

constant numOfClockCounter: integer := 100000;
signal  clk, enable : std_logic;
signal  q_tester : std_logic_vector (7 downto 0);
begin
        tester : counter
        port map(clk=>clk, enable=>enable, q=>q_tester);
        
        testbench : process
        begin
          enable<= '1', '0' after 400 ns;
          wait;
        end process testbench;
        
        clock: process 
        begin
                clk <= '0';
                for i in 0 to numOfClockCounter loop 
                        wait for 10 ps;
                        clk <= not clk;			
                end loop;
                wait;
        end process clock;
end rtl;
