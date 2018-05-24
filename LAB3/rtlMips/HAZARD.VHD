		-- HAZARD module (implements MIPS HAZARD unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY HAZARD IS
   PORT(
	      Instruction 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	      data_hazard 		 : OUT 	STD_LOGIC;
      	clock, reset	: IN 	STD_LOGIC );
        dataH1,dataH2,dataH3	: OUT STD_LOGIC_VECTOR( 4 DOWNTO 0 );


END HAZARD;

component N_dff
    generic(N: integer := 8); --defualt value for N is 8
    port (
        clk : in std_logic;
        enable : in std_logic;
        rst : in std_logic;
        D : in STD_LOGIC_VECTOR(N-1 downto 0);
        Q : out STD_LOGIC_VECTOR(N-1 downto 0));
end component;

ARCHITECTURE behavior OF HAZARD IS

	SIGNAL  dataH1,dataH2,dataH3	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );

BEGIN

dataH3_reg: N_dff port map (clock,'1', reset, Instruction( 15 DOWNTO 11 ), dataH3);
dataH2_reg: N_dff port map (clock,'1', reset, dataH3, dataH2);
dataH1_reg: N_dff port map (clock,'1', reset, dataH2, dataH1);
data_hazard => '1';


END behavior;
