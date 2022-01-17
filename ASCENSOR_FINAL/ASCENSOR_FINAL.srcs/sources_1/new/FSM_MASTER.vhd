library ieee;
use ieee.std_logic_1164.all;

entity FSM_MASTER is
    port
    (
        CLK : in std_logic;
        RESET : in std_logic;
        DESTINO : in std_logic_vector (1 downto 0);
        DESTINO_OUT : out std_logic_vector (1 downto 0);
        PUERTA: out std_logic_vector (1 downto 0);
        MOTOR: out std_logic_vector(1 downto 0);
        FLAG_MOTOR: out std_logic
    );
end entity;

architecture behavioral of FSM_MASTER is
    type STATE_type is (S0, S1, S2, S3);
    signal STATE: state_type;
    signal SIGUIENTE_STATE : state_type;
    signal PISO_TEMP : std_logic_vector (1 downto 0);
    
begin

 SYNC_PROC: process (CLK, RESET)
    begin
        if (RESET = '0') then
                STATE <= S0;
        elsif rising_edge(CLK) then
            STATE <= SIGUIENTE_STATE;
        end if;
    end process;
    
    OUTPUT_DECODE: process (STATE)
    begin
        case (STATE) is
            when S0 => DESTINO_OUT <= "00";
            when S1 => DESTINO_OUT <= "01";
            when S2 => DESTINO_OUT <= "10";
            when S3 => DESTINO_OUT <= "11";
            when others => DESTINO_OUT <= "00";
        end case;
    end process;
    
    NEXT_STATE_DECODE: process (STATE, DESTINO)
    begin
        SIGUIENTE_STATE <= S0;
        case (STATE) is
        
          when S0 =>
              if (DESTINO = "00") then
                  SIGUIENTE_STATE <= S0;
                  PUERTA<="10";
                  MOTOR<="00";
                  FLAG_MOTOR<='0';
              elsif (DESTINO /= "00") then
                  PUERTA<="01";
                  MOTOR<="01";
                  SIGUIENTE_STATE <= S1;
                  PISO_TEMP <= DESTINO;
                  FLAG_MOTOR<='1';
              end if;
                      
          when S1 =>
              if (PISO_TEMP /= "01") then 
                 if(PISO_TEMP = "10") or (PISO_TEMP = "11") then
                     SIGUIENTE_STATE <= S2;
                     MOTOR<="01";
                 elsif(PISO_TEMP = "00") then
                     SIGUIENTE_STATE <= S0;
                     MOTOR<="10";
                 end if;
                 PUERTA<="01";
                 FLAG_MOTOR<='1';
              else 
                 if (DESTINO = "00") then
                     SIGUIENTE_STATE <= S0;
                     PUERTA<="01";
                     MOTOR<="10";
                     PISO_TEMP <= "00";
                     FLAG_MOTOR<='1';
                 elsif (DESTINO = "01") then
                     SIGUIENTE_STATE <= S1;
                     PUERTA<="10";
                     MOTOR<="00";
                     PISO_TEMP <= "01";
                     FLAG_MOTOR<='0';
                 elsif (DESTINO = "10") then
                     SIGUIENTE_STATE <= S2;
                     PUERTA<="01";
                     MOTOR<="01";
                     PISO_TEMP <= "10";
                     FLAG_MOTOR<='1';
                 elsif (DESTINO = "11") then
                     SIGUIENTE_STATE <= S2;
                     PISO_TEMP <= DESTINO;
                     PUERTA<="01";
                     MOTOR<="01";
                     FLAG_MOTOR<='1';
                 end if;
             end if;
                     
         when S2 =>
             if (PISO_TEMP /= "10") then 
               if(PISO_TEMP = "00") or (PISO_TEMP = "01") then
                   SIGUIENTE_STATE <= S1;
                   MOTOR<="10";
               elsif(PISO_TEMP = "11") then
                    SIGUIENTE_STATE <= S3;
                    MOTOR<="01";
               end if;
               PUERTA<="01";
               FLAG_MOTOR<='1';
             else 
               if (DESTINO = "00") then
                    SIGUIENTE_STATE <= S1;
                    PISO_TEMP <= DESTINO;
                    PUERTA<="01";
                    MOTOR<="10";
                    FLAG_MOTOR<='1';
               elsif (DESTINO = "01") then
                    SIGUIENTE_STATE <= S1;
                    PUERTA<="01";
                    MOTOR<="10";
                    PISO_TEMP <= "01";
                    FLAG_MOTOR<='1';
               elsif (DESTINO = "10") then
                    SIGUIENTE_STATE <= S2;
                    PUERTA<="10";
                    MOTOR<="00";
                    PISO_TEMP <= "10";
                    FLAG_MOTOR<='0';
               elsif (DESTINO = "11") then
                    SIGUIENTE_STATE <= S3;
                    PUERTA<="01";
                    MOTOR<="01";
                    PISO_TEMP <= "11";
                    FLAG_MOTOR<='1';
               end if;
            end if;
                     
         when S3 =>
            if (DESTINO = "11") then
                SIGUIENTE_STATE <= S3;
                PUERTA<="10";
                MOTOR<="00";
                FLAG_MOTOR<='0';
            elsif (DESTINO /= "11") then
                PUERTA<="01";
                MOTOR<="10";
                SIGUIENTE_STATE <= S2;
                PISO_TEMP <= DESTINO;
                FLAG_MOTOR<='1';
            end if;           
            
        end case;
    end process;

end behavioral;