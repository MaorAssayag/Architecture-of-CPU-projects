		-- HAZARD module (implements MIPS HAZARD unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY HAZARD IS
   PORT(
	      Instruction 		 : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	      data_hazard_en 		 : OUT 	STD_LOGIC;
      	clock, reset	   : IN 	STD_LOGIC
         );
END HAZARD;



ARCHITECTURE behavior OF HAZARD IS
component N_dff
    generic(N: integer := 5); --defualt value for N is 8
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



BEGIN


regdesbef <= Instruction( 15 DOWNTO 11 );
regS 	<= Instruction( 25 DOWNTO 21 );
regT	<= Instruction( 20 DOWNTO 16 );
regdes <= regdesbef when (regS /= dataH44 OR regT /= dataH44 OR regS /= dataH33 OR regT /= dataH33 OR regT /= dataH22  OR regS /= dataH22 ) else "00000";
dataH4_reg: N_dff port map (clock,'1', reset, regdes, dataH44);
dataH3_reg: N_dff port map (clock,'1', reset, dataH44, dataH33);
dataH2_reg: N_dff port map (clock,'1', reset, dataH33, dataH22);
dataH1_reg: N_dff port map (clock,'1', reset, dataH22, dataH11);
data_hazard_en <='0' when (regS = dataH44 OR regT = dataH44 OR  regS = dataH33 or regT = dataH33 or regT = dataH22  or regS = dataH22 )  else  '1'   ;


END behavior;
