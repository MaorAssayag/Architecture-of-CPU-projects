-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 12.1 Build 177 11/07/2012 SJ Web Edition"

-- DATE "05/06/2018 14:04:46"

-- 
-- Device: Altera EP2C20F484C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	counter IS
    PORT (
	clk : IN std_logic;
	enable : IN std_logic;
	q : OUT std_logic_vector(7 DOWNTO 0);
	HEX0 : OUT std_logic_vector(6 DOWNTO 0);
	HEX1 : OUT std_logic_vector(6 DOWNTO 0)
	);
END counter;

-- Design Ports Information
-- q[0]	=>  Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- q[1]	=>  Location: PIN_U21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- q[2]	=>  Location: PIN_V22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- q[3]	=>  Location: PIN_V21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- q[4]	=>  Location: PIN_W22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- q[5]	=>  Location: PIN_W21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- q[6]	=>  Location: PIN_Y22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- q[7]	=>  Location: PIN_Y21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[0]	=>  Location: PIN_J2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[1]	=>  Location: PIN_J1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[2]	=>  Location: PIN_H2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[3]	=>  Location: PIN_H1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[4]	=>  Location: PIN_F2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[5]	=>  Location: PIN_F1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[6]	=>  Location: PIN_E2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[0]	=>  Location: PIN_E1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[1]	=>  Location: PIN_H6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[2]	=>  Location: PIN_H5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[3]	=>  Location: PIN_H4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[4]	=>  Location: PIN_G3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[5]	=>  Location: PIN_D2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[6]	=>  Location: PIN_D1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- clk	=>  Location: PIN_L1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- enable	=>  Location: PIN_L22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF counter IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_enable : std_logic;
SIGNAL ww_q : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_HEX0 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX1 : std_logic_vector(6 DOWNTO 0);
SIGNAL \clk~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \q_int[1]~31_combout\ : std_logic;
SIGNAL \q_int[3]~35_combout\ : std_logic;
SIGNAL \q_int[5]~39_combout\ : std_logic;
SIGNAL \q_int[19]~67_combout\ : std_logic;
SIGNAL \q_int[21]~71_combout\ : std_logic;
SIGNAL \q_int[22]~73_combout\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \clk~clkctrl_outclk\ : std_logic;
SIGNAL \enable~combout\ : std_logic;
SIGNAL \q_int[0]~93_combout\ : std_logic;
SIGNAL \q_int[1]~32\ : std_logic;
SIGNAL \q_int[2]~33_combout\ : std_logic;
SIGNAL \q_int[2]~34\ : std_logic;
SIGNAL \q_int[3]~36\ : std_logic;
SIGNAL \q_int[4]~37_combout\ : std_logic;
SIGNAL \q_int[4]~38\ : std_logic;
SIGNAL \q_int[5]~40\ : std_logic;
SIGNAL \q_int[6]~41_combout\ : std_logic;
SIGNAL \q_int[6]~42\ : std_logic;
SIGNAL \q_int[7]~43_combout\ : std_logic;
SIGNAL \q_int[7]~44\ : std_logic;
SIGNAL \q_int[8]~45_combout\ : std_logic;
SIGNAL \q_int[8]~46\ : std_logic;
SIGNAL \q_int[9]~47_combout\ : std_logic;
SIGNAL \q_int[9]~48\ : std_logic;
SIGNAL \q_int[10]~49_combout\ : std_logic;
SIGNAL \q_int[10]~50\ : std_logic;
SIGNAL \q_int[11]~51_combout\ : std_logic;
SIGNAL \q_int[11]~52\ : std_logic;
SIGNAL \q_int[12]~53_combout\ : std_logic;
SIGNAL \q_int[12]~54\ : std_logic;
SIGNAL \q_int[13]~55_combout\ : std_logic;
SIGNAL \q_int[13]~56\ : std_logic;
SIGNAL \q_int[14]~57_combout\ : std_logic;
SIGNAL \q_int[14]~58\ : std_logic;
SIGNAL \q_int[15]~59_combout\ : std_logic;
SIGNAL \q_int[15]~60\ : std_logic;
SIGNAL \q_int[16]~61_combout\ : std_logic;
SIGNAL \q_int[16]~62\ : std_logic;
SIGNAL \q_int[17]~63_combout\ : std_logic;
SIGNAL \q_int[17]~64\ : std_logic;
SIGNAL \q_int[18]~65_combout\ : std_logic;
SIGNAL \q_int[18]~66\ : std_logic;
SIGNAL \q_int[19]~68\ : std_logic;
SIGNAL \q_int[20]~69_combout\ : std_logic;
SIGNAL \q_int[20]~70\ : std_logic;
SIGNAL \q_int[21]~72\ : std_logic;
SIGNAL \q_int[22]~74\ : std_logic;
SIGNAL \q_int[23]~75_combout\ : std_logic;
SIGNAL \q_int[23]~76\ : std_logic;
SIGNAL \q_int[24]~77_combout\ : std_logic;
SIGNAL \q_int[24]~78\ : std_logic;
SIGNAL \q_int[25]~79_combout\ : std_logic;
SIGNAL \q_int[25]~80\ : std_logic;
SIGNAL \q_int[26]~81_combout\ : std_logic;
SIGNAL \q_int[26]~82\ : std_logic;
SIGNAL \q_int[27]~83_combout\ : std_logic;
SIGNAL \q_int[27]~84\ : std_logic;
SIGNAL \q_int[28]~85_combout\ : std_logic;
SIGNAL \q_int[28]~86\ : std_logic;
SIGNAL \q_int[29]~87_combout\ : std_logic;
SIGNAL \q_int[29]~88\ : std_logic;
SIGNAL \q_int[30]~89_combout\ : std_logic;
SIGNAL \q_int[30]~90\ : std_logic;
SIGNAL \q_int[31]~91_combout\ : std_logic;
SIGNAL \component_7_segment|Mux13~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux12~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux11~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux10~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux9~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux8~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux7~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux6~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux5~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux4~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux3~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux2~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux1~0_combout\ : std_logic;
SIGNAL \component_7_segment|Mux0~0_combout\ : std_logic;
SIGNAL q_int : std_logic_vector(31 DOWNTO 0);
SIGNAL \component_7_segment|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \component_7_segment|ALT_INV_Mux7~0_combout\ : std_logic;

