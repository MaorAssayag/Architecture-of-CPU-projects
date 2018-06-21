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
	iX_Cont,	iY_Cont: in std_logic_vector(10 downto 0);
	his_R: in std_logic_vector(11 downto 0);
	his_G: in std_logic_vector(11 downto 0);
	his_B: in std_logic_vector(11 downto 0);
	ifilter: in std_logic_vector(11 downto 0);
	switch : in std_logic_vector(1 downto 0);
	mips_int : out std_logic;
	iDVAL, iCLK, iRST: in std_logic);
end mux;


architecture behv of mux is


begin


process(iCLK, iRST,switch)
begin
	if((iX_Cont = 0) and (iY_Cont = 0)) then
		mips_int <='1' ;
	else
		mips_int <='0' ;
	end if;
	if(iRST = '0') then
		out_R	<=	"000000000000";
		out_G	<=	"000000000000";
		out_B	<=	"000000000000";
	else
		if (switch = "00" ) then ------ color
			out_R <= oRed;
			out_G <= oGreen;
			out_B <= oBlue;
		elsif (switch ="01" ) then  -------- gray
			out_R <= gray;
			out_G <= gray;
			out_B <= gray;
		elsif (switch ="10" ) then   ------Histogram
			out_R <= his_R;
			out_G <= his_G;
			out_B <= his_B;
		elsif (switch ="11" ) then------filter
			out_R <= ifilter;
			out_G <= ifilter;
			out_B <= ifilter;
		else
			out_R <= (others => '0');
			out_G <= (others => '0');
			out_B <= (others => '0');
		end if;
	end if;
end process;

end behv;
