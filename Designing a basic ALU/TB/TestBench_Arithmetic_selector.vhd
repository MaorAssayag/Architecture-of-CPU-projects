-- ====================================================================
--
--	File Name:		Testbench_Arithmetic_selector.vhd
--	Description: test bench for Arithmetic_selector unit
--
--
--	Date:			11/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_Arithmetic_selector is
end Testbench_Arithmetic_selector;

architecture behavior of Testbench_Arithmetic_selector is

 -- Component Declaration
 component Arithmetic_selector is
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
 end component;

 constant N : integer := 8;
 signal OP :    std_logic_vector (2 downto 0);
 signal MUL_HI :  signed ((N-1) downto 0);
 signal MUL_LO :  signed ((N-1) downto 0);
 signal MAC_HI :  signed ((N-1) downto 0);
 signal MAC_LO :  signed ((N-1) downto 0);
 signal MAX_MIN_LO :  signed ((N-1) downto 0);
 signal ADD_SUB_LO :  signed ((N-1) downto 0);
 signal HI :  signed ((N-1) downto 0);
 signal LO :  signed ((N-1) downto 0);
 signal FLAG_en : std_logic := '0';
begin
----------------------------------------
  uut :  Arithmetic_selector  generic map(N)
    port map (OP, MUL_HI, MUL_LO, MAC_HI, MAC_LO, MAX_MIN_LO, ADD_SUB_LO, HI, LO,FLAG_en);

  stim: process
  begin
    wait for 10 ns;
      OP <= "000";
      MUL_HI <= "00001111";
      MUL_LO <= "11110000";
      MAC_HI <= "10101000";
      MAC_LO <= "00111100";
      MAX_MIN_LO <= "00001111";
      ADD_SUB_LO <= "11110000";
    wait for 50 ns;
    wait for 10 ns;
      OP <= "001";
      MUL_HI <= "00001111";
      MUL_LO <= "11110000";
      MAC_HI <= "10101000";
      MAC_LO <= "00111100";
      MAX_MIN_LO <= "00001111";
      ADD_SUB_LO <= "11110000";
    wait for 50 ns;
    wait for 10 ns;
      OP <= "010";
      MUL_HI <= "00001111";
      MUL_LO <= "11110000";
      MAC_HI <= "10101000";
      MAC_LO <= "00111100";
      MAX_MIN_LO <= "00001111";
      ADD_SUB_LO <= "11110000";
    wait for 50 ns;
    wait for 10 ns;
      OP <= "011";
      MUL_HI <= "00001111";
      MUL_LO <= "11110000";
      MAC_HI <= "10101000";
      MAC_LO <= "00111100";
      MAX_MIN_LO <= "00001111";
      ADD_SUB_LO <= "11110000";
    wait for 50 ns;
    wait for 10 ns;
      OP <= "100";
      MUL_HI <= "00001111";
      MUL_LO <= "11110000";
      MAC_HI <= "10101000";
      MAC_LO <= "00111100";
      MAX_MIN_LO <= "00001111";
      ADD_SUB_LO <= "11110000";
    wait for 50 ns;
    wait for 10 ns;
      OP <= "101";
      MUL_HI <= "00001111";
      MUL_LO <= "11110000";
      MAC_HI <= "10101000";
      MAC_LO <= "00111100";
      MAX_MIN_LO <= "00001111";
      ADD_SUB_LO <= "11110000";
    wait for 50 ns;
    wait for 10 ns;
      OP <= "110";
      MUL_HI <= "00001111";
      MUL_LO <= "11110000";
      MAC_HI <= "10101000";
      MAC_LO <= "00111100";
      MAX_MIN_LO <= "00001111";
      ADD_SUB_LO <= "11110000";
    wait for 10 ns;
  end process stim;
----------------------------------------
end behavior;

--EndOfFile
