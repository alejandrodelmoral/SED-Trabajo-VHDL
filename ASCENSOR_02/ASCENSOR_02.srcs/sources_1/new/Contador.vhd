library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_tiempo is
    generic
    (
        UNO  : integer := 1;        -- Variable entera de valor 1
        DOS  : INTEGER := 2;        -- Variable entera de valor 2
        TRES : INTEGER := 3         -- Variable entera de valor 3
    );

    port
    (
        clock_1Hz : in  std_logic;      -- Reloj 1 Hz
        start1    : in  std_logic;      -- ?
        start2    : in  std_logic;      -- ?
        start3    : in  std_logic;      -- ?
        tiempo_1s : out std_logic;      -- ?
        tiempo_2s : out std_logic;      -- ?
        tiempo_3s : out std_logic       -- ?
    );
end contador_tiempo;

architecture Behavioral of contador_tiempo is
    signal SENIAL1: std_logic := '0';       -- Señal ?
    signal SENIAL2: std_logic := '0';       -- ?
    signal SENIAL3: std_logic := '0';       -- ?
begin
    SEC1: process (clock_1Hz, start1)
        variable contador1 : integer := 0;      -- Variable entera contador
    begin
        if clock_1Hz'event and clock_1Hz = '1' then     -- Si hay un flanco ascendente de reloj (Sincrono)
            if start1 = '1' then
                if (contador1 = UNO) then
                    SENIAL1 <= '1';
                    contador1 := 0;
                else
                    SENIAL1 <= '0';
                    contador1 := contador1 + 1;
                end if;
            end if;
        end if;
    end process;
    tiempo_1s <= SENIAL1;

    SEC2: process (clock_1Hz, start2)
        variable contador2 : integer := 0;
    begin
        if clock_1Hz'event and clock_1Hz = '1' then
            if start2 = '1' then
                if contador2 = UNO then
                    SENIAL2 <= '1';
                    contador2 := 0;
                else
                    SENIAL2 <= '0';
                    contador2 := contador2 + 1;
                end if;
            end if;
        end if;
    end process;
    tiempo_2s <= SENIAL2;

    SEC3: process (clock_1Hz, start3)
        variable contador3:integer:=0;
    begin
        if clock_1Hz'event and clock_1Hz = '1' then
            if start3 = '1' then
                if contador3 = TRES then
                    SENIAL3 <= '1';
                    contador3 :=0 ;
                else
                    SENIAL3 <= '0';
                    contador3 := contador3 + 1;
                end if;
            end if;
        end if;
    end process;
    tiempo_3s <= SENIAL3;
    
end architecture Behavioral;
