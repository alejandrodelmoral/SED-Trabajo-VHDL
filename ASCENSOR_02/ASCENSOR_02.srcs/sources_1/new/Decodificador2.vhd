
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity Decoder2 is
    Port ( clock : in STD_LOGIC;
           Decoder_P_A_2 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           Decoder_Pin_Display_2 : out STD_LOGIC_VECTOR(6 DOWNTO 0));
end Decoder2;

architecture Behavioral of Decoder2 is

begin

DECODIFICADOR2: PROCESS (clock, Decoder_P_A_2)
	BEGIN
		IF (clock'event and clock = '1') THEN
        
		IF Decoder_P_A_2 = "001" THEN
		      Decoder_Pin_Display_2 <= "1001111";
		ELSIF Decoder_P_A_2 = "010" THEN  
		      Decoder_Pin_Display_2 <= "0010010";
		ELSIF Decoder_P_A_2 = "011" THEN
		      Decoder_Pin_Display_2 <= "0000110";
		ELSIF Decoder_P_A_2 = "100" THEN
		      Decoder_Pin_Display_2 <= "1001100";
		      END IF;
			END IF;
      END PROCESS;

end Behavioral;
