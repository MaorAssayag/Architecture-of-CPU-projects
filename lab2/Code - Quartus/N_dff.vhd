-- ====================================================================
--
--	File Name:		N_dff.vhd
--	Description:	N 1-bit dffs
--
--
--	Date:			06/05/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 -- entity Definition
entity N_dff is
    generic(N: integer := 8); --defualt value for N is 8
    port (
        clk : in std_logic;
        enable : in std_logic;
        rst : in std_logic;
        D : in signed(N-1 downto 0);
        Q : out signed(N-1 downto 0));
end N_dff;

 -- Architecture Definition
architecture strutural of N_dff is
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
N_dffs : for i in 0 to (N-1) generate
    stage_i : dff_1bit port map (clk , enable, rst, D(i), Q(i));
end generate;
----------------------------------------
end strutural;

--EndOfFile
