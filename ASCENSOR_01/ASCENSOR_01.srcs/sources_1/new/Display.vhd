
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity Display is
    Port ( clock : in STD_LOGIC;
           Display_destino : out STD_LOGIC_VECTOR (7 downto 0);
           Display_actual : out STD_LOGIC_VECTOR (6 downto 0);
           planta_actual_last : in STD_LOGIC_VECTOR (6 downto 0);
           planta_destino_last : in STD_LOGIC_VECTOR (6 downto 0));
end Display;

architecture Behavioral of Display is

begin

PROCESS (clock)
VARIABLE contador: integer  range 0 to 1 :=0;
BEGIN
IF rising_edge (clock) THEN 
    IF contador=1 THEN
        contador:=0;
    ELSE 
    contador:=contador+1;
   END IF;
 END IF;
 
 CASE contador is 
 
        WHEN 0 => Display_destino <="11111101";
                  Display_actual <= planta_destino_last;
 
        WHEN 1 => Display_destino <= "11111110";
                  Display_actual <= planta_actual_last;
                  
                
   END CASE;
   END PROCESS;
   
end Behavioral;
