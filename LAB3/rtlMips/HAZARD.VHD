		-- HAZARD module (implements MIPS HAZARD unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY HAZARD IS
   PORT(
	      Instruction_IF 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Instruction_ID 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        Instruction_EXE 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        Instruction_MEM 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        MEM_read_EXE  : IN 	STD_LOGIC;
        MEM_read_mem  : IN 	STD_LOGIC;
		  MEM_read_ID  : IN 	STD_LOGIC;
	      data_hazard_en 		 : OUT 	STD_LOGIC;
        Branch_en 		       : OUT 	STD_LOGIC;
        Branch_beq_hazard  : IN 	STD_LOGIC;
        Branch_bne_hazard  : IN 	STD_LOGIC;
        branch_zero        : IN 	STD_LOGIC;
      	clock, reset	   : IN 	STD_LOGIC
         );
END HAZARD;



ARCHITECTURE behavior OF HAZARD IS
component N_dff
    generic(N: integer := 8); --defualt value for N is 8
    port (
        clk : in std_logic;
        enable : in std_logic;
        rst : in std_logic;
        D : in STD_LOGIC_VECTOR(N-1 downto 0);
        Q : out STD_LOGIC_VECTOR(N-1 downto 0));
end component;


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



BEGIN
------------------------------------      data hazard
      regdesbef_ID <= Instruction_ID( 20 DOWNTO 16  );

	 
	   regdesbef_exe <= Instruction_EXE( 20 DOWNTO 16  );
      regdesbef_mem <= Instruction_MEM( 20 DOWNTO 16  );
      regS 	<= Instruction_IF( 25 DOWNTO 21 );
      regT	<= Instruction_IF( 20 DOWNTO 16 );

      regS_mem_check    <= (regdesbef_mem xor regS) when (regS /= 0) else "00001";
      regS_exe_check    <= (regdesbef_exe xor regS) when (regS /= 0) else "00001";
		regS_ID_check     <= (regdesbef_ID xor regS) when (regS /= 0) else "00001";
      regT_mem_check    <= (regdesbef_mem xor regT) when (regT /= 0) else "00001";
      regT_exe_check    <= (regdesbef_exe xor regT) when (regT /= 0) else "00001";
		regT_ID_check     <= (regdesbef_ID xor regT) when (regT /= 0) else "00001";



    find_hazard:PROCESS (clock, regS_mem_check,regS_exe_check,regT_mem_check,regT_mem_check,regT_exe_check,MEM_read_mem,MEM_read_EXE )
                    	
							BEGIN
								if (clock'event AND clock='1') then
                    		IF ((MEM_read_mem = '1'  and (regS_mem_check = "00000"  or regT_mem_check = "00000")) or ((MEM_read_EXE ='1' ) and (regS_exe_check = "00000"  or regT_exe_check = "00000")) or ((MEM_read_ID ='1' ) and (regS_ID_check = "00000"  or regT_ID_check = "00000"))) THEN
                    			data_hazard_en <= '0';
                    		ELSif NOT (((MEM_read_mem = '1'  and (regS_mem_check = "00000"  or regT_mem_check = "00000")) or ((MEM_read_EXE ='1' ) and (regS_exe_check = "00000"  or regT_exe_check = "00000")) or ((MEM_read_ID ='1' ) and (regS_ID_check = "00000"  or regT_ID_check = "00000")))) THEN
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
