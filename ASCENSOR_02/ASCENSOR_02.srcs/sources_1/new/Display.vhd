library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display is
    port
    (
        clock             : in  std_logic;                          -- Reloj
        Display_P_A       : in  std_logic_vector (6 downto 0);      -- Display P_A
        Display_P_D       : in  std_logic_vector (6 downto 0);      -- Display P_D
        display_selection : out std_logic_vector (7 downto 0);      -- Seleccion de display
        display_number    : out std_logic_vector (6 downto 0)       -- Numero display
    );
end entity Display;

architecture Behavioral of Display is
begin
    process (clock)
        variable contador : integer range 0 to 1 := 0;      -- Variable contador que admite el valor 0 o 1
    begin
        if rising_edge (clock) then     -- Si hay un flanco ascendente de reloj (Síncrono) 
            if contador = 1 then        -- Si contador = 1 -> contador = 0
                contador := 0;
            else
                contador := contador + 1;   -- Si contador = 0 -> contador = 1
            end if;
        end if;

        case contador is
            when 0 => display_selection <= "11111101";  -- Si contador = 0 -> se cambia el numero del display ?
                display_number <= Display_P_D;
            when 1 => display_selection <= "11111110";  -- Si contador = 1 -> se cambia el numero del display ?
                display_number <= Display_P_A;
        end case;
    end process;
end architecture Behavioral;