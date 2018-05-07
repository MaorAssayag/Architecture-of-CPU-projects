-- ====================================================================
--
--	File Name:		ADD_SUB.vhd
--	Description:	ADD & SUB command, currently support N bit's
--                 addORsub = 0 for ADD, 1 for SUB
--
--
--	Date:			12/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


 -- entity Definition
entity ADD_SUB is
    generic(N: positive := 8); --defualt value for N is 8
    port(
       addORsub :   in std_logic;
       A :     in signed ((N-1) downto 0);
       B :     in signed ((N-1) downto 0);
       SUM :   out signed ((N-1) downto 0);
       Cout  :  out std_logic);
end ADD_SUB;

 -- Architecture Definition
architecture gate_level of ADD_SUB is

component ADD
  generic (N : positive := 8 );
  Port(
     Cin :   in std_logic;
     A :     in signed((N-1) downto 0);
     B :     in signed((N-1) downto 0);
     SUM :   out signed((N-1) downto 0);
     Cout : out std_logic);
end component;

component xor_gate
  port(
    a,b:in std_logic;
    c : out std_logic);
end component;

signal B_2 : signed (N-1 downto 0);
begin
----------------------------------------
  stage_0 : for i in 0 to N-1 generate
		            stage_i : xor_gate port map(B(i),addORsub,B_2(i));
            end generate;

  stage_1 :  ADD  generic map(N)
    port map (Cin => addORsub,A => A,B => B_2,SUM => SUM,Cout => Cout); -- A+B or A-B
----------------------------------------
end gate_level;

--EndOfFile
