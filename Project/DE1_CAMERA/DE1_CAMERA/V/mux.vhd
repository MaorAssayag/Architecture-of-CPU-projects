--25.5.14
--Boris Braginsky
--==========Library===========
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;
use ieee.std_logic_arith.all;


entity mux is
port(
	oRed, oGreen, oBlue: in std_logic_vector(11 downto 0);
	gray: in std_logic_vector(11 downto 0);
	out_R: out std_logic_vector(11 downto 0);
	out_G: out std_logic_vector(11 downto 0);
	out_B: out std_logic_vector(11 downto 0);
	his_R: in std_logic_vector(11 downto 0);
	his_G: in std_logic_vector(11 downto 0);
	his_B: in std_logic_vector(11 downto 0);
	iSobel: in std_logic_vector(11 downto 0);
	switch1,switch2,switch3,switch4,iDVAL, iCLK, iRST: in std_logic);
end mux;


architecture behv of mux is


begin


process(iCLK, iRST)
begin
	if(iRST = '0') then
		out_R	<=	"000000000000";
		out_G	<=	"000000000000";
		out_B	<=	"000000000000";
	else
		if (switch1 = '1' ) then ------ color
			out_R <= oRed;
			out_G <= oGreen;
			out_B <= oBlue;
		elsif (switch2 ='1' ) then  -------- gray
			out_R <= gray;
			out_G <= gray;
			out_B <= gray;
		elsif (switch3 ='1' ) then   ------Histogram
			out_R <= his_R;
			out_G <= his_G;
			out_B <= his_B;
		elsif (switch4 ='1' ) then
			out_R <= iSobel;
			out_G <= iSobel;
			out_B <= iSobel;
		else
			out_R <= (others => '1');
			out_G <= (others => '1');
			out_B <= (others => '1');
		end if;
	end if;
end process;

end behv;
