library ieee;
use ieee.std_logic_1164.all;

entity FSM_ESCLAVO is
    port
    (
        CLK        : in  std_logic;                         -- Reloj       
        RESET      : in  std_logic;                         -- Reset
        FLAG_MOTOR : in  std_logic := '0';                  -- Flag del motor, marca el comienzo y final del ascensor
        SWITCH     : in  std_logic_vector (3 downto 0);     -- Vector de Switch
        DESTINO    : out std_logic_vector (1 downto 0)      -- Planta destino
    );
end entity;

architecture behavioral of FSM_ESCLAVO is
    type state_type is (S0, S1, S2, S3);        -- Estados
    signal STATE           : state_type;        -- Estado actual
    signal SIGUIENTE_STATE : state_type;        -- Estado siguiente
begin
    STATE_REGISTER: process (CLK)
    begin
        if rising_edge (CLK) then               -- Cuando hay un flanco ascendente de reloj
            if RESET = '0' then                 -- Reset con prioridad
                STATE <= S0;                    -- Estado inicial
            elsif FLAG_MOTOR = '0' then         -- Si el ascensor esta en marcha
                STATE <= SIGUIENTE_STATE;       -- Cambia de estado al siguiente
            end if;
        end if;
    end process;

    OUTPUT: process (STATE)
    begin
        case STATE is                           -- El estado marca la planta destino
            when S0 =>
                DESTINO <= "00";
            when S1 =>
                DESTINO <= "01";
            when S2 =>
                DESTINO <= "10";
            when S3 =>
                DESTINO <= "11";
            when others => 
                DESTINO <= "00";
        end case;
    end process;
    
    STATE_NEXT: process (STATE, SWITCH)
        begin
        SIGUIENTE_STATE <= state;               -- Se cambia de estado
                                                -- Lo comentado ya "funciona" (compila)
--        case (state) is
--            when S0 to S3 =>
--                if(SWITCH = "0001") then      -- Estado siguiente es planta 1
--                    SIGUIENTE_STATE <= S0;
--                elsif(SWITCH = "0010") then   -- Estado siguiente es planta 2
--                    SIGUIENTE_STATE <= S1;
--                elsif(SWITCH = "0100") then   -- Estado siguiente es planta 3
--                    SIGUIENTE_STATE <= S2;
--                elsif(SWITCH = "1000") then   -- Estado siguiente es planta 4
--                    SIGUIENTE_STATE <= S3;
--                end if;
        
        case (state) is
            when S0 =>
                if(SWITCH = "0001") then 
                    SIGUIENTE_STATE <= S0;
                elsif(SWITCH = "0010") then
                    SIGUIENTE_STATE <= S1;
                elsif(SWITCH = "0100") then
                    SIGUIENTE_STATE <= S2;
                elsif(SWITCH = "1000") then
                    SIGUIENTE_STATE <= S3;
                end if;
                
            when S1 =>
                if(SWITCH = "0001") then 
                    SIGUIENTE_STATE <= S0;
                elsif(SWITCH = "0010") then
                    SIGUIENTE_STATE <= S1;
                elsif(SWITCH = "0100") then
                    SIGUIENTE_STATE <= S2;
                elsif(SWITCH = "1000") then
                    SIGUIENTE_STATE <= S3;
                end if;
            when S2 =>
                if(SWITCH = "0001") then 
                    SIGUIENTE_STATE <= S0;
                elsif(SWITCH = "0010") then
                    SIGUIENTE_STATE <= S1;
                elsif(SWITCH = "0100") then
                    SIGUIENTE_STATE <= S2;
                elsif(SWITCH = "1000") then
                    SIGUIENTE_STATE <= S3;
                end if;
         when S3 =>
                if(SWITCH = "0001") then 
                    SIGUIENTE_STATE <= S0;
                elsif(SWITCH = "0010") then
                    SIGUIENTE_STATE <= S1;
                elsif(SWITCH = "0100") then
                    SIGUIENTE_STATE <= S2;
                elsif(SWITCH = "1000") then
                    SIGUIENTE_STATE <= S3;
                end if;
        end case;
    end process;
end architecture behavioral;
