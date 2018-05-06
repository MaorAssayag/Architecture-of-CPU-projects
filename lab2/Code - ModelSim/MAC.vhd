-- ====================================================================
--
--	File Name:		MAC.vhd
--	Description:	MAC command
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
entity MAC is
    generic(N: integer := 8); --defualt value for N is 8
    port(
       mac_rst : in std_logic;
       clk :     in std_logic;
       enable :  in std_logic;
       LO_bits : in signed(N-1 downto 0);
       HI_bits : in signed(N-1 downto 0);
       MAC_result :  out signed(2*N-1 downto 0));
end MAC;

 -- Architecture Definition
architecture behavioral of MAC is
component N_dff
    generic(N: integer := 8); --defualt value for N is 8
    port (
        clk : in std_logic;
        enable : in std_logic;
        rst : in std_logic;
        D : in signed(N-1 downto 0);
        Q : out signed(N-1 downto 0));
end component;

signal MAC_LO, MAC_HI : signed(N-1 downto 0) := (others => '0');
begin
----------------------------------------
LO_dff : N_dff generic map(N) port map(clk, enable, mac_rst, LO_bits, MAC_LO);
HI_dff : N_dff generic map(N) port map(clk, enable, mac_rst, HI_bits, MAC_HI);

MAC_result(N-1 downto 0) <= MAC_LO;
MAC_result(2*N-1 downto N) <= MAC_HI;
----------------------------------------
end behavioral;

--EndOfFile
