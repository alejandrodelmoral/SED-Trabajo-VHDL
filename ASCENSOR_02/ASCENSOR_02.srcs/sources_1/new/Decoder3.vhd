
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Decoder3 is
    Port ( clock : in STD_LOGIC;
           Decoder_P_D_3 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           Decoder_Pin_Display_3 : out STD_LOGIC_VECTOR (6 downto 0));
end Decoder3;

architecture Behavioral of Decoder3 is

begin

DECODIFICADOR3: PROCESS (clock, Decoder_P_D_3)
		BEGIN
		   IF rising_edge (clock) THEN		   
			
			IF 	Decoder_P_D_3 = "001" THEN
				Decoder_Pin_Display_3 <= "1001111";			  
			ELSIF 	Decoder_P_D_3 = "010" THEN    --SUSTITUIR CONSTRUCCION WHEN/ELSE POR CONSTRUCCION IF THEN PORQUE SOLO LA VERSION VHDL2008 PERMITE LA CONSTRUCCION WHEN
				Decoder_Pin_Display_3 <= "0010010";
			ELSIF 	Decoder_P_D_3 = "011" THEN
				Decoder_Pin_Display_3 <= "0000110";
			ELSIF 	Decoder_P_D_3 = "100" THEN
				Decoder_Pin_Display_3 <= "1001100";		
				END IF;			  
			END IF;       END PROCESS;

end Behavioral;