
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity Histogram is
port(
	gray_in					: in  std_logic_vector(11 downto 0);
	x_in,	y_in	   : in  std_logic_vector(15 downto 0);
  Red_out					: out std_logic_vector(11 downto 0);
  Blue_out					: out std_logic_vector(11 downto 0);
  Green_out				: out std_logic_vector(11 downto 0);
	iDVAL, iCLK, iRST	: in  std_logic);
end Histogram;

architecture rtl of Histogram is
	TYPE 	 pixarray IS ARRAY ( 0 TO 15 ) OF unsigned  (20 downto 0);
	SIGNAL his_in						        : pixarray;
	SIGNAL his_out						       : pixarray;


BEGIN
--
-- PROCESS (iCLK, iRST)
--
-- 	variable y_int 			: integer;
-- 	variable x_int 			: integer;
-- 	variable y_down 			: integer;
-- 	variable gray_val		: integer;
--   constant Column 			: integer := 15;
-- 	constant x_size 		: integer := 80;
-- BEGIN
-- 
-- 	if (rising_edge(iCLK)) then
-- 					y_int := CONV_INTEGER(unsigned(y_in));
-- 					x_int := CONV_INTEGER(unsigned(x_in));
--
-- 					if((iRST = '0')) then
--
-- 									FOR i IN 0 TO Column LOOP
-- 										his_in   (i)	<=  (others => '0');
-- 										his_out  (i)	<=  (others => '0');
-- 									END LOOP;
--
-- 									Red_out	 <= (others => '1');
-- 									Blue_out  <= (others => '1');
-- 									Green_out <= (others => '1');
-- 					elsif (iDVAL = '1') then
-- 									gray_val 	:= CONV_INTEGER(unsigned(gray_in));
-- 									FOR i IN 0 TO Column LOOP
-- 										if ((gray_val >= i*256 ) AND (gray_val<(i+1)*256 )) then
-- 											his_in(i) <= his_in(i)+ 1;
-- 										end if;
-- 									END LOOP;
-- 								if ((y_int = 0) AND (x_int = 0)) then
-- 										FOR i IN 0 TO Column LOOP
-- 											his_out(i) 	<= his_in(i);
-- 											his_in(i) 	<= (others => '0');
-- 										END LOOP;
-- 								end if;
--
-- 							FOR i IN 0 TO Column LOOP
-- 											if (x_int >= (x_size*i) AND  x_int < (x_size*(i+1))) then
-- 												   y_down := 960-y_int;
-- 													 if ((y_down * 319) < his_out(i)) then ----------------- size 640*480
-- 												 			Blue_out 	<= (others => '1');
-- 															Green_out 	<= (others => '1');
-- 															Red_out     <= (others => '1');
-- 												    else
-- 															Blue_out 	<= (others => '0');
-- 															Green_out	<= (others => '0');
-- 															Red_out     <= (others => '0');
-- 											end if;
-- 											end if;
--
--
-- 								END LOOP;
-- 	end if;
-- end if;
--
--
-- END PROCESS;

END rtl;
