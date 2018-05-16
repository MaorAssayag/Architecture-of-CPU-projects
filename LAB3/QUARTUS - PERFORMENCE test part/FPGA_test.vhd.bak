-- ====================================================================
--
--	File Name:		FPGA_test.vhd
--	Description: FPGA_test
--
--	Date:			11/04/2018
--	Designers:  Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity FPGA_test is
    generic(N: positive := 32); --defualt value for N is 8
    port (
       clk:     in  std_logic;
       rst : in std_logic;
       numin1:   in  signed (N-1 downto 0);
       numin2:   in  signed (N-1 downto 0);
       FPU_SW_8  : in  std_logic; -- switch 16-bit MSB\LSB of FPU_UNIT output
       OPP:     in  std_logic_vector (3 downto 0);
       HI :  out signed(N-1 downto 0);
       STATUS : out std_logic_vector (5 downto 0));
end FPGA_test;

 -- Architecture Definition
architecture structural of FPGA_test is
-------- register for part 1
  component N_dff
  generic(N: positive := 32); --defualt value for N is 8
  port (
      clk : in std_logic;
      enable : in std_logic;
      rst : in std_logic;
      D : in signed(N-1 downto 0);
      Q : out signed(N-1 downto 0));
 end component;

------- ALU for part 2
component ALU
generic(N: positive := 32); --defualt value for N is 8
port (
   clk:     in  std_logic;
   FPU_SW  : in  std_logic; -- switch 16-bit MSB\LSB of FPU_UNIT output
   OPP:     in  std_logic_vector (3 downto 0);
   A:       in  signed (N-1 downto 0);
   B :      in  signed (N-1 downto 0);
   LO :     out signed (N-1 downto 0);
   HI :     out signed (N-1 downto 0);
   STATUS : out signed (5 downto 0));
end component;




 signal in1 : signed(N-1 downto 0);
 signal in2 : signed(N-1 downto 0);
 signal in3 : signed(N-1 downto 0);
 signal in4 : signed(N-1 downto 0);

 signal out1 : signed(N/2-1 downto 0);
 signal out2 : signed(N/2-1 downto 0);
 signal STATUS_from_ALU : signed (5 downto 0);
begin
----------------------------------------
----------registers
reg1: N_dff port map (clk, rst,'1', numin1, in1);
reg2: N_dff port map (clk, rst,'1', numin2, in4);
reg3: N_dff port map (clk, rst,'1', out1 & out2, in3);


---------------ALU
ALU_op: ALU port map (clk,FPU_SW_8 ,OPP,in1, in4, out1,out2,STATUS_from_ALU);




----------------------------------------
end structural;

--EndOfFile