BEGIN

ww_clk <= clk;
ww_enable <= enable;
q <= ww_q;
HEX0 <= ww_HEX0;
HEX1 <= ww_HEX1;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \clk~combout\);
\component_7_segment|ALT_INV_Mux0~0_combout\ <= NOT \component_7_segment|Mux0~0_combout\;
\component_7_segment|ALT_INV_Mux7~0_combout\ <= NOT \component_7_segment|Mux7~0_combout\;

-- Location: LCFF_X49_Y14_N13
\q_int[22]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[22]~73_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(22));

-- Location: LCFF_X49_Y14_N11
\q_int[21]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[21]~71_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(21));

-- Location: LCFF_X49_Y14_N7
\q_int[19]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[19]~67_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(19));

-- Location: LCFF_X49_Y15_N11
\q_int[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[5]~39_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(5));

-- Location: LCFF_X49_Y15_N7
\q_int[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[3]~35_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(3));

-- Location: LCFF_X49_Y15_N3
\q_int[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[1]~31_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(1));

-- Location: LCCOMB_X49_Y15_N2
\q_int[1]~31\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[1]~31_combout\ = (q_int(1) & (q_int(0) $ (VCC))) # (!q_int(1) & (q_int(0) & VCC))
-- \q_int[1]~32\ = CARRY((q_int(1) & q_int(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(1),
	datab => q_int(0),
	datad => VCC,
	combout => \q_int[1]~31_combout\,
	cout => \q_int[1]~32\);

-- Location: LCCOMB_X49_Y15_N6
\q_int[3]~35\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[3]~35_combout\ = (q_int(3) & (\q_int[2]~34\ $ (GND))) # (!q_int(3) & (!\q_int[2]~34\ & VCC))
-- \q_int[3]~36\ = CARRY((q_int(3) & !\q_int[2]~34\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(3),
	datad => VCC,
	cin => \q_int[2]~34\,
	combout => \q_int[3]~35_combout\,
	cout => \q_int[3]~36\);

-- Location: LCCOMB_X49_Y15_N10
\q_int[5]~39\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[5]~39_combout\ = (q_int(5) & (\q_int[4]~38\ $ (GND))) # (!q_int(5) & (!\q_int[4]~38\ & VCC))
-- \q_int[5]~40\ = CARRY((q_int(5) & !\q_int[4]~38\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(5),
	datad => VCC,
	cin => \q_int[4]~38\,
	combout => \q_int[5]~39_combout\,
	cout => \q_int[5]~40\);

-- Location: LCCOMB_X49_Y14_N6
\q_int[19]~67\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[19]~67_combout\ = (q_int(19) & (\q_int[18]~66\ $ (GND))) # (!q_int(19) & (!\q_int[18]~66\ & VCC))
-- \q_int[19]~68\ = CARRY((q_int(19) & !\q_int[18]~66\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(19),
	datad => VCC,
	cin => \q_int[18]~66\,
	combout => \q_int[19]~67_combout\,
	cout => \q_int[19]~68\);

-- Location: LCCOMB_X49_Y14_N10
\q_int[21]~71\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[21]~71_combout\ = (q_int(21) & (\q_int[20]~70\ $ (GND))) # (!q_int(21) & (!\q_int[20]~70\ & VCC))
-- \q_int[21]~72\ = CARRY((q_int(21) & !\q_int[20]~70\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(21),
	datad => VCC,
	cin => \q_int[20]~70\,
	combout => \q_int[21]~71_combout\,
	cout => \q_int[21]~72\);

-- Location: LCCOMB_X49_Y14_N12
\q_int[22]~73\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[22]~73_combout\ = (q_int(22) & (!\q_int[21]~72\)) # (!q_int(22) & ((\q_int[21]~72\) # (GND)))
-- \q_int[22]~74\ = CARRY((!\q_int[21]~72\) # (!q_int(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(22),
	datad => VCC,
	cin => \q_int[21]~72\,
	combout => \q_int[22]~73_combout\,
	cout => \q_int[22]~74\);

-- Location: PIN_L1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_clk,
	combout => \clk~combout\);

-- Location: CLKCTRL_G2
\clk~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~clkctrl_outclk\);

-- Location: PIN_L22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\enable~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_enable,
	combout => \enable~combout\);

-- Location: LCCOMB_X49_Y15_N0
\q_int[0]~93\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[0]~93_combout\ = q_int(0) $ (\enable~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => q_int(0),
	datad => \enable~combout\,
	combout => \q_int[0]~93_combout\);

-- Location: LCFF_X49_Y15_N1
\q_int[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[0]~93_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(0));

-- Location: LCCOMB_X49_Y15_N4
\q_int[2]~33\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[2]~33_combout\ = (q_int(2) & (!\q_int[1]~32\)) # (!q_int(2) & ((\q_int[1]~32\) # (GND)))
-- \q_int[2]~34\ = CARRY((!\q_int[1]~32\) # (!q_int(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(2),
	datad => VCC,
	cin => \q_int[1]~32\,
	combout => \q_int[2]~33_combout\,
	cout => \q_int[2]~34\);

-- Location: LCFF_X49_Y15_N5
\q_int[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[2]~33_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(2));

-- Location: LCCOMB_X49_Y15_N8
\q_int[4]~37\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[4]~37_combout\ = (q_int(4) & (!\q_int[3]~36\)) # (!q_int(4) & ((\q_int[3]~36\) # (GND)))
-- \q_int[4]~38\ = CARRY((!\q_int[3]~36\) # (!q_int(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(4),
	datad => VCC,
	cin => \q_int[3]~36\,
	combout => \q_int[4]~37_combout\,
	cout => \q_int[4]~38\);

-- Location: LCFF_X49_Y15_N9
\q_int[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[4]~37_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(4));

-- Location: LCCOMB_X49_Y15_N12
\q_int[6]~41\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[6]~41_combout\ = (q_int(6) & (!\q_int[5]~40\)) # (!q_int(6) & ((\q_int[5]~40\) # (GND)))
-- \q_int[6]~42\ = CARRY((!\q_int[5]~40\) # (!q_int(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(6),
	datad => VCC,
	cin => \q_int[5]~40\,
	combout => \q_int[6]~41_combout\,
	cout => \q_int[6]~42\);

-- Location: LCFF_X49_Y15_N13
\q_int[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[6]~41_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(6));

-- Location: LCCOMB_X49_Y15_N14
\q_int[7]~43\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[7]~43_combout\ = (q_int(7) & (\q_int[6]~42\ $ (GND))) # (!q_int(7) & (!\q_int[6]~42\ & VCC))
-- \q_int[7]~44\ = CARRY((q_int(7) & !\q_int[6]~42\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(7),
	datad => VCC,
	cin => \q_int[6]~42\,
	combout => \q_int[7]~43_combout\,
	cout => \q_int[7]~44\);

-- Location: LCFF_X49_Y15_N15
\q_int[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[7]~43_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(7));

-- Location: LCCOMB_X49_Y15_N16
\q_int[8]~45\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[8]~45_combout\ = (q_int(8) & (!\q_int[7]~44\)) # (!q_int(8) & ((\q_int[7]~44\) # (GND)))
-- \q_int[8]~46\ = CARRY((!\q_int[7]~44\) # (!q_int(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(8),
	datad => VCC,
	cin => \q_int[7]~44\,
	combout => \q_int[8]~45_combout\,
	cout => \q_int[8]~46\);

-- Location: LCFF_X49_Y15_N17
\q_int[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[8]~45_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(8));

-- Location: LCCOMB_X49_Y15_N18
\q_int[9]~47\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[9]~47_combout\ = (q_int(9) & (\q_int[8]~46\ $ (GND))) # (!q_int(9) & (!\q_int[8]~46\ & VCC))
-- \q_int[9]~48\ = CARRY((q_int(9) & !\q_int[8]~46\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(9),
	datad => VCC,
	cin => \q_int[8]~46\,
	combout => \q_int[9]~47_combout\,
	cout => \q_int[9]~48\);

-- Location: LCFF_X49_Y15_N19
\q_int[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[9]~47_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(9));

-- Location: LCCOMB_X49_Y15_N20
\q_int[10]~49\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[10]~49_combout\ = (q_int(10) & (!\q_int[9]~48\)) # (!q_int(10) & ((\q_int[9]~48\) # (GND)))
-- \q_int[10]~50\ = CARRY((!\q_int[9]~48\) # (!q_int(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(10),
	datad => VCC,
	cin => \q_int[9]~48\,
	combout => \q_int[10]~49_combout\,
	cout => \q_int[10]~50\);

-- Location: LCFF_X49_Y15_N21
\q_int[10]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[10]~49_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(10));

-- Location: LCCOMB_X49_Y15_N22
\q_int[11]~51\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[11]~51_combout\ = (q_int(11) & (\q_int[10]~50\ $ (GND))) # (!q_int(11) & (!\q_int[10]~50\ & VCC))
-- \q_int[11]~52\ = CARRY((q_int(11) & !\q_int[10]~50\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(11),
	datad => VCC,
	cin => \q_int[10]~50\,
	combout => \q_int[11]~51_combout\,
	cout => \q_int[11]~52\);

-- Location: LCFF_X49_Y15_N23
\q_int[11]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[11]~51_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(11));

-- Location: LCCOMB_X49_Y15_N24
\q_int[12]~53\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[12]~53_combout\ = (q_int(12) & (!\q_int[11]~52\)) # (!q_int(12) & ((\q_int[11]~52\) # (GND)))
-- \q_int[12]~54\ = CARRY((!\q_int[11]~52\) # (!q_int(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(12),
	datad => VCC,
	cin => \q_int[11]~52\,
	combout => \q_int[12]~53_combout\,
	cout => \q_int[12]~54\);

-- Location: LCFF_X49_Y15_N25
\q_int[12]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[12]~53_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(12));

-- Location: LCCOMB_X49_Y15_N26
\q_int[13]~55\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[13]~55_combout\ = (q_int(13) & (\q_int[12]~54\ $ (GND))) # (!q_int(13) & (!\q_int[12]~54\ & VCC))
-- \q_int[13]~56\ = CARRY((q_int(13) & !\q_int[12]~54\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(13),
	datad => VCC,
	cin => \q_int[12]~54\,
	combout => \q_int[13]~55_combout\,
	cout => \q_int[13]~56\);

-- Location: LCFF_X49_Y15_N27
\q_int[13]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[13]~55_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(13));

-- Location: LCCOMB_X49_Y15_N28
\q_int[14]~57\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[14]~57_combout\ = (q_int(14) & (!\q_int[13]~56\)) # (!q_int(14) & ((\q_int[13]~56\) # (GND)))
-- \q_int[14]~58\ = CARRY((!\q_int[13]~56\) # (!q_int(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(14),
	datad => VCC,
	cin => \q_int[13]~56\,
	combout => \q_int[14]~57_combout\,
	cout => \q_int[14]~58\);

-- Location: LCFF_X49_Y15_N29
\q_int[14]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[14]~57_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(14));

-- Location: LCCOMB_X49_Y15_N30
\q_int[15]~59\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[15]~59_combout\ = (q_int(15) & (\q_int[14]~58\ $ (GND))) # (!q_int(15) & (!\q_int[14]~58\ & VCC))
-- \q_int[15]~60\ = CARRY((q_int(15) & !\q_int[14]~58\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(15),
	datad => VCC,
	cin => \q_int[14]~58\,
	combout => \q_int[15]~59_combout\,
	cout => \q_int[15]~60\);

-- Location: LCFF_X49_Y15_N31
\q_int[15]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[15]~59_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(15));

-- Location: LCCOMB_X49_Y14_N0
\q_int[16]~61\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[16]~61_combout\ = (q_int(16) & (!\q_int[15]~60\)) # (!q_int(16) & ((\q_int[15]~60\) # (GND)))
-- \q_int[16]~62\ = CARRY((!\q_int[15]~60\) # (!q_int(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(16),
	datad => VCC,
	cin => \q_int[15]~60\,
	combout => \q_int[16]~61_combout\,
	cout => \q_int[16]~62\);

-- Location: LCFF_X49_Y14_N1
\q_int[16]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[16]~61_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(16));

-- Location: LCCOMB_X49_Y14_N2
\q_int[17]~63\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[17]~63_combout\ = (q_int(17) & (\q_int[16]~62\ $ (GND))) # (!q_int(17) & (!\q_int[16]~62\ & VCC))
-- \q_int[17]~64\ = CARRY((q_int(17) & !\q_int[16]~62\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(17),
	datad => VCC,
	cin => \q_int[16]~62\,
	combout => \q_int[17]~63_combout\,
	cout => \q_int[17]~64\);

-- Location: LCFF_X49_Y14_N3
\q_int[17]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[17]~63_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(17));

-- Location: LCCOMB_X49_Y14_N4
\q_int[18]~65\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[18]~65_combout\ = (q_int(18) & (!\q_int[17]~64\)) # (!q_int(18) & ((\q_int[17]~64\) # (GND)))
-- \q_int[18]~66\ = CARRY((!\q_int[17]~64\) # (!q_int(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(18),
	datad => VCC,
	cin => \q_int[17]~64\,
	combout => \q_int[18]~65_combout\,
	cout => \q_int[18]~66\);

-- Location: LCFF_X49_Y14_N5
\q_int[18]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[18]~65_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(18));

