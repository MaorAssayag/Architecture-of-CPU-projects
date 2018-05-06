-- Test Bench for counter.
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use WORK. sample_package.ALL;

entity test_counter is
end test_counter;

architecture rtl of test_counter is
signal clk,enable : std_logic;	
signal q          : std_logic_vector (7 downto 0);
begin
        tester : counter
        port map(clk=>clk,
          enable => enable,q => q);
        
        testbench : process
        begin
        -- test output respones to several inputs.
          enable<='0', '1' after 5 ns; 
          wait;
        end process testbench;
        
        clock: process 
        begin
                clk <= '1';
                for i in 0 to 100000 loop 
                        wait for 10 ns;
                        clk <= not clk;			
                end loop;  
                wait;
        end process clock;
end architecture rtl;
