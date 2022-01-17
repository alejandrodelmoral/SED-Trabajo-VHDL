library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MOTOR is
    port
    (
        clock        : in  std_logic;                           -- Reloj
        SENSOR_MOTOR : in  std_logic_vector (1 downto 0);       -- Motor
        LED1         : out std_logic;                           -- Led1
        LED2         : out std_logic                            -- Led2
    );
end MOTOR;

architecture Behavioral of MOTOR is
begin
    motorrr: process (clock, SENSOR_MOTOR)
    begin
        if rising_edge (clock) then             -- Si hay un flanco ascendente de reloj (Sincrono)
            if SENSOR_MOTOR = "00" then         -- Si el motor vale 0, ambos leds apagados
                LED1 <= '0';
                LED2 <= '0';
            elsif SENSOR_MOTOR = "01" then      -- Si el motor vale 1, led2 encendido
                LED1 <= '0';
                LED2 <= '1';
            elsif SENSOR_MOTOR = "10" then      -- Si el motor vale 2, led1 encendido
                LED1 <= '1';
                LED2 <= '0';
            end if;
        end if;
    end process;
end architecture Behavioral;
