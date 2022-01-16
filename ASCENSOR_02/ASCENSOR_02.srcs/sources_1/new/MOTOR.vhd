
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity MOTOR is
    Port ( clock : in STD_LOGIC;
           SENSOR_MOTOR : in STD_LOGIC_VECTOR (1 downto 0);
           LED1 : out STD_LOGIC;
           LED2 : out STD_LOGIC);
end MOTOR;

architecture Behavioral of MOTOR is

begin

motorrr: PROCESS (clock, SENSOR_MOTOR)
		BEGIN
    IF rising_edge (clock) THEN

	IF SENSOR_MOTOR = "00" THEN
	       LED1 <= '0';
	       LED2 <= '0';
	ELSIF SENSOR_MOTOR = "01" THEN     --SUSTITUIR CONSTRUCCION WHEN/ELSE POR CONSTRUCCION IF THEN PORQUE SOLO LA VERSION VHDL2008 PERMITE LA CONSTRUCCION WHEN
	       LED1 <= '0';
	       LED2 <= '1';
	ELSIF SENSOR_MOTOR = "10" THEN
	       LED1 <= '1';
	       LED2 <= '0';
END IF;
	END IF;
END PROCESS;

end Behavioral;
