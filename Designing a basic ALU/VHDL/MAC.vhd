-- ====================================================================
--
--	File Name:		MAC.vhd
--	Description:	MAC command
--
--
--	Date:			10/04/2018
--	Designer:		Maor Assayag, Refael Shetrit
--
-- TODO : check test bench
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


 -- entity Definition
entity MAC is
    generic(N: integer := 8); --defualt value for N is 8
    Port(
       A :     in signed((N-1) downto 0);
       B :     in signed((N-1) downto 0);
       MACHI :   in signed((N-1) downto 0);
       MACLO : in signed((N-1) downto 0);
       HI :   out signed((N-1) downto 0);
       LO : out signed((N-1) downto 0)
    );
end MAC;

 -- Architecture Definition
architecture gate_level of MAC is
  component ADD_SUB
     generic (N: integer := 8 ); --defualt value for N is 8
     port(
       addORsub :   in std_logic;
       FLAG : inout std_logic_vector(5 downto 0);
       A :     in signed ((N-1) downto 0);
       B :     in signed ((N-1) downto 0);
       SUM :   out signed ((N-1) downto 0)
      );
   end component;
  component MUL
     generic (N: integer := 8 ); --defualt value for N is 8
     port(
         A :     in signed((N-1) downto 0);
         B :     in signed((N-1) downto 0);
         HI :   out signed((N-1) downto 0);
         LO : out signed((N-1) downto 0)
      );
   end component;

    signal MULHI,MULLO : signed((N-1) downto 0) ;
    signal MULT,MAC,SUM: signed((2*N-1) downto 0) ;
    signal FLAGs: std_logic_vector (5 downto 0) := "000000";
begin
  ----------------------------------------
  MULFUN :  MUL  generic map(N)
    port map (A,B,MULT (2*N-1 downto N),MULT (N-1 downto 0));
  -- MULT (2*N-1 downto N) <= MULHI;
  -- MULT (N-1 downto 0) <= MULLO;
MAC_proc : process
begin
  wait on MACHI;
  wait on MACLO;
  MAC (2*N-1 downto N) <= MACHI;
  MAC (N-1 downto 0) <= MACLO;
end process;

  ADDFUN :  ADD_SUB  generic map(2*N)
    port map ('0', FLAGs, MULT,MAC,SUM);
MAC_proc2 : process(MAC,SUM)
begin
  HI <= SUM(2*N-1 downto N);
  LO <= SUM(N-1 downto 0);
end process;

  -- MAC_proc : process(A,B,MACHI,MACLO)
  -- variable  MAC : signed (2*N - 1 downto 0);
  -- variable  SUM : signed (2*N - 1 downto 0);
  -- begin
  --   MAC (2*N-1 downto N) <= MACHI;
  --   MAC (N-1 downto 0) <= MACLO;
  --
  --   -- tmp := A*B;
  --   -- HI <= tmp (2*N-1 downto N);
  --   -- LO <= tmp (N-1 downto 0);
  --   -- res <= tmp;
--   end process;
-- ----------------------------------------
end gate_level;

--EndOfFile
