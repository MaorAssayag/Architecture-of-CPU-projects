
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity Histogram is
port(
	iX_Cont,	iY_Cont	   : in  std_logic_vector(15 downto 0);--cordinate
	Red_in					: in  std_logic_vector(11 downto 0);--redData_in
	Red_out					: out std_logic_vector(11 downto 0);--redData_out
	Blue_in					: in  std_logic_vector(11 downto 0);--blueData_in
	Blue_out					: out std_logic_vector(11 downto 0);--blueData_out
	Green_in				   : in  std_logic_vector(11 downto 0);--greenData_in
	Green_out				: out std_logic_vector(11 downto 0);--greenData_out
	oDVAL					: out std_LOGIC;
	iDVAL, iCLK, iRST	: in  std_logic);
end Histogram;
