library ieee;
use ieee.std_logic_1164.all;

entity FSM_MASTER is
    port
    (
        CLK         : in  std_logic;                            -- Reloj
        RESET       : in  std_logic;                            -- Reset
        DESTINO     : in  std_logic_vector (1 downto 0);        -- Planta destino
        DESTINO_OUT : out std_logic_vector (1 downto 0);        -- Planta destino salida
        PUERTA      : out std_logic_vector (1 downto 0);        -- Estado de la puerta, abierta (01) o cerrada (10)
        MOTOR       : out std_logic_vector (1 downto 0);        -- Estado del motor, en marcha (01 (subiendo) | 10 (bajando)) o parado (00)
        FLAG_MOTOR  : out std_logic                             -- Flag del motor, marca el comienzo y final del ascensor
    );
end entity;

architecture behavioral of FSM_MASTER is
    type STATE_type is (S0, S1, S2, S3);                        -- Estados
    signal STATE: state_type;                                   -- Estado actual
    signal SIGUIENTE_STATE : state_type;                        -- Estado siguiente
    signal PISO_TEMP : std_logic_vector (1 downto 0);           -- Salida de planta
    
begin

    SYNC_PROC: process (CLK, RESET)
    begin
        if (RESET = '0') then               -- Reset con prioridad
                STATE <= S0;                -- Estado inicial
        elsif rising_edge(CLK) then         -- En los flancos de reloj
            STATE <= SIGUIENTE_STATE;       -- Cambia de estado
        end if;
    end process;
    
    OUTPUT_DECODE: process (STATE)
    begin
        case STATE is                     -- Cambia de destino en funcion del estado, que es igual que la planta
            when S0 =>
                DESTINO_OUT <= "00";
            when S1 =>
                DESTINO_OUT <= "01";
            when S2 =>
                DESTINO_OUT <= "10";
            when S3 =>
                DESTINO_OUT <= "11";
            when others =>
                DESTINO_OUT <= "00";
        end case;
    end process;
    
    NEXT_STATE_DECODE: process (STATE, DESTINO)
    begin
        SIGUIENTE_STATE <= S0;
        case (STATE) is
                      when S0 =>                                  -- En el estado 0
                if DESTINO = "00" then                  -- Si el destino es planta 0
                    SIGUIENTE_STATE <= S0;              -- Cambia a estado 0
                    MOTOR           <= "00";            -- Para motor
                    FLAG_MOTOR      <= '0';             -- Final de movimiento de ascensor
                    PUERTA          <= "10";            -- Abre puerta
                elsif DESTINO /= "00" then              -- Si el destino no es planta 0
                    SIGUIENTE_STATE <= S1;              -- Cambia de estado al siguiente
                    MOTOR           <= "01";            -- Motor en marcha (subiendo)
                    FLAG_MOTOR      <= '1';             -- Inicio movimiento de ascensor
                    PISO_TEMP       <= DESTINO;         -- Cambia de piso al siguiente
                    PUERTA          <= "01";            -- Cierra puerta
                end if;
            when S1 =>                                                  -- En el estado 1
                if PISO_TEMP /= "01" then                               -- Si la planta no es la 1
                    if PISO_TEMP = "10" or PISO_TEMP = "11" then        -- Si la planta es la 2 o la 3
                        SIGUIENTE_STATE <= S2;                          -- Cambia a estado 2
                        MOTOR           <= "01";                        -- Motor en marcha (subiendo)
                    elsif PISO_TEMP = "00" then                         -- Si la planta es la 0
                        SIGUIENTE_STATE <= S0;                          -- Cambia a estado 0
                        MOTOR           <= "10";                        -- Motor en marcha (bajando)
                    end if;
                    PUERTA     <= "01";                                 -- Cierra puerta
                    FLAG_MOTOR <= '1';                                  -- Inicio movimiento de ascensor
                else                                                    -- Funcionamiento similar
                 if (DESTINO = "00") then
                     SIGUIENTE_STATE <= S0;
                     PUERTA <= "01";
                     MOTOR <= "10";
                     PISO_TEMP <= "00";
                     FLAG_MOTOR<='1';
                 elsif (DESTINO = "01") then
                     SIGUIENTE_STATE <= S1;
                     PUERTA<="10";
                     MOTOR<="00";
                     PISO_TEMP <= "01";
                     FLAG_MOTOR <= '0';
                 elsif (DESTINO = "10") then
                     SIGUIENTE_STATE <= S2;
                     PUERTA <= "01";
                     MOTOR <= "01";
                     PISO_TEMP <= "10";
                     FLAG_MOTOR <= '1';
                 elsif (DESTINO = "11") then
                     SIGUIENTE_STATE <= S2;
                     PISO_TEMP <= DESTINO;
                     PUERTA <= "01";
                     MOTOR <= "01";
                     FLAG_MOTOR <= '1';
                 end if;
             end if;
                     
         when S2 =>
             if (PISO_TEMP /= "10") then 
               if(PISO_TEMP = "00") or (PISO_TEMP = "01") then
                   SIGUIENTE_STATE <= S1;
                   MOTOR<="10";
               elsif(PISO_TEMP = "11") then
                    SIGUIENTE_STATE <= S3;
                    MOTOR <= "01";
               end if;
               PUERTA <= "01";
               FLAG_MOTOR <= '1';
             else 
               if (DESTINO = "00") then
                    SIGUIENTE_STATE <= S1;
                    PISO_TEMP <= DESTINO;
                    PUERTA <= "01";
                    MOTOR <= "10";
                    FLAG_MOTOR <= '1';
               elsif (DESTINO = "01") then
                    SIGUIENTE_STATE <= S1;
                    PUERTA <= "01";
                    MOTOR <= "10";
                    PISO_TEMP <= "01";
                    FLAG_MOTOR <= '1';
               elsif (DESTINO = "10") then
                    SIGUIENTE_STATE <= S2;
                    PUERTA <= "10";
                    MOTOR <= "00";
                    PISO_TEMP <= "10";
                    FLAG_MOTOR <= '0';
               elsif (DESTINO = "11") then
                    SIGUIENTE_STATE <= S3;
                    PUERTA <= "01";
                    MOTOR <= "01";
                    PISO_TEMP <= "11";
                    FLAG_MOTOR <= '1';
               end if;
            end if;
                     
         when S3 =>
            if (DESTINO = "11") then
                SIGUIENTE_STATE <= S3;
                PUERTA <= "10";
                MOTOR <= "00";
                FLAG_MOTOR <= '0';
            elsif (DESTINO /= "11") then
                PUERTA <= "01";
                MOTOR <= "10";
                SIGUIENTE_STATE <= S2;
                PISO_TEMP <= DESTINO;
                FLAG_MOTOR <= '1';
            end if;           
            
        end case;
    end process;

end behavioral;