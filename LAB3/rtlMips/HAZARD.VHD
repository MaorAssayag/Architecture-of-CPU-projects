		-- HAZARD module (implements MIPS HAZARD unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY HAZARD IS
   PORT(
	      Instruction 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
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




SIGNAL  dataH11,dataH22,dataH33,dataH44	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regdes	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regdesbef	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regS	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  regT	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
SIGNAL  Opcode	: STD_LOGIC_VECTOR( 5 DOWNTO 0 );



BEGIN
------------------------------------      data hazard
      Opcode <= Instruction( 31 DOWNTO 26 );
      regdesbef <= Instruction( 15 DOWNTO 11 );
      regS 	<= Instruction( 25 DOWNTO 21 );
      regT	<= Instruction( 20 DOWNTO 16 );
      regdes <= regdesbef when ((regS /= dataH44 AND regT /= dataH44 AND regS /= dataH33 AND regT /= dataH33 AND regT /= dataH22  AND regS /= dataH22 ) and  Opcode = "000000") else "00000";
      dataH4_reg: N_dff generic map (5) port map (clock,'1', reset, regdes, dataH44);
      dataH3_reg: N_dff generic map (5) port map (clock,'1', reset, dataH44, dataH33);
      dataH2_reg: N_dff generic map (5) port map (clock,'1', reset, dataH33, dataH22);
      dataH1_reg: N_dff generic map (5) port map (clock,'1', reset, dataH22, dataH11);
      data_hazard_en <='0' when (((regS = dataH22 OR  regS = dataH33 OR regS = dataH44) AND regS /= "00000")   or((regT = dataH33 or regT = dataH22  or  regT = dataH44) AND regT /= "00000") )  else  '1'   ;
--------------------------------------



---------------------------------  branch HAZARD
Branch_en <= '1' when ( (( Branch_beq_hazard = '1' ) AND ( branch_zero = '1' )) OR (( Branch_bne_hazard = '1' ) AND ( branch_zero = '0' )) )
else '0';
-----------------------------------------

END behavior;
