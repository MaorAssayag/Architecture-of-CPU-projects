
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RAW2gray is
port(
	oRed, oGreen, oBlue: in std_logic_vector(11 downto 0);
	gray: out std_logic_vector(11 downto 0);
  iCLK, iRST: in std_logic);
end RAW2gray;


architecture behv of RAW2gray is



begin
process(iCLK, iRST)


begin

	gray <=	std_logic_vector((shift_right(unsigned(oRed),2))+(shift_right(unsigned(oRed),5))+(shift_right(unsigned(oGreen),1))+(shift_right(unsigned(oGreen),4))+(shift_right(unsigned(oBlue),4))+(shift_right(unsigned(oBlue),5)));
end process;

end behv;
