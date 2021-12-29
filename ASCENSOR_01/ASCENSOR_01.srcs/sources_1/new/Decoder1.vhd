
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Decoder1 is
    Port ( clock : in STD_LOGIC;
           boton1 : in STD_LOGIC;
           boton2 : in STD_LOGIC;
           boton3 : in STD_LOGIC;
           boton4 : in STD_LOGIC;
           planta_destino : out STD_LOGIC_VECTOR (2 DOWNTO 0));
end Decoder1;

architecture Behavioral of Decoder1 is

begin


DECODIFICADOR1: PROCESS (clock, boton1, boton2, boton3, boton4)
	BEGIN
		IF clock'event and clock='1' THEN		
		
		IF boton1='1' THEN          
		  planta_destino <= "001";
		ELSIF boton2='1' THEN
		  planta_destino <= "010";
		ELSIF boton3='1' THEN
		  planta_destino <= "011";
		ELSIF boton4='1' THEN
		  planta_destino <= "100";
		END IF;
		
		END IF;     
END PROCESS; 

end Behavioral;
