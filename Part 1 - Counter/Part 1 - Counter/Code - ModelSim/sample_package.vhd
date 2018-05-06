library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

PACKAGE sample_package is
    component counter 
        port ( clk,enable : in std_logic;	
	             q          : out std_logic_vector (7 downto 0)); 
    end component; 
end sample_package;
