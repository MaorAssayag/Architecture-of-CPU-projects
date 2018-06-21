-- ====================================================================
--
--	File Name:		Ifetch.vhd
--	Description:	Ifetch module (provides the PC and instruction memory for the MIPS computer)
--
--
--	Date:			30/05/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

 -- entity Definition
ENTITY Ifetch IS
	PORT(	 Instruction 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	 PC_plus_4_out 	: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	 Add_result 		: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        	 Branch_Beq_f 			: IN 	STD_LOGIC;
					 Branch_Bne_f 			: IN 	STD_LOGIC;
        	 Zero 			: IN 	STD_LOGIC;
					 mips_int : in std_logic;
      		 PC_out 			: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	 clock, reset,data_hazard_en_fetch 	: IN 	STD_LOGIC
					);
END Ifetch;

 -- Architecture Definition
ARCHITECTURE behavior OF Ifetch IS
	SIGNAL PC, PC_plus_4 	 : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL next_PC, Mem_Addr : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL tempclock :STD_LOGIC;

BEGIN
----------------------------------------
 						--ROM for Instruction Memory
inst_memory: altsyncram

	GENERIC MAP (
		operation_mode => "ROM",
		width_a => 32,
		widthad_a => 8,
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file => "program.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		clock0     =>  clock ,
		address_a 	=> Mem_Addr,
		q_a 			=> Instruction );
					-- Instructions always start on word address - not byte
		PC(1 DOWNTO 0) <= "00";
					-- copy output signals - allows read inside module
		PC_out 			<= PC;
		PC_plus_4_out 	<= PC_plus_4;
						-- send address to inst. memory address register

		Mem_Addr <= Next_PC;
						-- Adder to increment PC by 4
      	PC_plus_4( 9 DOWNTO 2 )  <= PC( 9 DOWNTO 2 ) + 1;
       	PC_plus_4( 1 DOWNTO 0 )  <= "00";
						-- Mux to select Branch Address or PC + 4

		Next_PC  <= X"00" WHEN Reset = '1'  ELSE
			 PC (9 DOWNTO 2) when data_hazard_en_fetch ='0' else
			Add_result  WHEN ( (( Branch_Beq_f = '1' ) AND ( Zero = '1' )) or (( Branch_Bne_f = '1' ) AND ( Zero = '0' )) )
			ELSE   PC_plus_4( 9 DOWNTO 2 );


			----------------  check
			PROCESS
				BEGIN
					WAIT UNTIL ( clock'EVENT ) AND ( clock = '1' );
					IF reset = '1' THEN
						   PC( 9 DOWNTO 2) <= "00000000" ;
					ELSE
						   PC( 9 DOWNTO 2 ) <= next_PC ;
					END IF;
			END PROCESS;
----------------------------------------
END behavior;

--EndOfFile
