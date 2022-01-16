library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display is
    port
    (
        clock               : in  std_logic ;
        planta_actual_last  : in  std_logic_vector (6 downto 0);
        planta_destino_last : in  std_logic_vector (6 downto 0);
        display_selection   : out std_logic_vector (7 downto 0);
        display_number      : out std_logic_vector (6 downto 0)
    );
end Display;

architecture Behavioral of Display is
begin
    process (clock)
        variable contador : integer range 0 to 1 := 0;
    begin
        if rising_edge (clock) then
            if contador = 1 then
                contador := 0;
            else
                contador := contador + 1;
            end if;
        end if;

        case contador is
            when 0 => display_selection <= "11111101";
                display_number <= planta_destino_last;

            when 1 => display_selection <= "11111110";
                display_number <= planta_actual_last;
        end case;
    end process;
end Behavioral;
