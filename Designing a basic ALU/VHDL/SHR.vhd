-- ====================================================================
--
--	File Name:		SHR.vhd
--	Description:	Shift right command,  support N bit's
--
--
--	Date:			08/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.synthesize 2.png test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;

-- entity Definition
entity SHR is
    generic(N: integer := 8); --defualt value for N is 8
    port(
       A :      in signed(N-1 downto 0);
       B :      in signed(N-1 downto 0);
       result : out signed(N-1 downto 0));
end SHR;

 -- Architecture Definition
architecture gate_level of SHR is
  component SHR_ONE
    generic(N: integer := 8); --defualt value for N is 8
    port (
        A :in signed(N-1 downto 0);
        Aout : out signed(N-1 downto 0));
  end component;

  type vector_array is array (natural range <>) of signed(N-1 downto 0);
  signal v_normal_in_sig : vector_array(31 downto 0); -- max(N) = 32 bits
  signal num : integer := 1; -- default value, avoid warnings

  begin
-------------------------------------------
  v_normal_in_sig(0) <= A;

  shift_loop: for i in 0 to N-1 generate
      stage_i :SHR_ONE port map(v_normal_in_sig(i), v_normal_in_sig(i+1));
  end generate;

  process
    variable tmp : integer;
    begin
      wait on B;
      tmp:=to_integer(B);
      num <= tmp;
      wait on v_normal_in_sig(N-1);
      if (num > N-1) then
         result <= v_normal_in_sig(N-1); -- after N shifts the result is the same
      else
         result <= v_normal_in_sig(num);
     end if;
  end process;
----------------------------------------
end gate_level;

--EndOfFile
