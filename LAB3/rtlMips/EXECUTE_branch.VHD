--  Execute_branch module (implements the data ALU and Branch Address Adder
--  for the MIPS computer)
LIBRARY IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY  Execute_branch IS
	PORT(	Read_data_1_branch 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				Read_data_2_branch 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				Sign_extend_branch 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				ALUOp_branch 		  	: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
				ALUSrc_branch 			  : IN 	STD_LOGIC;
				Zero_branch 		     	: OUT	STD_LOGIC;
				Add_Result_branch 		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
				PC_plus_4_branch 		: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
				clock, reset	: IN 	STD_LOGIC );
END Execute_branch;

ARCHITECTURE behavior OF Execute_branch IS


SIGNAL Ainput, Binput 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ALU_output_mux		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Branch_Add 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
BEGIN


	Ainput <= Read_data_1_branch;
	-- ALU input mux
	Binput <= Read_data_2_branch
		WHEN ( ALUSrc_branch = '0' )
  		ELSE  Sign_extend_branch( 31 DOWNTO 0 );


	-- Generate Zero_branch Flag
	Zero_branch <= '1'
		WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000" and ALUOp_branch(0) = '1' )
		ELSE '0';


		-- Adder to compute Branch Address
		Branch_Add	<= PC_plus_4_branch( 9 DOWNTO 2 ) + Sign_extend_branch( 7 DOWNTO 0 );
		Add_Result_branch 	<= Branch_Add( 7 DOWNTO 0 );







PROCESS ( ALUOp_branch, Ainput, Binput )
	BEGIN
		ALU_output_mux 	<= Ainput - Binput ;
  END PROCESS;
END behavior;
