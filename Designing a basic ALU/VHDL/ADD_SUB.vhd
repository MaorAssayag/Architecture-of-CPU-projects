-- ====================================================================
--
--	File Name:		ADD_SUB.vhd
--	Description:	ADD & SUB command, currently support N bit's
--                 addORsub = 0 for ADD, 1 for SUB
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1. we need to out the carry?
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
       FLAG : inout std_logic_vector(5 downto 0);
       A :     in signed ((N-1) downto 0);
       B :     in signed ((N-1) downto 0);
       SUM :   out signed ((N-1) downto 0)
       );
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

signal B_2, tempSUM : signed (N-1 downto 0);
signal CARRY: std_logic;
begin
----------------------------------------
  stage_0 : for i in 0 to N-1 generate
		            stage_i : xor_gate port map(B(i),addORsub,B_2(i));
            end generate;

  stage_1 :  ADD  generic map(N)
    port map (Cin => addORsub,A => A,B => B_2,SUM => SUM,Cout => CARRY); -- A+B or A-B

  flag_handle : process
      variable FLAGS : std_logic_vector(7 downto 0) := "00000000";
      begin
      if (addORsub = '1') then
        FLAG <= FLAGS; -- will assign at the end of process
        FLAGS(0) := '1'; -- is A=B ?
        wait on tempSUM2;
        eachBit: for i in 0 to (N-1) loop
          FLAGS(0) := (FLAGS(0) AND (NOT tempSUM2(i)));
        end loop;
        FLAGS(1) := NOT FLAGS(0); -- A!=B
        FLAGS(2) := NOT tempSUM2(N-1);--A >= B if tempSUM(N-1)=0 then
        FLAGS(3) := FLAGS(2) AND FLAGS(1); -- A>B if A>=B & A!=B
        FLAGS(4) := NOT FLAGS(3);-- A<=B if !(A>B)
        FLAGS(5) := FLAGS(4) AND FLAGS(1); -- A<B if (A<=B & A!=B)
      end if;
  end process flag_handle;
----------------------------------------
end gate_level;

--EndOfFile