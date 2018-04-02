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
entity adder is
    generic(N: integer := 8); --defualt value for N is 8
    port(
       A :     in std_logic_vector(N-1 downto 0);
       B :     in std_logic_vector(N-1 downto 0);
       SUM :   out std_logic_vector(N-1 downto 0);
       CARRY : out std_logic
       );
end adder;

 -- Architecture Definition
architecture gate_level of adder is
component full_adder is port (
          a :    in std_logic;
          b :    in std_logic;
          Cin :  in std_logic;
          sum :  out std_logic;
          Cout : out std_logic
          );
end component;

signal tmp : std_logic_vector (N-1 downto 0);
begin
----------------------------------------
    stage_0 : full_adder port map (A(0) , B(0) , '0', SUM(0), tmp(0));

    Array_Of_full_adders: for i in 1 to (N-2) generate
        stage_i : full_adder port map (A(i) , B(i) , tmp(i-1), SUM(i), tmp(i));
    end generate;

    stage_final : full_adder port map (A(N-1) , B(N-1) , tmp(N-2), SUM(N-1), CARRY);
----------------------------------------
end gate_level;

--EndOfFile
