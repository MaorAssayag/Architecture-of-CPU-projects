--  Execute_branch module (implements the data ALU and Branch Address Adder
--  for the MIPS computer)
LIBRARY IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY  Execute_branch IS
	PORT(	Read_data_1 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				Read_data_2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				Sign_extend 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				ALUOp 		  	: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
				ALUSrc 			  : IN 	STD_LOGIC;
				Zero 		     	: OUT	STD_LOGIC;
				Add_Result 		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
				PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
				clock, reset	: IN 	STD_LOGIC );
END Execute_branch;

ARCHITECTURE behavior OF Execute_branch IS


SIGNAL Ainput, Binput 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ALU_output_mux		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Branch_Add 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
BEGIN
Ainput_signed <= signed(Ainput);
Binput_signed <= signed(Binput);
-- ADD
-- Floating point UNIT
--------------

	Ainput <= Read_data_1;
	-- ALU input mux
	Binput <= Read_data_2
		WHEN ( ALUSrc = '0' )
  		ELSE  Sign_extend( 31 DOWNTO 0 );


	-- Generate Zero Flag
	Zero <= '1'
		WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000" and ALUOp(0) = '1' )
		ELSE '0';


		-- Adder to compute Branch Address
		Branch_Add	<= PC_plus_4( 9 DOWNTO 2 ) + Sign_extend( 7 DOWNTO 0 );
		Add_result 	<= Branch_Add( 7 DOWNTO 0 );







PROCESS ( ALUOp, Ainput, Binput )
	BEGIN
		ALU_output_mux 	<= Ainput - Binput ;
  END PROCESS;
END behavior;
