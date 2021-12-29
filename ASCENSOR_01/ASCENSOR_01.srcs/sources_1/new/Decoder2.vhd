
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity Decoder2 is
    Port ( clock : in STD_LOGIC;
           planta_actual_2 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           pines_display2 : out STD_LOGIC_VECTOR(6 DOWNTO 0));
end Decoder2;

architecture Behavioral of Decoder2 is

begin

DECODIFICADOR2: PROCESS (clock, planta_actual_2)
	BEGIN
		IF (clock'event and clock = '1') THEN
        
		IF planta_actual_2 = "001" THEN
		      pines_display2 <= "1001111";
		ELSIF planta_actual_2 = "010" THEN  
		      pines_display2 <= "0010010";
		ELSIF planta_actual_2 = "011" THEN
		      pines_display2 <= "0000110";
		ELSIF planta_actual_2 = "100" THEN
		      pines_display2 <= "1001100";
		      END IF;
			END IF;
      END PROCESS;

end Behavioral;
