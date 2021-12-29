
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Decoder3 is
    Port ( clock : in STD_LOGIC;
           planta_destino3 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           pines_display1 : out STD_LOGIC_VECTOR (6 downto 0));
end Decoder3;

architecture Behavioral of Decoder3 is

begin

DECODIFICADOR3: PROCESS (clock, planta_destino3)
		BEGIN
		   IF rising_edge (clock) THEN		   
			
			IF 	planta_destino3 = "001" THEN
				pines_display1 <= "1001111";			  
			ELSIF 	planta_destino3 = "010" THEN    --SUSTITUIR CONSTRUCCION WHEN/ELSE POR CONSTRUCCION IF THEN PORQUE SOLO LA VERSION VHDL2008 PERMITE LA CONSTRUCCION WHEN
				pines_display1 <= "0010010";
			ELSIF 	planta_destino3 = "011" THEN
				pines_display1 <= "0000110";
			ELSIF 	planta_destino3 = "100" THEN
				pines_display1 <= "1001100";		
				END IF;			  
			END IF;       END PROCESS;

end Behavioral;


