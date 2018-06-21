-- ====================================================================
--
--	File Name:		TestBench_MAC.vhd
--	Description: test bench for MAC opp
--
--
--	Date:			12/04/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Testbench_MAC is
end Testbench_MAC;

architecture behavior of Testbench_MAC is

 -- Component Declaration
 component MAC
    generic (N: integer := 8 ); --defualt value for N is 8
    port(
           mac_rst : in std_logic;
       clk :     in std_logic;
       enable :  in std_logic;
       LO_bits : in signed(N-1 downto 0);
       HI_bits : in signed(N-1 downto 0);
       MAC_result :  out signed(2*N-1 downto 0));
  end component;

 constant N : integer := 8;
 signal LO_bits,HI_bits: signed((N-1) downto 0) := "00000000" ;
 signal MAC_result : signed((2*N-1) downto 0) ;
 signal rst,clk : std_logic := '0';
 signal enable : std_logic := '1';
begin
----------------------------------------
  uut :  MAC  generic map(N)
    port map (rst,clk,enable,LO_bits,HI_bits,MAC_result);
      
  -- Stimulus process
   stim: process
   begin
   -- hold reset state for 10 ns.
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   LO_bits <= "00000000";
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   LO_bits  <= "00000011";
   HI_bits  <= "00000011";
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   LO_bits  <= "00000011";
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   LO_bits  <= "00001100";
   wait for 10 ns;

   clk <= '1';
   rst <= '0';
   LO_bits <= "00110000";
   wait for 10 ns;

   clk <= '0';
   rst <= '0';
   LO_bits <= "00110000";
   wait for 10 ns;

   clk <= '1';
   rst <= '1';
   LO_bits  <= "00110000";
   HI_bits  <= "00011000";
   wait for 10 ns;

  end process stim;
----------------------------------------
end behavior;

--EndOfFile
