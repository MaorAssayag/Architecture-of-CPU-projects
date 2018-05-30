-- ====================================================================
--
--	File Name:		FPU_Unit.vhd
--	Description:	FPU_Unit, N must BE 32
--
--
--	Date:			30/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 -- entity Definition
entity FPU_Unit is
    generic(N: positive := 32); --defualt value for N is 32
    port(
        OPP : in std_logic_vector (2 downto 0);
        A  : in signed(N-1 downto 0);
        B  : in signed(N-1 downto 0);
        result : out signed (N-1 downto 0));
end FPU_Unit;

 -- Architecture Definition
architecture gate_level of FPU_Unit is
-------------------------------
  component MUL_FPU
      generic(N: integer := 32); --defualt value for N is 32
      Port(
         A :     in signed((N-1) downto 0);
         B :     in signed((N-1) downto 0);
         SUM :   out signed((N-1) downto 0));
  end component;

  component ADD_SUB_FPU
      generic(N: integer := 32); --defualt value for N is 32
      Port(
         OPP : in std_logic;
         A :     in signed((N-1) downto 0);
         B :     in signed((N-1) downto 0);
         SUM :   out signed((N-1) downto 0));
  end component;

  component FPU_selector
      generic(N: positive := 32);
      port(
        OPP :            in std_logic_vector (2 downto 0);
        MUL_result :     in signed (N-1 downto 0);
        ADD_SUB_result : in signed (N-1 downto 0);
        result :         out signed (N-1 downto 0));
   end component;

-- aid signals
signal  MUL_result :  signed (N-1 downto 0);
signal  ADD_SUB_result :  signed (N-1 downto 0);
begin
----------------------------------------
-- ALU performs FPU ADD, Function_opcode = 50 = 110010, ALU_ctl(OPP in this file) = 011
-- ALU performs FPU SUB, Function_opcode = 45 = 101101, ALU_ctl(OPP in this file) = 100
-- ALU performs FPU MUL, Function_opcode = 47 = 101111, ALU_ctl(OPP in this file) = 101
-- ALU performs FPU slt, Function_opcode = 61 = 111101, ALU_ctl(OPP in this file) = 100

-- mul component , MUL_result = A*B (floating point ieee 754 number)
mul_component :  MUL_FPU port map(A, B, MUL_result);

-- add component , MUL_result = A + B (floating point ieee 754 number)
add_component :  ADD_SUB_FPU port map(OPP(2), A, B, ADD_SUB_result);

-- will output the right HI&LO bits according to the OPP code
selector :  FPU_selector  generic map(N)
  port map (OPP, MUL_result, ADD_SUB_result, result);
----------------------------------------
end gate_level;

--EndOfFile
