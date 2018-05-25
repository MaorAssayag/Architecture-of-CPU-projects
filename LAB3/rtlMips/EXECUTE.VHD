--  Execute module (implements the data ALU and Branch Address Adder
--  for the MIPS computer)
LIBRARY IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY  Execute IS
	PORT(	Read_data_1 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Read_data_2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extend 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Function_opcode : IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			ALUOp 			: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			ALUSrc 			: IN 	STD_LOGIC;
			ALU_Result 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			clock, reset	: IN 	STD_LOGIC );
END Execute;

ARCHITECTURE behavior OF Execute IS

-- ADD
component FPU_Unit
    generic(N: positive := 32); --defualt value for N is 32
    port(
        OPP : in std_logic_vector (2 downto 0);
        A  : in signed(N-1 downto 0);
        B  : in signed(N-1 downto 0);
        result : out signed (N-1 downto 0));
end component;
signal FPU_result : signed(31 downto 0);
signal slt_FPU_flag : STD_LOGIC;
signal temp : std_logic_vector(31 downto 0);
signal Ainput_signed : signed(31 downto 0);
signal Binput_signed : signed(31 downto 0);
------------

SIGNAL Ainput, Binput 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ALU_output_mux		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Branch_Add 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL ALU_ctl				: STD_LOGIC_VECTOR( 2 DOWNTO 0 );
BEGIN
Ainput_signed <= signed(Ainput);
Binput_signed <= signed(Binput);
-- ADD
-- Floating point UNIT
FPU :  FPU_Unit port map(ALU_ctl, Ainput_signed, Binput_signed, FPU_result);
--------------

	Ainput <= Read_data_1;
	-- ALU input mux
	Binput <= Read_data_2
		WHEN ( ALUSrc = '0' )
  		ELSE  Sign_extend( 31 DOWNTO 0 );
	-- Generate ALU control bits
	ALU_ctl( 0 ) <= ( Function_opcode( 0 ) OR Function_opcode( 3 ) ) AND ALUOp(1 );
	ALU_ctl( 1 ) <= ( NOT Function_opcode( 2 ) ) OR (NOT ALUOp( 1 ) );
	ALU_ctl( 2 ) <= ( Function_opcode( 1 ) AND ALUOp( 1 )) OR ALUOp( 0 );
	--ADD
	-- sltFPU = 111101 = 61
  slt_FPU_flag <= Function_opcode(4); -- another layer of selection is in the case-when section
	-------------




	-- -- Generate Zero Flag
	-- Zero <= '1'
	-- 	WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000"  )
	-- 	ELSE '0';
	--
	--
	-- 	-- Adder to compute Branch Address
	-- 	Branch_Add	<= PC_plus_4( 9 DOWNTO 2 ) + Sign_extend( 7 DOWNTO 0 );
	-- 	Add_result 	<= Branch_Add( 7 DOWNTO 0 );




	-- Select ALU output
	ALU_result <= X"0000000" & B"000"  & ALU_output_mux( 31 )
		WHEN  ALU_ctl = "111"
		ELSE  	ALU_output_mux( 31 DOWNTO 0 );



PROCESS ( ALU_ctl, Ainput, Binput )
	BEGIN
	-- Select ALU operation
 	CASE ALU_ctl IS
		-- ALU performs ALUresult = A_input AND B_input
		WHEN "000" 	=>	ALU_output_mux 	<= Ainput AND Binput;
		-- ALU performs ALUresult = A_input OR B_input
    WHEN "001" 	=>	ALU_output_mux 	<= Ainput OR Binput;
		-- ALU performs ALUresult = A_input + B_input
	 	WHEN "010" 	=>	ALU_output_mux 	<= Ainput + Binput;
		-- ALU performs FPU ADD, Function_opcode = 50 = 110010
 	 	WHEN "011" 	=>	ALU_output_mux <= std_logic_vector(FPU_result);
		-- ALU performs FPU SUB, Function_opcode = 45 = 101101
 	 	WHEN "100" 	=>
				temp <= std_logic_vector(FPU_result);
				-- ALU performs FPU slt, Function_opcode = 61 = 111101
				if slt_FPU_flag = '1' then
						ALU_output_mux <= (31 downto 1 => '0') & temp(31); -- temp(31) is the signBIT, indicate A>B when temp=A-B
				else
					ALU_output_mux <= temp;
				end if;
		-- ALU performs FPU MUL, Function_opcode = 47 = 101111
 	 	WHEN "101" 	=> 		ALU_output_mux <= std_logic_vector(FPU_result);
		-- ALU performs ALUresult = A_input -B_input
 	 	WHEN "110" 	=>	ALU_output_mux 	<= Ainput - Binput;
		-- ALU performs SLT
  	WHEN "111" 	=>	ALU_output_mux 	<= Ainput - Binput ;
 	 	WHEN OTHERS	=>	ALU_output_mux 	<= X"00000000" ;
  	END CASE;
  END PROCESS;
END behavior;
