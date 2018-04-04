-- ====================================================================
--
--	File Name:		Testbench_MUX_AddOrSub.vhd
--	Description: test bench for MUX_AddOrSub opp
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : 1.check in MODELSIM
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_MUX_AddOrSub is
end Testbench_MUX_AddOrSub;

architecture behavior of Testbench_MUX_AddOrSub is

 -- Component Declaration
 component MUX_addORsub
   generic(N: positive := 8); --defualt value for N is 8
   Port (
          SEL: in  std_logic;
          Y1 : in  signed (N-1 downto 0);
          Y2 : in  signed (N-1 downto 0);
          Y  : out signed (N-1 downto 0)
   );
  end component;

 constant N : integer := 8;
 signal OPP : std_logic;
 signal x, y, result : signed((N-1) downto 0) ;

begin
----------------------------------------
  uut :  MUX_addORsub  generic map(N)
    port map (SEL => OPP,Y1 => x,Y2 => y,Y => result);

  stim: process
  begin
    wait for 100 ns;
    x <= "00000000", "00000001" after 50 ns, "00001100" after 100 ns,"00001111" after 150 ns;
    y <= "00000010", "00000011" after 50 ns, "00000010" after 100 ns,"00010000" after 150 ns;
    OPP <= '0', '0' after 50 ns, '1' after 100 ns, '1' after 150 ns;
    wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;

--EndOfFile
