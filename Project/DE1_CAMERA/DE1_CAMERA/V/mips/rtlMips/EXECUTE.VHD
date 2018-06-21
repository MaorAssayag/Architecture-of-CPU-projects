-- ====================================================================
--
--	File Name:		Execute.vhd
--	Description:  Execute module (implements the data ALU and Branch Address Adder
--                for the MIPS computer)
--
--
--	Date:			30/05/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
LIBRARY IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

 -- entity Definition
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

 -- Architecture Definition
ARCHITECTURE behavior OF Execute IS

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
signal Ainput_signed : signed(31 downto 0);
signal Binput_signed : signed(31 downto 0);
------------

SIGNAL Ainput, Binput 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ALU_output_mux		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Branch_Add 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL ALU_ctl				: STD_LOGIC_VECTOR( 2 DOWNTO 0 );
signal FPU_OP : STD_LOGIC_VECTOR( 2 DOWNTO 0 );
BEGIN
----------------------------------------
Ainput_signed <= signed(Ainput);
Binput_signed <= signed(Binput);
-- Floating point UNIT
FPU_OP <= ALU_ctl(0) & ALU_ctl(1) & ALU_ctl(2); -- flip the ALU_ctl - for the fpu logic
FPU :  FPU_Unit port map(FPU_OP, Ainput_signed, Binput_signed, FPU_result);
--------------

	Ainput <= Read_data_1;
	-- ALU input mux
	Binput <= Read_data_2
		WHEN ( ALUSrc = '0' )
  		ELSE  Sign_extend( 31 DOWNTO 0 );
	-- Generate ALU control bits
	ALU_ctl( 0 ) <= (( Function_opcode( 0 ) OR Function_opcode( 3 ) ) AND ALUOp(1 )) AND (NOT (ALUOp(1) AND ALUOp(0)));
	ALU_ctl( 1 ) <= ( NOT Function_opcode( 2 ) ) OR (NOT ALUOp( 1 ) ) OR (ALUOp(1) AND ALUOp(0));
	ALU_ctl( 2 ) <= (( Function_opcode( 1 ) AND ALUOp( 1 )) OR ALUOp( 0 )) AND (NOT (ALUOp(1) AND ALUOp(0)));
	--ADD
	-- sltFPU = 111101 = 61
  slt_FPU_flag <= '1' when Function_opcode = "111101" ELSE '0'; -- another layer of selection is in the case-when section
	-------------

	-- Select ALU output
	ALU_result <= X"0000000" & B"000"  & ALU_output_mux( 31 )
		WHEN  ALU_ctl = "111"
		ELSE  	ALU_output_mux( 31 DOWNTO 0 );

PROCESS ( ALU_ctl, Ainput, Binput ,FPU_result)
variable temp : std_logic_vector(31 downto 0) := (31 downto 0 => '0');
	BEGIN
	-- Select ALU operation
 	CASE ALU_ctl IS
		-- ALU performs ALUresult = A_input AND B_input
		WHEN "000" 	=>	ALU_output_mux 	<= Ainput AND Binput;
		-- ALU performs ALUresult = A_input OR B_input
    WHEN "001" 	=>
				-- ALU performs FPU slt, Function_opcode = 61 = 111101
				if slt_FPU_flag = '1' then
						ALU_output_mux <= (31 downto 1 => '0') & FPU_result(31); -- temp(31) is the signBIT, indicate A>B when temp=A-B
				else
					ALU_output_mux 	<= Ainput OR Binput;
				end if;
		-- ALU performs ALUresult = A_input + B_input
	 	WHEN "010" 	=>	ALU_output_mux 	<= Ainput + Binput;
		-- ALU performs FPU ADD, Function_opcode = 50 = 110010
 	 	WHEN "011" 	=>	ALU_output_mux <= std_logic_vector(FPU_result);
		-- ALU performs FPU SUB, Function_opcode = 45 = 101101
 	 	WHEN "100" 	=>
				temp := std_logic_vector(FPU_result);
				ALU_output_mux <= temp;
		-- ALU performs FPU MUL, Function_opcode = 47 = 101111
 	 	WHEN "101" 	=> 		ALU_output_mux <= std_logic_vector(FPU_result);
		-- ALU performs ALUresult = A_input -B_input
 	 	WHEN "110" 	=>	ALU_output_mux 	<= Ainput - Binput;
		-- ALU performs SLT
  	WHEN "111" 	=>	ALU_output_mux 	<= Ainput - Binput ;
 	 	WHEN OTHERS	=>	ALU_output_mux 	<= X"00000000" ;
  	END CASE;
  END PROCESS;

	----------------------------------------
END behavior;

--EndOfFile