-- Location: LCCOMB_X49_Y14_N8
\q_int[20]~69\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[20]~69_combout\ = (q_int(20) & (!\q_int[19]~68\)) # (!q_int(20) & ((\q_int[19]~68\) # (GND)))
-- \q_int[20]~70\ = CARRY((!\q_int[19]~68\) # (!q_int(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(20),
	datad => VCC,
	cin => \q_int[19]~68\,
	combout => \q_int[20]~69_combout\,
	cout => \q_int[20]~70\);

-- Location: LCFF_X49_Y14_N9
\q_int[20]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[20]~69_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(20));

-- Location: LCCOMB_X49_Y14_N14
\q_int[23]~75\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[23]~75_combout\ = (q_int(23) & (\q_int[22]~74\ $ (GND))) # (!q_int(23) & (!\q_int[22]~74\ & VCC))
-- \q_int[23]~76\ = CARRY((q_int(23) & !\q_int[22]~74\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(23),
	datad => VCC,
	cin => \q_int[22]~74\,
	combout => \q_int[23]~75_combout\,
	cout => \q_int[23]~76\);

-- Location: LCFF_X49_Y14_N15
\q_int[23]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[23]~75_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(23));

-- Location: LCCOMB_X49_Y14_N16
\q_int[24]~77\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[24]~77_combout\ = (q_int(24) & (!\q_int[23]~76\)) # (!q_int(24) & ((\q_int[23]~76\) # (GND)))
-- \q_int[24]~78\ = CARRY((!\q_int[23]~76\) # (!q_int(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(24),
	datad => VCC,
	cin => \q_int[23]~76\,
	combout => \q_int[24]~77_combout\,
	cout => \q_int[24]~78\);

