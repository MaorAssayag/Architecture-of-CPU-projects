
library ieee;
use ieee.std_logic_1164.all;

-- IMportant NOTE , when using the host interface outside of the current project
-- Add the following lines to the project QSF file with no "--" prefix.

--set_location_assignment PIN_E8 -to tdi
--set_location_assignment PIN_D8 -to tcs
--set_location_assignment PIN_C7 -to tck
--set_location_assignment PIN_D7 -to tdo
--set_instance_assignment -name FAST_INPUT_REGISTER ON -to tck
--set_instance_assignment -name FAST_INPUT_REGISTER ON -to tdi
--set_instance_assignment -name FAST_INPUT_REGISTER ON -to tcs
--set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to tdo
--set_instance_assignment -name CLOCK_SETTINGS tck -to tck
--set_instance_assignment -name GLOBAL_SIGNAL "GLOBAL CLOCK" -to tck
--set_instance_assignment -name GLOBAL_SIGNAL ON -to tdi
--set_instance_assignment -name GLOBAL_SIGNAL ON -to tcs
--set_instance_assignment -name GLOBAL_SIGNAL ON -to tdo
--set_parameter -name CYCLONEII_SAFE_WRITE "\" VERIFIED_SAFE \""


entity top_level is
	port 
	(
		clock50m : in std_logic; 					--	50 MHz
		
		--	7-SEG Dispaly	
		hex0 : out std_logic_vector(6 downto 0);	--	Seven Segment Digit 0
		hex1 : out std_logic_vector(6 downto 0);	--	Seven Segment Digit 1
		hex2 : out std_logic_vector(6 downto 0);	--	Seven Segment Digit 2
		hex3 : out std_logic_vector(6 downto 0);	--	Seven Segment Digit 3
		--LED		
		ledg : out std_logic_vector(7 downto 0);	--	LED Green[7:0]
		ledr : out std_logic_vector(9 downto 0);	--	LED Red[9:0]
		
		--	USB JTAG link	- Do not change those pins , must always present
		tdi : in std_logic;  					-- CPLD -> FPGA (data in)
		tck : in std_logic;   					-- CPLD -> FPGA (clk)
		tcs : in std_logic;    					-- CPLD -> FPGA (CS)
	    tdo : out std_logic	    				-- FPGA -> CPLD (data out)
	);

end entity;

architecture rtl of top_level is
--	Program ROM Host signals - connect program rom to PC
	signal program_rom_addr	: std_logic_vector(16 downto 0);
	signal program_rom_data_wr	: std_logic_vector(15 downto 0);
	signal program_rom_data_rd	: std_logic_vector(15 downto 0);
	signal program_rom_we 		: std_logic;

