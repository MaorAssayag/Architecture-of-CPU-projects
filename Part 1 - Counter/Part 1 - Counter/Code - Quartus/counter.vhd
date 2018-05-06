library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity counter is port (
	clk,enable : in std_logic;
	q          : out std_logic_vector (7 downto 0);
  HEX0,HEX1 : out std_logic_vector (6 downto 0));
end counter;

architecture rtl of counter is
  -- Component Declaration
  component display_7_segment
     port(
       q                 : in std_logic_vector (7 downto 0);
     	segment1,segment2 : out std_logic_vector (6 downto 0)
      );
   end component;



    signal q_int : std_logic_vector (31 downto 0):=x"00000000";



begin

    process (clk)
    begin
        if (rising_edge(clk)) then
           if enable = '1' then
		        q_int <= q_int + 1;
           end if;
	     end if;
    end process;
    q <= q_int(31 downto 24); -- Output only 8MSB

      component_7_segment :  display_7_segment  port map (q_int(31 downto 24),HEX0,HEX1);



    --
    -- process (q_int(31 downto 28))
    -- begin
    --   case (q_int(31 downto 28)) is
    --     when "0000" => HEX1 <= "1000000"; -- "0"
    --     when "0001" => HEX1 <= "1111001"; -- "1"
    --     when "0010" => HEX1 <= "0100100"; -- "2"
    --     when "0011" => HEX1 <= "0110000"; -- "3"
    --     when "0100" => HEX1 <= "0011001"; -- "4"
    --     when "0101" => HEX1 <= "0010010"; -- "5"
    --     when "0110" => HEX1 <= "0000010"; -- "6"
    --     when "0111" => HEX1 <= "1111000"; -- "7"
    --     when "1000" => HEX1 <= "0000000"; -- "8"
    --     when "1001" => HEX1 <= "0010000"; -- "9"
    --     when "1010" => HEX1 <= "0100000"; -- a
    --     when "1011" => HEX1 <= "0000011"; -- b
    --     when "1100" => HEX1 <= "1000110"; -- C
    --     when "1101" => HEX1 <= "0100001"; -- d
    --     when "1110" => HEX1 <= "0000110"; -- E
    --     when "1111" => HEX1 <= "0001110"; -- F
    --     when others => HEX1 <= "0000000";
    --     end case;
    -- end process;
    --
    -- process (q_int(27 downto 24))
    -- begin
    --   case q_int(27 downto 24) is
    --     when "0000" => HEX0 <= "1000000"; -- "0"
    --     when "0001" => HEX0 <= "1111001"; -- "1"
    --     when "0010" => HEX0 <= "0100100"; -- "2"
    --     when "0011" => HEX0 <= "0110000"; -- "3"
    --     when "0100" => HEX0 <= "0011001"; -- "4"
    --     when "0101" => HEX0 <= "0010010"; -- "5"
    --     when "0110" => HEX0 <= "0000010"; -- "6"
    --     when "0111" => HEX0 <= "1111000"; -- "7"
    --     when "1000" => HEX0 <= "0000000"; -- "8"
    --     when "1001" => HEX0 <= "0010000"; -- "9"
    --     when "1010" => HEX0 <= "0100000"; -- a
    --     when "1011" => HEX0 <= "0000011"; -- b
    --     when "1100" => HEX0 <= "1000110"; -- C
    --     when "1101" => HEX0 <= "0100001"; -- d
    --     when "1110" => HEX0 <= "0000110"; -- E
    --     when "1111" => HEX0 <= "0001110"; -- F
    --     when others => HEX0 <= "0000000";
    --     end case;
    -- end process;

end rtl;
