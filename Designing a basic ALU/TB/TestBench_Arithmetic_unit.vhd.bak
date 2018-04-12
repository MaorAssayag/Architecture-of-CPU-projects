-- ====================================================================
--
--	File Name:		TestBench_Arithmetic_unit.vhd
--	Description: test bench for Arithmetic_unit unit
--
--
--	Date:			11/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_Arithmetic_unit is
end TestBench_Arithmetic_unit;

architecture behavior of TestBench_Arithmetic_unit is

 -- Component Declaration
 component Arithmetic_Unit
   generic(N: positive := 8); --defualt value for N is 8
     port(
       clk : in std_logic;
       A  : in signed(N-1 downto 0);
       B  : in signed(N-1 downto 0);
       OPP : in std_logic_vector (2 downto 0);
       LO : out signed (N-1 downto 0);
       HI : out signed (N-1 downto 0);
       FLAGS : out signed(5 downto 0);
       FLAG_en : out std_logic); -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
 end component;

constant N : integer := 8;
signal clk : std_logic := '0';
signal OPP : std_logic_vector (2 downto 0) := "100";
signal LO, HI : signed(N-1 downto 0) := "00000000";
signal A  : signed(N-1 downto 0) := "00000101";
signal B  : signed(N-1 downto 0) := "00000010";
signal FLAGS : signed(5 downto 0);
signal FLAG_en :  std_logic; -- FLAG_en :if OPP=SUB then -> '1' else -> '0'
begin
----------------------------------------
  uut :  Arithmetic_Unit  generic map(N)
    port map (clk,A,B,OPP,LO,HI,FLAGS,FLAG_en);

  stim: process
  begin
    wait for 10 ns;  
      clk <= '1';
      OPP <= "100"; -- ADD
      wait for 50 ns;

    wait for 10 ns;
    clk <= '0';
    OPP <= "010";
    
    wait for 10 ns;
    clk <= '1';
    OPP <= "010"; -- MAX

    wait for 10 ns;
    clk <= '0';
    OPP <= "101";
    
    wait for 10 ns;
    clk <= '1';
    OPP <= "101"; -- SUB, check also FLAGS

    wait for 10 ns;
    clk <= '0';
    OPP <= "011";

    wait for 10 ns;
    clk <= '1';
    OPP <= "011"; -- MIN

    wait for 10 ns;
    clk <= '0';
    OPP <= "001";

    wait for 10 ns;
    clk <= '1';
    OPP <= "001"; -- MUL

     wait for 10 ns;
    clk <= '0';
    OPP <= "110";
    
    wait for 10 ns;
    clk <= '1';
    OPP <= "110"; --RST

    wait for 10 ns;
    clk <= '0';
    OPP <= "000"; 

    wait for 10 ns;
    clk <= '1';
    OPP <= "000"; -- MAC

  end process stim;
----------------------------------------
end behavior;

--EndOfFile
