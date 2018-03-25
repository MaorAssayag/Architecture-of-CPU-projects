-- ====================================================================
--
--	File Name:		ADD.vhd
--	Description:	ADD command, currently support 4 bit only
--					
--
--	Date:			25/03/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
 
 -- entity Definition
entity adder is
     Port(
         A : in std_logic_vector(3 downto 0);
         B : in std_logic_vector(3 downto 0);
         SUM : out std_logic_vector(3 downto 0);
         CARRY : out std_logic
         );
end adder;

 -- Architecture Definition
architecture gate_level of adder is

Component full_adder is
    port (
          a : in std_logic;
          b : in std_logic;
          Cin : in std_logic;
          sum : out std_logic;
          Cout : out std_logic
          );
end component;       

signal s : std_logic_vector (2 downto 0);
-- TODO: foor loop
begin
    stage0 : full_adder port map (A(0) => a, B(0) =>b, '0'=>Cin, SUM(0)=>sum, s(0)=>Cout);
    stage1 : full_adder port map (A(1) => a, B(1) =>b, s(0)=>Cin, SUM(1)=>sum, s(1)=>Cout);
    stage2 : full_adder port map (A(2) => a, B(2) =>b, s(1)=>Cin, SUM(2)=>sum, s(2)=>Cout);
    stage3 : full_adder port map (A(3) => a, B(3) =>b, s(2)=>Cin, SUM(3)=>sum, CARRY=>Cout);
end adder;            

--EndOfFile