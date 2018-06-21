-- ====================================================================
--
--	File Name:		RWA2gray.vhd
--	Description: rgb pixels to gray
--
--
--	Date:			14/06/2018
--	Designers:		Maor Assayag, Refael Shetrit , Boris Braginsky
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- entity Definition
entity RAW2gray is
port(
	oRed, oGreen, oBlue: in std_logic_vector(11 downto 0);
	gray: out std_logic_vector(11 downto 0);
  iCLK, iRST: in std_logic);
end RAW2gray;

 -- Architecture Definition
architecture behv of RAW2gray is
begin
	----------------------------------------
process(iCLK)
begin
	gray <=	conv_std_logic_vector(((CONV_INTEGER(oRed))*299/1000) +((CONV_INTEGER(oGreen))*587/1000) + ((CONV_INTEGER(oBlue))*114/1000),12);
end process;
----------------------------------------

end behv;

--EndOfFile
