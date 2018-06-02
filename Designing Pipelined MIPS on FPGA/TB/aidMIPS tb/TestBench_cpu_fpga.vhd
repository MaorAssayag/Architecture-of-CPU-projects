-- ====================================================================
--
--	File Name:		TestBench_cpu_fpga.vhd
--	Description: test bench for cpu_fpga unit
--
--
--	Date:			11/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity TestBench_cpu_fpga is
end TestBench_cpu_fpga;

architecture behavior of TestBench_cpu_fpga is

 -- Component Declaration
 component CPU_FPGA
 PORT( button_mips      :     IN 	STD_LOGIC;
       button_GPIO      :     IN 	STD_LOGIC;
       button_reset     :     IN 	STD_LOGIC;
       LO_1    			   :     out  std_logic_vector (6 downto 0);
       LO_2    				 :     out  std_logic_vector (6 downto 0);
       HI_1    				 :     out  std_logic_vector (6 downto 0);
       HI_2   					 :     out  std_logic_vector (6 downto 0);
       clock            :     IN 	STD_LOGIC
       );
 end component;

constant N : integer := 8;
signal clk : std_logic := '0';
signal FPU_SW_8 : std_logic := '0';
signal KEY0 : std_logic := '0';
signal KEY1 : std_logic := '0';
signal KEY2 : std_logic := '0';
signal numin:  signed (N-1 downto 0);
signal LO_1 :      std_logic_vector (6 downto 0);
signal LO_2 :      std_logic_vector (6 downto 0);
signal HI_1 :      std_logic_vector (6 downto 0);
signal HI_2 :      std_logic_vector (6 downto 0);
signal STATUS :  std_logic_vector (5 downto 0);
begin
----------------------------------------
  uut :  CPU_FPGA
    port map (KEY0,KEY1,KEY2,LO_1,LO_2,HI_1,HI_2,clk);

  clock: process
  begin
    wait for 50 ns;
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
  end process;
  u_1pulse_proc: PROCESS
  BEGIN
     KEY1 <=
        '0',
        '0' AFTER 140 ns,
        '1' AFTER 145 ns;
     WAIT;
   END PROCESS u_1pulse_proc;
----------------------------------------
end behavior;

--EndOfFile