-- Location: LCFF_X49_Y14_N17
\q_int[24]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[24]~77_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(24));

-- Location: LCCOMB_X49_Y14_N18
\q_int[25]~79\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[25]~79_combout\ = (q_int(25) & (\q_int[24]~78\ $ (GND))) # (!q_int(25) & (!\q_int[24]~78\ & VCC))
-- \q_int[25]~80\ = CARRY((q_int(25) & !\q_int[24]~78\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(25),
	datad => VCC,
	cin => \q_int[24]~78\,
	combout => \q_int[25]~79_combout\,
	cout => \q_int[25]~80\);

-- Location: LCFF_X49_Y14_N19
\q_int[25]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[25]~79_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(25));

-- Location: LCCOMB_X49_Y14_N20
\q_int[26]~81\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[26]~81_combout\ = (q_int(26) & (!\q_int[25]~80\)) # (!q_int(26) & ((\q_int[25]~80\) # (GND)))
-- \q_int[26]~82\ = CARRY((!\q_int[25]~80\) # (!q_int(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datad => VCC,
	cin => \q_int[25]~80\,
	combout => \q_int[26]~81_combout\,
	cout => \q_int[26]~82\);

-- Location: LCFF_X49_Y14_N21
\q_int[26]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[26]~81_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(26));