--	Data Ram Host signals - connect data ram to PC
	signal data_ram_addr 		: std_logic_vector(16 downto 0);
	signal data_ram_data_wr	: std_logic_vector(15 downto 0);
	signal data_ram_data_rd	: std_logic_vector(15 downto 0);
	signal data_ram_we 		: std_logic;
	
	-- 8KByte Memory
	COMPONENT dual_port_ram_8k IS
	PORT
	(
		address_a		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		address_b		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock_a		: IN STD_LOGIC ;
		clock_b		: IN STD_LOGIC ;
		data_a		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data_b		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren_a		: IN STD_LOGIC  := '1';
		wren_b		: IN STD_LOGIC  := '1';
		q_a		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		q_b		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	end COMPONENT ;
	
	-- Host interface
	COMPONENT debug_memory_interface IS
	PORT
	(
		
		clock : IN STD_LOGIC ;				--	50 MHz

		--	7-SEG Dispaly	
		hex0 :  OUT STD_LOGIC_VECTOR (6 DOWNTO 0) ;					--	Seven Segment Digit 0
		hex1 :  OUT STD_LOGIC_VECTOR (6 DOWNTO 0) ;						--	Seven Segment Digit 1
		hex2 :  OUT STD_LOGIC_VECTOR (6 DOWNTO 0) ;						--	Seven Segment Digit 2
		hex3 :  OUT STD_LOGIC_VECTOR (6 DOWNTO 0) ;						--	Seven Segment Digit 3
		--	LED		
		ledg :  OUT STD_LOGIC_VECTOR (7 DOWNTO 0) ;						--	LED Green[7:0]
		ledr :  OUT STD_LOGIC_VECTOR (9 DOWNTO 0) ;						--	LED Red[9:0]

		--	USB JTAG link	
		tdi 				: IN STD_LOGIC ;					-- CPLD -> FPGA (data in)
		tck 				: IN STD_LOGIC ;					-- CPLD -> FPGA (clk)
		tcs 				: IN STD_LOGIC ;					-- CPLD -> FPGA (CS)
		tdo 				: OUT STD_LOGIC ;					-- FPGA -> CPLD (data out)
		
		--	Data Ram
		data_ram_addr 		:  OUT STD_LOGIC_VECTOR (16 DOWNTO 0) ;	
		data_ram_data_wr 	:  OUT STD_LOGIC_VECTOR (15 DOWNTO 0) ;	
		data_ram_data_rd 	:  IN STD_LOGIC_VECTOR (15 DOWNTO 0) ;	
		data_ram_we 		:  OUT STD_LOGIC ;	
		--	Program ROM 
		program_rom_addr 	:  OUT STD_LOGIC_VECTOR (16 DOWNTO 0) ;	
		program_rom_data_wr :  OUT STD_LOGIC_VECTOR (15 DOWNTO 0) ;	
		program_rom_data_rd :  IN STD_LOGIC_VECTOR (15 DOWNTO 0) ;	
		program_rom_we 		: OUT STD_LOGIC 	
	);
	end COMPONENT ;
	
	

begin


	-- Host interface to enable memory acess from host PC
	host_if : debug_memory_interface
	port map
	(
		
		clock=>clock50m, -- Must be 50Mhz clock
		--	7-SEG Dispaly	for testing , can be disconnected
		hex0=>hex0,					--	Seven Segment Digit 0
		hex1=>hex1,					--	Seven Segment Digit 1
		hex2=>hex2,					--	Seven Segment Digit 2
		hex3=>hex3,					--	Seven Segment Digit 3
		--	LED		for testing , can be disconnected
		ledg=>ledg,					--	LED Green[7:0]
		ledr=>ledr,					--	LED Red[9:0]

		--	USB JTAG link	Must be always connected
		tdi=>tdi,					-- CPLD -> FPGA (data in)
		tck=>tck,					-- CPLD -> FPGA (clk)
		tcs=>tcs,					-- CPLD -> FPGA (CS)
		tdo=>tdo,					-- FPGA -> CPLD (data out)
		
		--	Data Ram
		data_ram_addr		=>data_ram_addr,
		data_ram_data_wr	=>data_ram_data_wr,
		data_ram_data_rd	=>data_ram_data_rd,
		data_ram_we			=>data_ram_we,
		--	Program ROM 
		program_rom_addr	=>program_rom_addr,
		program_rom_data_wr	=>program_rom_data_wr,
		program_rom_data_rd	=>program_rom_data_rd,
		program_rom_we		=>program_rom_we
	
	);
	
	-- Program Memory located at SRAM address 0x20000
	program_memory : dual_port_ram_8k 
	port map
	(
	-- This interface goes to your CPU
		address_a	=> 	(OTHERS=>'0'),	-- Address
		clock_a		=>	clock50m, 		-- Connect your CPU clock
		q_a			=> 	open, 			-- Read Data connect to your CPU
		
		data_a		=> 	(OTHERS=>'0'), 	-- Not used in ROM
		wren_a		=> 	'0', 			-- Write always 0 for ROM
		
	-- Host Interface don't change
		address_b	=> 	program_rom_addr(11 downto 0),
		clock_b		=>	clock50m,
		data_b		=>	program_rom_data_wr,
		wren_b		=>	program_rom_we,
		q_b			=>	program_rom_data_rd
	);
	-- Data Memory	located at SRAM address 0x00000
	data_memory : dual_port_ram_8k 
	port map
	(
	-- This interface goes to your CPU
		address_a	=> 	(OTHERS=>'0'),	-- Address From CPU
		clock_a		=> 	clock50m, 		-- Connect your CPU clock
		data_a		=> 	(OTHERS=>'0'),	-- Write Data from CPU
		wren_a		=> 	'0', 			-- Write enable signal 
		q_a			=> 	open, 			-- Read Data to CPU
	-- Host Interface don't change
		address_b	=> 	data_ram_addr(11 downto 0),
		clock_b		=>	clock50m,
		data_b		=>	data_ram_data_wr,
		wren_b		=>	data_ram_we,
		q_b			=>	data_ram_data_rd
	);


	
end rtl;
