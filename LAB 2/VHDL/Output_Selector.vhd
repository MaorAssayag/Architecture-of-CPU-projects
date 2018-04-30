-- ====================================================================
--
--	File Name:		Output_Selector.vhd
--	Description:	if SEL ='0' = arithmetic : then output the arithmetic_HI, arithmetic_LO
--                if FLAG_en = '1' then the opp was SUB, therfore we need to output the FLAGS
--                if SEL = '1' then the OPP was for the shift unit, output LO = shift_LO, HO=zeroes
--                this entity will be called from the TOP design of the ALU as the last stop of the data.
--
--                N=8 duo to FPGA
--
--
--	Date:			30/04/2018
--	Designer's:  Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity Output_Selector is
    generic(N: positive := 8); --defualt value for N is 8
    port (
       SEL:             in  std_logic;
       FPU_SEL :        in  std_logic; -- SHIFT UNIT or FPU UNIT
       FPU_SW :         in  std_logic; -- FPU MSB bits or LSB bits
       FLAG_en :        in  std_logic;
       arithmetic_LO:   in  signed (N-1 downto 0);
       arithmetic_HI:   in  signed (N-1 downto 0);
       arithmetic_FLAG: in  signed (5 downto 0);
       shift_LO :       in  signed (N-1 downto 0);
       FPU_result :     in  signed (31 downto 0);
       LO :             out signed (N-1 downto 0);
       HI :             out signed (N-1 downto 0);
       STATUS :         out signed (5 downto 0));
end Output_Selector;

 -- Architecture Definition
architecture structural of Output_Selector is

component MUX_Nbits
    generic(N: positive := 8); --defualt value for N is 8
    port (
       SEL: in  std_logic;
       Y1 : in  signed (N-1 downto 0);
       Y2 : in  signed (N-1 downto 0);
       Y  : out signed (N-1 downto 0));
end component;

signal zeroes : signed(N-1 downto 0) := (others => '0');
signal LO_temp : signed(N-1 downto 0) := (others => '0');
signal HI_temp : signed(N-1 downto 0) := (others => '0');
signal FPU_LO : signed(N-1 downto 0) := (others => '0');
signal FPU_HI : signed(N-1 downto 0) := (others => '0');
begin
----------------------------------------
MUX_FPU_LO_prepare : MUX_Nbits  port map (FPU_SW, FPU_result(7 downto 0), FPU_result(23 downto 16), FPU_LO(7 downto 0));
MUX_FPU_HI_prepare : MUX_Nbits  port map (FPU_SW, FPU_result(15 downto 8), FPU_result(31 downto 24), FPU_HI(7 downto 0));

MUX_LO_prepare : MUX_Nbits generic map (N) port map (FPU_SEL, shift_LO, FPU_LO, LO_temp);
MUX_HI_prepare : MUX_Nbits generic map (N) port map (FPU_SEL, zeroes, FPU_HI, HI_temp);

MUX_LO : MUX_Nbits generic map (N) port map (SEL, arithmetic_LO, LO_temp, LO);
MUX_HI : MUX_Nbits generic map (N) port map (SEL, arithmetic_HI, HI_temp, HI);
MUX_FLAG : MUX_Nbits generic map (6) port map (FLAG_en, zeroes(5 downto 0), arithmetic_FLAG, STATUS);
----------------------------------------
end structural;

--EndOfFile
