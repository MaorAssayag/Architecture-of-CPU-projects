-- ====================================================================
--
--	File Name:		TestBench_fpga.vhd
--	Description: test bench for fpga unit
--
--
--	Date:			11/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_fpga is
end TestBench_fpga;

architecture behavior of TestBench_fpga is

 -- Component Declaration
 component FPGA_design
   generic(N: positive := 8); --defualt value for N is 8
     port(
     clk:     in  std_logic;
     numin:   in  signed (N-1 downto 0);
     FPU_SW_8  : in  std_logic; -- switch 16-bit MSB\LSB of FPU_UNIT output
     KEY0:    in  std_logic;
     KEY1:    in  std_logic;
     KEY2:    in  std_logic;
     KEY3:    in  std_logic;
     LO_1 :     out std_logic_vector (6 downto 0);
     LO_2 :     out std_logic_vector (6 downto 0);
     HI_1 :     out std_logic_vector (6 downto 0);
     HI_2 :     out std_logic_vector (6 downto 0);
     STATUS : out std_logic_vector (5 downto 0));
 end component;

constant N : integer := 8;
signal clk : std_logic := '0';
signal FPU_SW_8 : std_logic := '0';
signal KEY0 : std_logic := '0';
signal KEY1 : std_logic := '0';
signal KEY2 : std_logic := '0';
signal KEY3 : std_logic := '0';
signal numin:  signed (N-1 downto 0);
signal LO_1 :      std_logic_vector (6 downto 0);
signal LO_2 :      std_logic_vector (6 downto 0);
signal HI_1 :      std_logic_vector (6 downto 0);
signal HI_2 :      std_logic_vector (6 downto 0);
signal STATUS :  std_logic_vector (5 downto 0);
begin
----------------------------------------
  uut :  FPGA_design  generic map(N)
    port map (clk, numin, FPU_SW_8, KEY0, KEY1, KEY2, KEY3,LO_1,LO_2,HI_1,HI_2,STATUS);

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
    -- stage_0 ---------------
    wait for 10 ns;
    KEY0 <= '1';
    numin <= "00001101";
    wait for 10 ns;
    KEY0 <= '0';
    wait for 10 ns;
    KEY1 <= '1';
    numin <= "00000001";
    wait for 10 ns;
    KEY1 <= '0';
    wait for 10 ns;
    KEY2 <= '1';
    numin <= "00001001";
    wait for 10 ns;
    KEY2 <= '0';

  end process stim;
----------------------------------------
end behavior;

--EndOfFile
