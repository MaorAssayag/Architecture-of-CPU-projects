-- ====================================================================
--
--	File Name:		reg_8bit.vhd
--	Description:	8 bit register
--
--
--	Date:			12/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity reg_8bit is
    port (
        clk : in std_logic;
        rst : in std_logic;
        en  : in std_logic;
        d : in signed(7 DOWNTO 0) ;
        q : out signed(7 DOWNTO 0));
end reg_8bit;

 -- Architecture Definition
architecture behavioral of reg_8bit is
  component dff_1bit
  port (
      clk : in std_logic;
      en : in std_logic;
      rst : in std_logic;
      d : in std_logic;
      q : out std_logic);
 end component;

begin
----------------------------------------
    uut1: dff_1bit port map (clk,en, rst, d(0), q(0));
    uut2: dff_1bit port map (clk,en, rst, d(1), q(1));
    uut3: dff_1bit port map (clk,en, rst, d(2), q(2));
    uut4: dff_1bit port map (clk,en, rst, d(3), q(3));
    uut5: dff_1bit port map (clk,en, rst, d(4), q(4));
    uut6: dff_1bit port map (clk,en, rst, d(5), q(5));
    uut7: dff_1bit port map (clk,en, rst, d(6), q(6));
    uut8: dff_1bit port map (clk,en, rst, d(7), q(7));

----------------------------------------
end behavioral;

--EndOfFile
