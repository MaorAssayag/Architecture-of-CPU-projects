library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SReg is

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
end SReg;

architecture behavioral of SReg is

signal temp_reg: std_logic_vector(N-1 downto 0) := (Others => '0');
TYPE POSSIBLE_STATES IS (waiting, shifting);
signal state : POSSIBLE_STATES;
begin

process(clk,reset)
    variable shift_counter: integer := 0;
    variable num : integer :=0;
begin

   if(reset = '1') then
      temp_reg <= (others => '0');
      state <= waiting;
      shift_counter := 0;
   elsif(clk'event and clk='1') then
        case state is
            when waiting =>
                shift_counter := 0;
                num := to_integer(B);
                temp_reg <= parallel_in;
                s_out <= '0';
                result <= (others => '0');
                if(enable = '1') then
                    state <= shifting;
                else
                    state <= waiting;
                end if;
            when shifting =>
                shift_counter := shift_counter + 1;
                s_out <= temp_reg(0); -- shift
                temp_reg <= s_in & temp_reg(N-1 downto 1); -- shift
                result <= temp_reg;
                if (shift_counter >= num-1) then
                    state <= waiting;
                else
                    state <= shifting;
                end if;
        end case;
    end if;
end process;

end behavioral;