-- Location: LCCOMB_X49_Y14_N22
\q_int[27]~83\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[27]~83_combout\ = (q_int(27) & (\q_int[26]~82\ $ (GND))) # (!q_int(27) & (!\q_int[26]~82\ & VCC))
-- \q_int[27]~84\ = CARRY((q_int(27) & !\q_int[26]~82\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(27),
	datad => VCC,
	cin => \q_int[26]~82\,
	combout => \q_int[27]~83_combout\,
	cout => \q_int[27]~84\);

-- Location: LCFF_X49_Y14_N23
\q_int[27]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[27]~83_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(27));

-- Location: LCCOMB_X49_Y14_N24
\q_int[28]~85\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[28]~85_combout\ = (q_int(28) & (!\q_int[27]~84\)) # (!q_int(28) & ((\q_int[27]~84\) # (GND)))
-- \q_int[28]~86\ = CARRY((!\q_int[27]~84\) # (!q_int(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datad => VCC,
	cin => \q_int[27]~84\,
	combout => \q_int[28]~85_combout\,
	cout => \q_int[28]~86\);

-- Location: LCFF_X49_Y14_N25
\q_int[28]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[28]~85_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(28));

-- Location: LCCOMB_X49_Y14_N26
\q_int[29]~87\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[29]~87_combout\ = (q_int(29) & (\q_int[28]~86\ $ (GND))) # (!q_int(29) & (!\q_int[28]~86\ & VCC))
-- \q_int[29]~88\ = CARRY((q_int(29) & !\q_int[28]~86\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(29),
	datad => VCC,
	cin => \q_int[28]~86\,
	combout => \q_int[29]~87_combout\,
	cout => \q_int[29]~88\);

-- Location: LCFF_X49_Y14_N27
\q_int[29]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[29]~87_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(29));

