library ieee;
use ieee.std_logic_1164.all;

entity FSM_ESCLAVO is
    port
    (
        CLK        : in  std_logic;                 
        RESET      : in  std_logic;                         
        FLAG_MOTOR : in  std_logic := '0';                  
        SWITCH     : in  std_logic_vector(3 downto 0);      -- Vectores Switch
        DESTINO    : out std_logic_vector(1 downto 0)
    );
end entity;

architecture behavioral of FSM_ESCLAVO is
    type state_type is (S0, S1, S2, S3);
    signal STATE           : state_type;
    signal SIGUIENTE_STATE : state_type;
begin
    STATE_REGISTER: process (CLK)
    begin
        if rising_edge (CLK) then
            if RESET = '0' then
                STATE <= S0;
            elsif FLAG_MOTOR = '0' then
                STATE <= SIGUIENTE_STATE;
            end if;
        end if;
    end process;

    OUTPUT: process (STATE)
    begin
        case STATE is
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
        SIGUIENTE_STATE <= state;
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
