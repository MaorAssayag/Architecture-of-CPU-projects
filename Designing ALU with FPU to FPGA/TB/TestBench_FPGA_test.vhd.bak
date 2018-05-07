-- ====================================================================
--
--	File Name:		TestBench_FPGA_test.vhd
--	Description: test bench for FPGA_test unit
--
--
--	Date:			11/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_FPGA_test is
end TestBench_FPGA_test;

architecture behavior of TestBench_FPGA_test is

 -- Component Declaration
 component FPGA_test
 generic(N: positive := 16); --defualt value for N is 8
 port (
    clk:     in  std_logic;
    rst : in std_logic;
    numin1:   in  signed (15 downto 0);
    numin2:   in  signed (15 downto 0);
    FPU_SW_8  : in  std_logic; -- switch 16-bit MSB\LSB of FPU_UNIT output
    OPP:     in  std_logic_vector (3 downto 0);
    HI   :  out signed(15 downto 0);
    LO   :  out signed(15 downto 0);
    STATUS : out std_logic_vector (5 downto 0));
 end component;

constant N : integer := 8;
signal clk : std_logic := '0';
signal FPU_SW : std_logic := '0';
signal OPP : std_logic_vector (3 downto 0) := "0000";
signal LO, HI : signed(15 downto 0) := "0000000000000000";
signal A  : signed(15 downto 0) := "0000000000000101";
signal B  : signed(15 downto 0) := "0000000000000010";
signal STATUS : std_logic_vector(5 downto 0);
begin
----------------------------------------
  uut :  FPGA_test  generic map(16)
    port map (clk, '0',A,B,FPU_SW,OPP,HI,LO,STATUS);
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
    A  <= "0000000000000001";
    B  <= "0000000000000100";

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

    -- stage_2 ---------------
    A  <= "0000000000000010";
    B  <= "1111110000000010";

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
