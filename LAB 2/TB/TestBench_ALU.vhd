-- ====================================================================
--
--	File Name:		TestBench_ALU.vhd
--	Description: test bench for ALU unit
--
--
--	Date:			11/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_ALU is
end TestBench_ALU;

architecture behavior of TestBench_ALU is

 -- Component Declaration
 component ALU
   generic(N: positive := 8); --defualt value for N is 8
     port(
       clk:     in  std_logic;
       FPU_SW  :  in  std_logic; -- switch 16-bit MSB\LSB of FPU_UNIT output
       OPP:     in  std_logic_vector (3 downto 0);
       A:       in  signed (N-1 downto 0);
       B :      in  signed (N-1 downto 0);
       LO :     out signed (N-1 downto 0);
       HI :     out signed (N-1 downto 0);
       STATUS : out signed (5 downto 0));
 end component;

constant N : integer := 8;
signal clk : std_logic := '0';
signal OPP : std_logic_vector (3 downto 0) := "0000";
signal LO, HI : signed(N-1 downto 0) := "00000000";
signal A  : signed(N-1 downto 0) := "00000101";
signal B  : signed(N-1 downto 0) := "00000010";
signal STATUS : signed(5 downto 0);
begin
----------------------------------------
  uut :  ALU  generic map(N)
    port map (clk, OPP, A, B, LO, HI, STATUS);

  clock: process
  begin
    clk <= '0';
    while (0 = 0) loop
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
    clk <= '0';
    end loop;
  end process;

  stim: process
  begin
    wait for 10 ns;
    OPP <= "0000"; -- initial MAC

    -- stage_0 ---------------
    wait for 10 ns;
      OPP <= "0100"; -- ADD

    wait for 10 ns;
    OPP <= "0010"; -- MAX

    wait for 10 ns;
    OPP <= "0101"; -- SUB, check also FLAGS

    wait for 10 ns;
    OPP <= "0011"; -- MIN

    wait for 10 ns;
    OPP <= "0001"; -- MUL

    wait for 10 ns;
    OPP <= "0110"; --RST

    wait for 10 ns;
    OPP <= "0000"; -- MAC

    wait for 10 ns;
    OPP <= "1000"; -- SHL

    wait for 10 ns;
    OPP <= "1001"; --SHR

    -- stage_1 ---------------
    A  <= "00000001";
    B  <= "00000100";

    wait for 10 ns;
    OPP <= "0100"; -- ADD

    wait for 10 ns;
    OPP <= "0010"; -- MAX

    wait for 10 ns;
    OPP <= "0101"; -- SUB, check also FLAGS

    wait for 10 ns;
    OPP <= "0011"; -- MIN

    wait for 10 ns;
    OPP <= "0001"; -- MUL

    wait for 10 ns;
    OPP <= "0000"; -- MAC

    wait for 10 ns;
    OPP <= "1000"; -- SHL

    wait for 10 ns;
    OPP <= "1001"; --SHR

    -- stage_1 ---------------
    A  <= "00000010";
    B  <= "11111110";

    wait for 10 ns;
    OPP <= "0100"; -- ADD

    wait for 10 ns;
    OPP <= "0010"; -- MAX

    wait for 10 ns;
    OPP <= "0101"; -- SUB, check also FLAGS

    wait for 10 ns;
    OPP <= "0011"; -- MIN

    wait for 10 ns;
    OPP <= "0001"; -- MUL

    wait for 10 ns;
    OPP <= "0000"; -- MAC

  end process stim;
----------------------------------------
end behavior;

--EndOfFile