-- Location: LCCOMB_X49_Y14_N28
\q_int[30]~89\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[30]~89_combout\ = (q_int(30) & (!\q_int[29]~88\)) # (!q_int(30) & ((\q_int[29]~88\) # (GND)))
-- \q_int[30]~90\ = CARRY((!\q_int[29]~88\) # (!q_int(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => q_int(30),
	datad => VCC,
	cin => \q_int[29]~88\,
	combout => \q_int[30]~89_combout\,
	cout => \q_int[30]~90\);

-- Location: LCFF_X49_Y14_N29
\q_int[30]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[30]~89_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(30));

-- Location: LCCOMB_X49_Y14_N30
\q_int[31]~91\ : cycloneii_lcell_comb
-- Equation(s):
-- \q_int[31]~91_combout\ = \q_int[30]~90\ $ (!q_int(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => q_int(31),
	cin => \q_int[30]~90\,
	combout => \q_int[31]~91_combout\);

-- Location: LCFF_X49_Y14_N31
\q_int[31]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clk~clkctrl_outclk\,
	datain => \q_int[31]~91_combout\,
	ena => \enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => q_int(31));

-- Location: LCCOMB_X1_Y18_N28
\component_7_segment|Mux13~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux13~0_combout\ = (q_int(26) & (!q_int(25) & (q_int(24) $ (!q_int(27))))) # (!q_int(26) & (q_int(24) & (q_int(25) $ (!q_int(27)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100000000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datab => q_int(24),
	datac => q_int(25),
	datad => q_int(27),
	combout => \component_7_segment|Mux13~0_combout\);

