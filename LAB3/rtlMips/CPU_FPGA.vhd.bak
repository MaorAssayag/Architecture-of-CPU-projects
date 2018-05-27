				-- Top Level Structural Model for CPU_FPGA
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

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

COMPONENT counter  port (
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
SIGNAL clock|_mips        :     STD_LOGIC;
SIGNAL read_data_1_out :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL read_data_2_out :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 );
SIGNAL write_data_out  :     STD_LOGIC_VECTOR ( 31 DOWNTO 0 )

------------------------------------


-------------------------- 7-seg
SIGNAL q                 :     STD_LOGIC_VECTOR ( 9 DOWNTO 0 );
SIGNAL secend_clock      :     STD_LOGIC;
SIGNAL en_7_seg          :     STD_LOGIC;
SIGNAL en_mips          :     STD_LOGIC;




BEGIN
-------------------------------------------   enable form button
en_7_seg := '0';
en_mips := '0';
clock_mips <= en_mips and clock;

counter_en:process (button_GPIO)
						begin
								if (button_GPIO = '1') then
										en_7_seg <= not (en_7_seg)
							 end if;
						end process;

mips_en:process (button_mips)
					begin
							if (button_mips = '1') then
									en_mips <= not (en_mips)
						 end if;
					end process;


-----------------------------



MIPS_unit : MIPS
	 PORT MAP (
			reset           => not(button_reset),
			clock           => clock_mips,
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






counter_unit : counter
			PORT MAP (
					clk => clock,
					enable => en_7_seg,
					q => q
			);



END structure;
