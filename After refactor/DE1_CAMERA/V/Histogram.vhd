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
use IEEE.std_logic_signed.all;
use ieee.std_logic_arith.all;

 -- entity Definition
entity Histogram is
port(
	gray_in					: in  std_logic_vector(11 downto 0);
	x_in,	y_in	   : in  std_logic_vector(15 downto 0);
  Red_out					: out std_logic_vector(11 downto 0);
  Blue_out					: out std_logic_vector(11 downto 0);
  Green_out				: out std_logic_vector(11 downto 0);
	iDVAL, iCLK, iRST	: in  std_logic);
end Histogram;

 -- Architecture Definition
architecture rtl of Histogram is
	TYPE 	 pixelArray IS ARRAY ( 0 TO 15 ) OF unsigned  (20 downto 0);
	signal histogram_in			: pixelArray;
	signal histogram_out		: pixelArray;


begin
----------------------------------------
		process (iCLK, iRST)
			variable y_int 			: integer;
			variable x_int 			: integer;
			variable y_down 			: integer;
			variable gray_val		: integer;
		  constant Column 			: integer := 15;
			constant x_size 		: integer := 80;

		begin
			if (rising_edge(iCLK)) then
							y_int := CONV_INTEGER(unsigned(y_in));
							x_int := CONV_INTEGER(unsigned(x_in));

							if((iRST = '0')) then
											for i in 0 to Column loop
													histogram_in   (i)	<=  (others => '0');
													histogram_out  (i)	<=  (others => '0');
											end loop;
											Red_out	 <= (others => '1');
											Blue_out  <= (others => '1');
											Green_out <= (others => '1');

							elsif (iDVAL = '1') then
										gray_val 	:= CONV_INTEGER(unsigned(gray_in));
										for i in 0 to Column loop
												if ((gray_val >= i*256 ) AND (gray_val<(i+1)*256 )) then
													histogram_in(i) <= histogram_in(i)+ 1;
												end if;
										end loop;
										if ((y_int = 0) AND (x_int = 0)) then
												FOR i IN 0 TO Column LOOP
													histogram_out(i) 	<= histogram_in(i);
													histogram_in(i) 	<= (others => '0');
												end loop;
										end if;

										for i in 0 to Column loop
												if (x_int >= (x_size*i) AND  x_int < (x_size*(i+1))) then
													 y_down := 960-y_int;
													 if ((y_down * 319) < histogram_out(i)) then ----------------- size 640*480
												 			Blue_out 	<= (others => '1');
															Green_out <= (others => '1');
															Red_out   <= (others => '1');
												   else
															Blue_out 	<= (others => '0');
															Green_out	<= (others => '0');
															Red_out   <= (others => '0');
													end if;
												end if;
									 end loop;
						end if;
			end if;

		END PROCESS;
----------------------------------------
END rtl;

-- EndOfFile
