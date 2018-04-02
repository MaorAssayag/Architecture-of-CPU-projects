-- ====================================================================
--
--	File Name:		ADD_SUB.vhd
--	Description:	ADD & SUB command, currently support N bit's
--                 OPP = 0 for ADD, 1 for SUB
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
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
       OPP :   in std_logic;
       A :     in signed ((N-1) downto 0);
       B :     in signed ((N-1) downto 0);
       SUM :   out signed ((N-1) downto 0);
       CARRY : out std_logic
       );
end ADD_SUB;

 -- Architecture Definition
architecture gate_level of ADD_SUB is
component twoscomplement
  generic (N : positive := 8 );
  Port (
     X : in  signed (N-1 downto 0);
     Y : out signed (N-1 downto 0)
  );
end component;

component MUX_addORsub
  generic (N : positive := 8 );
  Port (
     SEL: in  std_logic;
     B1 : in  signed (N-1 downto 0);
     B2 : in  signed (N-1 downto 0);
     Y  : out signed (N-1 downto 0)
  );
end component;

component ADD
  generic (N : positive := 8 );
  Port(
     A :     in signed((N-1) downto 0);
     B :     in signed((N-1) downto 0);
     SUM :   out signed((N-1) downto 0);
     CARRY : out std_logic
  );
end component;

signal B_2 : signed (N-1 downto 0);
signal B_final : signed (N-1 downto 0);
begin
----------------------------------------
  stage_0 : twoscomplement generic map(N)
   port map (X => B, Y => B_2);

  stage_1 : MUX_addORsub generic map(N)
   port map (SEL => OPP, B1 => B, B2 => B_2,Y =>B_final);

  stage_2 :  ADD  generic map(N)
    port map (A => A,B => B_final,SUM => SUM,CARRY => CARRY);
----------------------------------------
end gate_level;

--EndOfFile
