		-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY control IS
   PORT(
        	Opcode 		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
        	RegDst 		: OUT 	STD_LOGIC;
        	ALUSrc 		: OUT 	STD_LOGIC;
        	MemtoReg 	: OUT 	STD_LOGIC;
        	RegWrite 	: OUT 	STD_LOGIC;
        	MemRead 		: OUT 	STD_LOGIC;
        	MemWrite 	: OUT 	STD_LOGIC;
        	Branch_Beq 		: OUT 	STD_LOGIC;
          Branch_Bne 		: OUT 	STD_LOGIC;
        	ALUop 		: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
          data_hazard 		 : in 	STD_LOGIC;
        	clock, reset	: IN 	STD_LOGIC );

END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  R_format, Lw, Sw, Beq ,Bne	: STD_LOGIC;

BEGIN
				-- Code to generate control signals using opcode bits
	R_format 	<=  '1'  WHEN  Opcode = "000000"  ELSE '0';
	Lw          <=  '1'  WHEN  Opcode = "100011"  ELSE '0';
 	Sw          <=  '1'  WHEN  Opcode = "101011"  ELSE '0';
   	Beq         <=  '1'  WHEN  Opcode = "000100"  ELSE '0';
    Bne         <=  '1'  WHEN  Opcode = "000101"  ELSE '0';
  	RegDst    	<=  R_format;
 	ALUSrc  	<=  Lw OR Sw;
	MemtoReg 	<=  Lw when data_hazard = '1' else '0';
  	RegWrite 	<=  R_format OR Lw;
  	MemRead 	<=  Lw when data_hazard = '1' else '0';
   	MemWrite 	<=  Sw when data_hazard = '1' else '0';
 	Branch_Beq      <=  Beq when data_hazard = '1' else '0';
  Branch_Bne      <=  Bne when data_hazard = '1' else '0';
	ALUOp( 1 ) 	<=  R_format when data_hazard = '1' else '0';
	ALUOp( 0 ) 	<=  Beq or Bne    when data_hazard = '1' else '0';

   END behavior;
