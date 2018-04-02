library ieee;
use ieee.numeric_std.all;
entity twoscomplement is
  generic (N : positive := 8 );
  port ( 
     A : in  signed (N-1 downto 0);
     Y : out signed   (N-1 downto 0)
  );
end entity twoscomplement;

architecture gate_level of twoscomplement is
begin
  Y <= -signed(A);
end architecture;