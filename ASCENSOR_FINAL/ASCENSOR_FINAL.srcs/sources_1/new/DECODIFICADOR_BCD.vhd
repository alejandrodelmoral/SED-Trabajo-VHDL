library ieee;
use ieee.std_logic_1164.all;

entity DECODIFICADOR_BCD is
    port
    (
        CODIGO  : in  std_logic_vector (1 downto 0);    -- Codigo (Planta)
        LED     : out std_logic_vector (6 downto 0);    -- Imprime numero
        DISPLAY : out std_logic_vector (7 downto 0)     -- Muestra por pantalla
    );
end entity;

architecture behavioral of DECODIFICADOR_BCD is
begin
    process(CODIGO)
    begin
        case CODIGO is
            when "00"   => 
                LED     <= "0000001";       -- Display 7 segmentos (Muestra el numero 0)
                DISPLAY <= "11111110";      -- En el 1er Digito
            when "01"   => 
                LED     <= "1001111";       -- Display 7 segmentos (Muestra el numero 1)
                DISPLAY <= "11111101";      -- En el 2o Digito
            when "10"   =>
                LED     <= "0010010";       -- Display 7 segmentos (Muestra el numero 2)
                DISPLAY <= "11111011";      -- En el 3er Digito
            when "11"   =>
                LED     <= "0000110";       -- Display 7 segmentos (Muestra el numero 3)
                DISPLAY <= "11110111";      -- En el 4o Digito
            when others =>
                LED     <= "1001111";       -- Display 7 segmentos (Muestra la letra E (ERROR))
                DISPLAY <= "11110000";      -- En todos los digitos
        end case;
    end process;
end architecture behavioral;