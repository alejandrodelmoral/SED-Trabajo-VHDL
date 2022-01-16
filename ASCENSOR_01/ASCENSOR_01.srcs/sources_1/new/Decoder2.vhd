
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity Decoder2 is
    Port ( clock : in STD_LOGIC;
           Decodificador2_P_A_2 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           Decodificador2_Display_2 : out STD_LOGIC_VECTOR(6 DOWNTO 0);
           Decodificador2_P_D_2 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           Decodificador2_Display_1 : out STD_LOGIC_VECTOR (6 downto 0));
           
end Decoder2;

architecture Behavioral of Decoder2 is

begin

DECODIFICADOR2: PROCESS (clock, Decodificador2_P_A_2,Decodificador2_P_D_2)
	BEGIN
		IF (clock'event and clock = '1') THEN
        
		IF Decodificador2_P_A_2 = "001" THEN
		      Decodificador2_Display_2 <= "1001111";
		ELSIF Decodificador2_P_A_2 = "010" THEN  
		      Decodificador2_Display_2 <= "0010010";
		ELSIF Decodificador2_P_A_2 = "011" THEN
		      Decodificador2_Display_2 <= "0000110";
		ELSIF Decodificador2_P_A_2 = "100" THEN
		      Decodificador2_Display_2 <= "1001100";
		ELSIF Decodificador2_P_A_2 = "101" THEN
		      Decodificador2_Display_2 <= "0100100";
		ELSIF Decodificador2_P_A_2 = "110" THEN
		      Decodificador2_Display_2 <= "0100000";
		 
		      END IF;
		IF 	Decodificador2_P_D_2 = "001" THEN
				Decodificador2_Display_1 <= "1001111";			  
			ELSIF 	Decodificador2_P_D_2 = "010" THEN    --SUSTITUIR CONSTRUCCION WHEN/ELSE POR CONSTRUCCION IF THEN PORQUE SOLO LA VERSION VHDL2008 PERMITE LA CONSTRUCCION WHEN
				Decodificador2_Display_1 <= "0010010";
			ELSIF 	Decodificador2_P_D_2 = "011" THEN
				Decodificador2_Display_1 <= "0000110";
			ELSIF 	Decodificador2_P_D_2 = "100" THEN
				Decodificador2_Display_1 <= "1001100";
		      ELSIF Decodificador2_P_D_2 = "101" THEN
		      Decodificador2_Display_1 <= "0100100";
		     ELSIF Decodificador2_P_D_2 = "110" THEN
		      Decodificador2_Display_1 <= "0100000";
				END IF;			  
			END IF;
      END PROCESS;

end Behavioral;