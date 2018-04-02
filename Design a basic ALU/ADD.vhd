-- ====================================================================
--
--	File Name:		ADD.vhd
--	Description:	ADD command, currently support N bit's
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

 -- entity Definition
entity ADD is
    generic(N: integer := 8); --defualt value for N is 8
    port(
       A :     in std_logic_vector((N-1) downto 0);
       B :     in std_logic_vector((N-1) downto 0);
       SUM :   out std_logic_vector((N-1) downto 0);
       CARRY : out std_logic
       );
end ADD;

 -- Architecture Definition
architecture gate_level of ADD is
component full_adder port (
          a :    in std_logic;
          b :    in std_logic;
          Cin :  in std_logic;
          sum :  out std_logic;
          Cout : out std_logic
          );
end component;

signal tmp : std_logic_vector (N downto 0);
begin
----------------------------------------
    tmp(0) <= '0';
    
    Array_Of_full_adders: for i in 0 to (N-1) generate
        stage_i : full_adder port map (A(i) , B(i) , tmp(i), SUM(i), tmp(i+1));
    end generate;

    CARRY <= tmp(N); -- tmp(N-1+1) in the loop
----------------------------------------
end gate_level;

--EndOfFile
