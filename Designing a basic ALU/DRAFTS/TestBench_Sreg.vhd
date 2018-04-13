-- ====================================================================
--
--	File Name:		Testbench_Sreg.vhd
--	Description:	test bench for Shift righ : input : N bits A, N bits B ,output : N bits S
--
--
--	Date:			02/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
--
-- ====================================================================

LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY Testbench_Sreg IS
END Testbench_Sreg;

ARCHITECTURE behavior OF Testbench_Sreg IS

 -- Component Declaration

 component SReg
 generic ( N : integer := 8);

 port( clk: in std_logic;
       reset: in std_logic;
       enable: in std_logic; --enables shifting
       B : in signed(N-1 downto 0);
       parallel_in: in std_logic_vector(N-1 downto 0);
       result : out std_logic_vector(N-1 downto 0);
       s_in: in std_logic; --serial input
       s_out: out std_logic --serial output
 );
end component;



 constant N : integer := 8;
 --Inputs
 signal A : std_logic_vector(N-1 downto 0);
 signal result : std_logic_vector(N-1 downto 0);
 signal s_out : std_logic;
 signal B : signed(N-1 downto 0) := "00000011";
 signal clk : std_logic;
begin
----------------------------------------
   -- Instantiate the Unit Under Test (UUT)
   uut: SReg PORT MAP ('1','0',clk,B, A, result,'0',s_out);

   -- Stimulus process
   stim: process
   begin
     wait for 10 ns;
     clk <= '1', '1' after 20 ns, '1' after 100 ns;
     A <= "10010000" ;
         wait for 50 ns;
  end process stim;
----------------------------------------
end behavior;