-- Location: LCCOMB_X1_Y18_N22
\component_7_segment|Mux12~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux12~0_combout\ = (q_int(25) & ((q_int(24) & ((q_int(27)))) # (!q_int(24) & (q_int(26))))) # (!q_int(25) & (q_int(26) & (q_int(24) $ (q_int(27)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datab => q_int(24),
	datac => q_int(25),
	datad => q_int(27),
	combout => \component_7_segment|Mux12~0_combout\);

-- Location: LCCOMB_X1_Y18_N0
\component_7_segment|Mux11~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux11~0_combout\ = (q_int(26) & (q_int(27) & ((q_int(25)) # (!q_int(24))))) # (!q_int(26) & (!q_int(24) & (q_int(25) & !q_int(27))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datab => q_int(24),
	datac => q_int(25),
	datad => q_int(27),
	combout => \component_7_segment|Mux11~0_combout\);

-- Location: LCCOMB_X1_Y18_N2
\component_7_segment|Mux10~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux10~0_combout\ = (q_int(25) & (q_int(26) & (q_int(24)))) # (!q_int(25) & (!q_int(27) & (q_int(26) $ (q_int(24)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datab => q_int(24),
	datac => q_int(25),
	datad => q_int(27),
	combout => \component_7_segment|Mux10~0_combout\);

-- Location: LCCOMB_X1_Y18_N24
\component_7_segment|Mux9~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux9~0_combout\ = (q_int(25) & (((q_int(24) & !q_int(27))))) # (!q_int(25) & ((q_int(26) & ((!q_int(27)))) # (!q_int(26) & (q_int(24)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010011001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datab => q_int(24),
	datac => q_int(25),
	datad => q_int(27),
	combout => \component_7_segment|Mux9~0_combout\);

-- Location: LCCOMB_X1_Y18_N6
\component_7_segment|Mux8~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux8~0_combout\ = (q_int(24) & (q_int(27) $ (((q_int(25)) # (!q_int(26)))))) # (!q_int(24) & (!q_int(26) & (q_int(25))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001100011010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datab => q_int(24),
	datac => q_int(25),
	datad => q_int(27),
	combout => \component_7_segment|Mux8~0_combout\);

-- Location: LCCOMB_X1_Y18_N12
\component_7_segment|Mux7~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux7~0_combout\ = (q_int(24) & ((q_int(27)) # (q_int(26) $ (q_int(25))))) # (!q_int(24) & ((q_int(25)) # (q_int(26) $ (q_int(27)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110101111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(26),
	datab => q_int(24),
	datac => q_int(25),
	datad => q_int(27),
	combout => \component_7_segment|Mux7~0_combout\);

-- Location: LCCOMB_X1_Y21_N8
\component_7_segment|Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux6~0_combout\ = (q_int(30) & (!q_int(29) & (q_int(28) $ (!q_int(31))))) # (!q_int(30) & (q_int(28) & (q_int(29) $ (!q_int(31)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100000010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datab => q_int(29),
	datac => q_int(30),
	datad => q_int(31),
	combout => \component_7_segment|Mux6~0_combout\);

-- Location: LCCOMB_X1_Y21_N10
\component_7_segment|Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux5~0_combout\ = (q_int(29) & ((q_int(28) & ((q_int(31)))) # (!q_int(28) & (q_int(30))))) # (!q_int(29) & (q_int(30) & (q_int(28) $ (q_int(31)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datab => q_int(29),
	datac => q_int(30),
	datad => q_int(31),
	combout => \component_7_segment|Mux5~0_combout\);

-- Location: LCCOMB_X1_Y21_N12
\component_7_segment|Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux4~0_combout\ = (q_int(30) & (q_int(31) & ((q_int(29)) # (!q_int(28))))) # (!q_int(30) & (!q_int(28) & (q_int(29) & !q_int(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datab => q_int(29),
	datac => q_int(30),
	datad => q_int(31),
	combout => \component_7_segment|Mux4~0_combout\);

-- Location: LCCOMB_X1_Y21_N26
\component_7_segment|Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux3~0_combout\ = (q_int(29) & (q_int(28) & (q_int(30)))) # (!q_int(29) & (!q_int(31) & (q_int(28) $ (q_int(30)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datab => q_int(29),
	datac => q_int(30),
	datad => q_int(31),
	combout => \component_7_segment|Mux3~0_combout\);

-- Location: LCCOMB_X1_Y21_N20
\component_7_segment|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux2~0_combout\ = (q_int(29) & (q_int(28) & ((!q_int(31))))) # (!q_int(29) & ((q_int(30) & ((!q_int(31)))) # (!q_int(30) & (q_int(28)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001010111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datab => q_int(29),
	datac => q_int(30),
	datad => q_int(31),
	combout => \component_7_segment|Mux2~0_combout\);

-- Location: LCCOMB_X1_Y21_N18
\component_7_segment|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux1~0_combout\ = (q_int(28) & (q_int(31) $ (((q_int(29)) # (!q_int(30)))))) # (!q_int(28) & (q_int(29) & (!q_int(30))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010010010001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datab => q_int(29),
	datac => q_int(30),
	datad => q_int(31),
	combout => \component_7_segment|Mux1~0_combout\);

-- Location: LCCOMB_X1_Y21_N0
\component_7_segment|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \component_7_segment|Mux0~0_combout\ = (q_int(28) & ((q_int(31)) # (q_int(29) $ (q_int(30))))) # (!q_int(28) & ((q_int(29)) # (q_int(30) $ (q_int(31)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111101111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => q_int(28),
	datab => q_int(29),
	datac => q_int(30),
	datad => q_int(31),
	combout => \component_7_segment|Mux0~0_combout\);

-- Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(24),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(0));

-- Location: PIN_U21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(25),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(1));

-- Location: PIN_V22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(26),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(2));

-- Location: PIN_V21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(27),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(3));

-- Location: PIN_W22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(28),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(4));

-- Location: PIN_W21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(29),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(5));

-- Location: PIN_Y22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(30),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(6));

-- Location: PIN_Y21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\q[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => q_int(31),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_q(7));

-- Location: PIN_J2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(0));

-- Location: PIN_J1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux12~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(1));

-- Location: PIN_H2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux11~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(2));

-- Location: PIN_H1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux10~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(3));

-- Location: PIN_F2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux9~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(4));

-- Location: PIN_F1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux8~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(5));

-- Location: PIN_E2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|ALT_INV_Mux7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(6));

-- Location: PIN_E1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(0));

-- Location: PIN_H6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(1));

-- Location: PIN_H5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(2));

-- Location: PIN_H4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(3));

-- Location: PIN_G3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(4));

-- Location: PIN_D2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(5));

-- Location: PIN_D1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \component_7_segment|ALT_INV_Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(6));
END structure;


