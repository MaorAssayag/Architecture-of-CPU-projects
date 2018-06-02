				-- Top Level Structural Model for CPU_FPGA
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY CPU_FPGA IS

		PORT( button_mips      :     IN 	STD_LOGIC;
		      button_GPIO      :     IN 	STD_LOGIC;
					button_reset     :     IN 	STD_LOGIC;
					LO_1    			   :     out  std_logic_vector (6 downto 0);
					LO_2    				 :     out  std_logic_vector (6 downto 0);
					HI_1    				 :     out  std_logic_vector (6 downto 0);
					HI_2   					 :     out  std_logic_vector (6 downto 0);
					clock            :     IN 	STD_LOGIC
					);
		END 	CPU_FPGA;

ARCHITECTURE structure OF CPU_FPGA IS

COMPONENT MIPS
				PORT (
					 clock           : IN     STD_LOGIC;
					 reset           : IN     STD_LOGIC;
					 ALU_result_out  : OUT    STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
					 Branch_out      : OUT    STD_LOGIC;
					 Instruction_out : OUT    STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
					 Memwrite_out    : OUT    STD_LOGIC;
					 PC              : OUT    STD_LOGIC_VECTOR ( 9 DOWNTO 0 );
					 Regwrite_out    : OUT    STD_LOGIC;
					 Zero_out        : OUT    STD_LOGIC;
					 read_data_1_out : OUT    STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
					 read_data_2_out : OUT    STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
					 write_data_out  : OUT    STD_LOGIC_VECTOR ( 31 DOWNTO 0 )
				);
END COMPONENT;

COMPONENT display_7_segment
    port (
    	q        : in std_logic_vector (7 downto 0);
    	segment1 : out std_logic_vector (6 downto 0);
      segment2 : out std_logic_vector (6 downto 0));
end COMPONENT;

COMPONENT Counter  port (
	clk,enable : in std_logic;
	q          : out std_logic_vector (7 downto 0));
end COMPONENT;
-------------------------------- mips SIGNAL
SIGNAL ALU_result_out  :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL Branch_out      :     STD_LOGIC;
SIGNAL Instruction_out :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL Memwrite_out    :     STD_LOGIC;
SIGNAL PC              :     STD_LOGIC_VECTOR ( 9 DOWNTO 0 );
SIGNAL Regwrite_out    :     STD_LOGIC;
SIGNAL Zero_out        :     STD_LOGIC;
SIGNAL clock_mips        :     STD_LOGIC;
SIGNAL read_data_1_out :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL read_data_2_out :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL write_data_out  :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );

------------------------------------


-------------------------- 7-seg
SIGNAL q                 :     STD_LOGIC_VECTOR ( 7 DOWNTO 0 );
SIGNAL en_7_seg          :     STD_LOGIC:= '0';
SIGNAL en_mips          :     STD_LOGIC:= '0';
SIGNAL memread                 :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL next_PC, Mem_Addr : STD_LOGIC_VECTOR( 7 DOWNTO 0 ) := "00000000";
SIGNAL PC_plus_4         : STD_LOGIC_VECTOR( 9 DOWNTO 0 ) := "0000000000";




BEGIN
-------------------------------------------   enable form button
clock_mips <= en_mips and clock;


LO_1 <= "0000000";
LO_2 <= "0000000";
HI_1 <= "0000000";
HI_2 <= "0000000";

counter_en:process (button_GPIO)
						begin
								if (rising_edge(button_GPIO)) then
										en_7_seg <= not (en_7_seg);
										next_PC <=  "00000000";
							 end if;
						end process;

mips_en:process (button_mips)
					begin
							if (rising_edge(button_mips)) then
									en_mips <= not (en_mips);
						 end if;
					end process;


-----------------------------


-----------------------------------    mips
MIPS_unit : MIPS
	 PORT MAP (
			clock           => clock_mips,
			reset           => '0',
			PC              => PC,
			ALU_result_out  => ALU_result_out,
			read_data_1_out => read_data_1_out,
			read_data_2_out => read_data_2_out,
			write_data_out  => write_data_out,
			Instruction_out => Instruction_out,
			Branch_out      => Branch_out,
			Zero_out        => Zero_out,
			Memwrite_out    => Memwrite_out,
			Regwrite_out    => Regwrite_out
	 );

--------------------------------------



-------------------------------        display
Counter_unit : Counter
			PORT MAP (
					clk => clock,
					enable => en_7_seg,
					q => q
			);



memory: altsyncram

				GENERIC MAP (
					operation_mode => "SINGLE_PORT",
					width_a => 32,
					widthad_a => 8,
					lpm_type => "altsyncram",
					outdata_reg_a => "UNREGISTERED",
					init_file => "dmemory.hex",
					intended_device_family => "Cyclone"
				)
				PORT MAP (
					clock0     =>  q(0) ,
					address_a 	=> Mem_Addr,
					q_a 			=> memread );

	Mem_Addr <= Next_PC;
	-- Adder to increment PC by 4
	PC_plus_4( 9 DOWNTO 2 )  <= Next_PC + 1;
	PC_plus_4( 1 DOWNTO 0 )  <= "00";


convert_7_segment_1: display_7_segment port map (memread( 7 downto 0),LO_1, LO_2);
convert_7_segment_2: display_7_segment port map (memread(15 downto 8),HI_1,HI_2);


display7 : process
begin
wait until q(0)'event and q(0) = '1';
		Next_PC  <=   PC_plus_4( 9 DOWNTO 2 );
end process;




---------------------



END structure;
