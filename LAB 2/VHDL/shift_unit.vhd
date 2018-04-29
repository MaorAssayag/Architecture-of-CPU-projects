-- ====================================================================
--
--	File Name:		shift_unit.vhd
--	Description:	Shift right or left command,  support N bit's
--  B is 5 bit number that represent the number of shifts on A. for each bit
-- we connect 2^B(i) shift entities with enable = B(i), therefore in the end
-- the result will be shifted exactly B times.
--dir = '0' -> left, '1' -> right
--
--	Date:			08/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.synthesize 2.png test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

-- entity Definition
entity shift_unit is
    generic(N: integer := 8); --defualt value for N is 8
    port(
       dir :    in std_logic;
       A :      in signed(N-1 downto 0);
       B :      in signed(5 downto 0);
       result : out signed(N-1 downto 0));
end shift_unit;

 -- Architecture Definition
architecture structural of shift_unit is
  component shift_Nbits
    generic(N: integer := 8); --defualt value for N is 8
    port (
      dir :    in std_logic;
      enable : in std_logic;
      A :      in signed(N-1 downto 0);
      Aout :   out signed(N-1 downto 0));
  end component;

  type vector_array is array (natural range <>) of signed(N-1 downto 0);
  signal v_signal_31 : vector_array(32 downto 0);
  signal v_signal_15 : vector_array(16 downto 0);
  signal v_signal_7 : vector_array(8 downto 0);
  signal v_signal_3 : vector_array(4 downto 0);
  signal v_signal_1 : vector_array(2 downto 0);

  begin
-------------------------------------------
  shift_loop_bit0 : shift_Nbits generic map(N) port map(dir, B(0), A, v_signal_1(0));

  shift_loop_bit1: for i in 0 to 1 generate
      stage_i :shift_Nbits generic map(N) port map(dir, B(1), v_signal_1(i), v_signal_1(i+1));
  end generate;

  v_signal_3(0) <= v_signal_1(2);

  shift_loop_bit2: for i in 0 to 3 generate
      stage_i :shift_Nbits generic map(N) port map(dir, B(2), v_signal_3(i), v_signal_3(i+1));
  end generate;

  v_signal_7(0) <= v_signal_3(4);

  shift_loop_bit3: for i in 0 to 7 generate
      stage_i :shift_Nbits generic map(N) port map(dir, B(3), v_signal_7(i), v_signal_7(i+1));
  end generate;

  v_signal_15(0) <= v_signal_7(8);

  shift_loop_bit4: for i in 0 to 15 generate
      stage_i :shift_Nbits generic map(N) port map(dir, B(4), v_signal_15(i), v_signal_15(i+1));
  end generate;

  v_signal_31(0) <= v_signal_15(16);

  shift_loop_bit5: for i in 0 to 31 generate
      stage_i :shift_Nbits generic map(N) port map(dir, B(5), v_signal_31(i), v_signal_31(i+1));
  end generate;

  result <= v_signal_31(32);
----------------------------------------
end structural;

--EndOfFile
