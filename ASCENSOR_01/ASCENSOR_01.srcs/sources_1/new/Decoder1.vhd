
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Decoder1 is
    Port ( clock : in STD_LOGIC;
           Decodificador1_boton1 : in STD_LOGIC;
           Decodificador1_boton2 : in STD_LOGIC;
           Decodificador1_boton3 : in STD_LOGIC;
           Decodificador1_boton4 : in STD_LOGIC;
           Decodificador1_boton5 : in STD_LOGIC;
           Decodificador1_boton6 : in STD_LOGIC;
           Decodificador1_P_D_1 : out STD_LOGIC_VECTOR (2 DOWNTO 0));
end Decoder1;

architecture Behavioral of Decoder1 is

begin


DECODIFICADOR1: PROCESS (clock, Decodificador1_boton1, Decodificador1_boton2, Decodificador1_boton3, Decodificador1_boton4)
	BEGIN
		IF clock'event and clock='1' THEN		
		
		IF Decodificador1_boton1='1' THEN          
		  Decodificador1_P_D_1 <= "001";
		ELSIF Decodificador1_boton2='1' THEN
		  Decodificador1_P_D_1 <= "010";
		ELSIF Decodificador1_boton3='1' THEN
		  Decodificador1_P_D_1 <= "011";
		ELSIF Decodificador1_boton4='1' THEN
		  Decodificador1_P_D_1 <= "100";
		ELSIF Decodificador1_boton5='1' THEN
		  Decodificador1_P_D_1 <= "101";
		ElSIF Decodificador1_boton6='1' THEN
		  Decodificador1_P_D_1 <= "110";

		  
		END IF;
		
		END IF;     
END PROCESS; 

end Behavioral;
