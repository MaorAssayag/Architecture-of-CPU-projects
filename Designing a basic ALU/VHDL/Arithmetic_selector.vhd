-- ====================================================================
--
--	File Name:		Arithmetic_selector.vhd
--	Description:	Arithmetic_selector
--
--
--
--	Date:			10/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


 -- entity Definition
entity Arithmetic_selector is
    generic(N: positive := 8); --defualt value for N is 8
    port(
       OP :   in std_logic_vector (2 downto 0);
       MUL_HI : in signed ((N-1) downto 0);
       MUL_LO : in signed ((N-1) downto 0);
       MAC_HI : in signed ((N-1) downto 0);
       MAC_LO : in signed ((N-1) downto 0);
       MAX_LO : in signed ((N-1) downto 0);
       MIN_LO : in signed ((N-1) downto 0);
       ADD_LO : in signed ((N-1) downto 0);
       SUB_LO : in signed ((N-1) downto 0);
       HI : out signed ((N-1) downto 0);
       LO : out signed ((N-1) downto 0)
       );
end Arithmetic_selector;

 -- Architecture Definition
architecture gate_level of Arithmetic_selector is
begin
----------------------------------------
select : process
begin
wait on OP;
if (OP = "000") then
  wait on MUL_HI;
  wait on MUL_LO;
  HI <= MUL_HI;
  LO <= MUL_LO;
elsif (OP = "001") then
  wait on MAC_HI;
  wait on MAC_LO;
  HI <= MAC_HI;
  LO <= MAC_LO;
elsif (OP = "010") then
  wait MAX_LO;
  HI <=(others => '0');
  LO <= MAX_LO;
elsif (OP = "011") then
  wait MIN_LO;
  HI <=(others => '0');
  LO <= MIN_LO;
elsif (OP = "100") then
  wait ADD_LO;
  HI <=(others => '0');
  LO <= ADD_LO;
elsif (OP = "101") then
  wait SUB_LO;
  HI <=(others => '0');
  LO <= SUB_LO;
end if;
end process;

----------------------------------------
end gate_level;

--EndOfFile