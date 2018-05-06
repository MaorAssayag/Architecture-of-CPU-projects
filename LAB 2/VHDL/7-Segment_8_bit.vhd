library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity display_7_segment is port (
  	q        : in std_logic_vector (7 downto 0);
  	segment1 : out std_logic_vector (6 downto 0);
    segment2 : out std_logic_vector (6 downto 0)
    );
end display_7_segment;

architecture rtl of display_7_segment is
    -- signal segment1_int : std_logic_vector (3 downto 0):=q(7 downto 4);
    -- signal segment2_int : std_logic_vector (3 downto 0):=q(3 downto 0);
begin
  process (q(7 downto 4))
  begin
    case (q(7 downto 4)) is
      when "0000" => segment2 <= "1000000"; -- "0"
      when "0001" => segment2 <= "1111001"; -- "1"
      when "0010" => segment2 <= "0100100"; -- "2"
      when "0011" => segment2 <= "0110000"; -- "3"
      when "0100" => segment2 <= "0011001"; -- "4"
      when "0101" => segment2 <= "0010010"; -- "5"
      when "0110" => segment2 <= "0000010"; -- "6"
      when "0111" => segment2 <= "1111000"; -- "7"
      when "1000" => segment2 <= "0000000"; -- "8"
      when "1001" => segment2 <= "0010000"; -- "9"
      when "1010" => segment2 <= "0100000"; -- a
      when "1011" => segment2 <= "0000011"; -- b
      when "1100" => segment2 <= "1000110"; -- C
      when "1101" => segment2 <= "0100001"; -- d
      when "1110" => segment2 <= "0000110"; -- E
      when "1111" => segment2 <= "0001110"; -- F
      when others => segment2 <= "0000000";
      end case;
  end process;

  process (q(3 downto 0))
  begin
    case q(3 downto 0) is
      when "0000" => segment1 <= "1000000"; -- "0"
      when "0001" => segment1 <= "1111001"; -- "1"
      when "0010" => segment1 <= "0100100"; -- "2"
      when "0011" => segment1 <= "0110000"; -- "3"
      when "0100" => segment1 <= "0011001"; -- "4"
      when "0101" => segment1 <= "0010010"; -- "5"
      when "0110" => segment1 <= "0000010"; -- "6"
      when "0111" => segment1 <= "1111000"; -- "7"
      when "1000" => segment1 <= "0000000"; -- "8"
      when "1001" => segment1 <= "0010000"; -- "9"
      when "1010" => segment1 <= "0100000"; -- a
      when "1011" => segment1 <= "0000011"; -- b
      when "1100" => segment1 <= "1000110"; -- C
      when "1101" => segment1 <= "0100001"; -- d
      when "1110" => segment1 <= "0000110"; -- E
      when "1111" => segment1 <= "0001110"; -- F
      when others => segment1 <= "0000000";
      end case;
  end process;
end rtl;
