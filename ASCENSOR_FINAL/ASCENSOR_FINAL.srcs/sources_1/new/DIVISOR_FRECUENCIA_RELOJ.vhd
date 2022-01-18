library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DIVISOR_FRECUENCIA_RELOJ is
    generic
    (
        FREC : integer := 100000000     -- Frecuencia de reloj
    );
    port
    (
        CLK_100MHz : in  std_logic;     -- Reloj a 100 Mhz
        RESET      : in  std_logic;     -- Reset
        CLK_100Hz  : out std_logic      -- Reloj a 0.5 Hz
    ); 
end entity;

architecture behavioral of DIVISOR_FRECUENCIA_RELOJ is
    signal CONTADOR : integer := 1;         -- Contador
    signal CLK_TEMP : std_logic;            -- Salida de pulso de 100Hz
    
begin
    process (CLK_100MHz, RESET)
    begin
        if RESET = '0' then                 -- Reset con prioridad
            CONTADOR <= 1;
            CLK_TEMP <= '0';
        elsif rising_edge (CLK_100MHz) then -- Cuando hay un flanco ascendente de reloj
            CONTADOR <= CONTADOR + 1;
            if CONTADOR = FREC then         -- Una vez el reloj cuente 100M de pulsos
                CLK_TEMP <= not CLK_TEMP;   -- Cambia de nivel el pulso cada 1 seg
                CONTADOR <= 1;
            end if;
        end if;
        CLK_100Hz <= CLK_TEMP;              -- Se genera el pulso de reloj
     end process;
end architecture behavioral;