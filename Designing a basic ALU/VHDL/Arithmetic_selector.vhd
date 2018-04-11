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
       MAX_MIN_LO : in signed ((N-1) downto 0);
       ADD_SUB_LO : in signed ((N-1) downto 0);
       HI : out signed ((N-1) downto 0);
       LO : out signed ((N-1) downto 0);
       FLAG_en : out std_logic); -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
end Arithmetic_selector;

 -- Architecture Definition
architecture gate_level of Arithmetic_selector is
begin
----------------------------------------
process (OP, MUL_HI, MUL_LO, MAC_HI,MAC_LO,MAX_MIN_LO,ADD_SUB_LO)
begin
if (OP = "000") then
  HI <= MUL_HI;
  LO <= MUL_LO;
  FLAG_en <= '0';
elsif ((OP = "001") or (OP = "110")) then
  HI <= MAC_HI;
  LO <= MAC_LO;
  FLAG_en <= '0';
elsif ((OP = "010") or (OP = "011")) then
  HI <=(others => '0');
  LO <= MAX_MIN_LO;
  FLAG_en <= '0';
elsif (OP = "100") then
  HI <=(others => '0');
  LO <= ADD_SUB_LO;
  FLAG_en <= '0';
elsif (OP = "101") then
  HI <=(others => '0');
  LO <= ADD_SUB_LO;
  FLAG_en <= '1';
end if;
end process;

----------------------------------------
end gate_level;

--EndOfFile
