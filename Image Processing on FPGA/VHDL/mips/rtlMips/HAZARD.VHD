-- ====================================================================
--
--	File Name:		HAZARD.vhd
--	Description:	HAZARD module (implements MIPS HAZARD unit)
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
USE IEEE.STD_LOGIC_SIGNED.ALL;

-- entity Definition
ENTITY HAZARD IS
   PORT(
	      Instruction_IF 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Instruction_ID 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        Instruction_EXE 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        Instruction_MEM 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        MEM_read_EXE  : IN 	STD_LOGIC;
        MEM_read_mem  : IN 	STD_LOGIC;
		  MEM_read_ID  : IN 	STD_LOGIC;
		  RegWrite_EXE  : IN 	STD_LOGIC;
        RegWrite_mem  : IN 	STD_LOGIC;
		  RegWrite_ID  : IN 	STD_LOGIC;
	      data_hazard_en 		 : OUT 	STD_LOGIC;
        Branch_en 		       : OUT 	STD_LOGIC;
        Branch_beq_hazard  : IN 	STD_LOGIC;
        Branch_bne_hazard  : IN 	STD_LOGIC;
        branch_zero        : IN 	STD_LOGIC;
      	clock, reset	   : IN 	STD_LOGIC
         );
END HAZARD;

-- Architecture Definition
ARCHITECTURE behavior OF HAZARD IS

SIGNAL  regdesbef_ID	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );

SIGNAL  regdesbef_exe	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regdesbef_mem	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regS	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regT	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );

SIGNAL  regS_mem_check	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regS_exe_check	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regT_mem_check	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );

SIGNAL  regS_ID_check	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regT_ID_check	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );

SIGNAL  regT_exe_check	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );

signal reg_destination_ID : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal reg_destination_EXE : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal reg_destination_MEM : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal regS_mem_destination : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal regT_mem_destination : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal regS_exe_destination : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal regT_exe_destination : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal regS_ID_destination : STD_LOGIC_VECTOR( 4 DOWNTO 0 );
signal regT_ID_destination : STD_LOGIC_VECTOR( 4 DOWNTO 0 );

BEGIN
------------------------------------      data hazard
		-- save the rt
     regdesbef_ID <= Instruction_ID( 20 DOWNTO 16  );
	   regdesbef_exe <= Instruction_EXE( 20 DOWNTO 16  );
     regdesbef_mem <= Instruction_MEM( 20 DOWNTO 16  );

		--save the rd for commands like add
		 reg_destination_ID <= Instruction_ID( 15 DOWNTO 11  );
	   reg_destination_EXE <= Instruction_EXE( 15 DOWNTO 11  );
     reg_destination_MEM <= Instruction_MEM( 15 DOWNTO 11  );

     regS 	<= Instruction_IF( 25 DOWNTO 21 );
     regT	<= Instruction_IF( 20 DOWNTO 16 );

		-- check for crossover with the current source register & the prev target register
     regS_mem_check    <= (regdesbef_mem xor regS) when (regS /= 0) else "00001";
     regS_exe_check    <= (regdesbef_exe xor regS) when (regS /= 0) else "00001";
		 regS_ID_check     <= (regdesbef_ID xor regS) when (regS /= 0) else "00001";

		-- check for crossover with the current target register & the prev target register
     regT_mem_check    <= (regdesbef_mem xor regT) when (regT /= 0) else "00001";
     regT_exe_check    <= (regdesbef_exe xor regT) when (regT /= 0) else "00001";
     regT_ID_check     <= (regdesbef_ID xor regT) when (regT /= 0) else "00001";

		-- check for crossover with the current source register & the prev destination register
     regS_mem_destination    <= (reg_destination_MEM xor regS) when (regS /= 0) else "00001";
     regS_exe_destination    <= (reg_destination_EXE xor regS) when (regS /= 0) else "00001";
	   regS_ID_destination     <= (reg_destination_ID xor regS) when (regS /= 0) else "00001";

		-- check for crossover with the current target register & the prev destination register
     regT_mem_destination    <= (reg_destination_MEM xor regT) when (regT /= 0) else "00001";
     regT_exe_destination    <= (reg_destination_EXE xor regT) when (regT /= 0) else "00001";
	   regT_ID_destination     <= (reg_destination_ID xor regT) when (regT /= 0) else "00001";

    find_hazard:PROCESS (clock, regS_mem_check,regS_exe_check,regS_ID_check, regT_ID_check ,regT_mem_check,regT_exe_check , MEM_read_mem, MEM_read_EXE, MEM_read_ID)
	BEGIN
		if (clock='1') then
		IF ((MEM_read_mem = '1'  and (regS_mem_check = "00000"  or regT_mem_check = "00000")) or ((MEM_read_EXE ='1' ) and (regS_exe_check = "00000"  or regT_exe_check = "00000")) or ((MEM_read_ID ='1' ) and (regS_ID_check = "00000"  or regT_ID_check = "00000"))) THEN
			data_hazard_en <= '0';
		ELSIF ((RegWrite_mem = '1'  and (regS_mem_destination = "00000"  or regT_mem_destination = "00000")) or ((RegWrite_EXE ='1' ) and (regS_exe_destination = "00000"  or regT_exe_destination = "00000")) or ((RegWrite_ID ='1' ) and (regS_ID_destination = "00000"  or regT_ID_destination = "00000"))) THEN
			data_hazard_en <= '0';
		ELSE
			data_hazard_en <= '1';
		END IF;
		end if;
END PROCESS;
--------------------------------------
---------------------------------  branch HAZARD
Branch_en <= '1' when ( (( Branch_beq_hazard = '1' ) AND ( branch_zero = '1' )) OR (( Branch_bne_hazard = '1' ) AND ( branch_zero = '0' )) )
else '0';
-----------------------------------------
END behavior;

--EndOfFile
