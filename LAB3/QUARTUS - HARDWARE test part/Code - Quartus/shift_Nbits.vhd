-- ====================================================================
--
--	File Name:		shift_Nbits.vhd
--	Description:	shift N bits vector 1 bit to the right/left
--                dir = '0' -> left, '1' -> right
--
--
--	Date:			08/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity shift_Nbits is
  generic(N: integer := 8); --defualt value for N is 8
  port (
    dir :    in std_logic;
    enable : in std_logic;
    A :      in signed(N-1 downto 0);
    Aout :   out signed(N-1 downto 0));
end shift_Nbits;

 -- Architecture Definition
architecture behavioral of shift_Nbits is
begin
  process (dir,enable, A)
  begin

     -- dir = left -> Aout(0)='0'
    Aout(0) <= (((enable and dir)) and A(1)) OR ((not enable) and A(0));

    loopforshift : for i in 1 to N-2 loop
        Aout(i) <= ( enable and ((dir and A(i+1)) OR ((not dir) and A(i-1))) ) OR ((not enable) and A(i));
    end loop;

    -- signed number, therefore dir = right -> Aout(N-1) = Aout(N-1) to keep the MSB
    Aout(N-1) <= A(N-1);

   end process;
end behavioral;

--EndOfFile
