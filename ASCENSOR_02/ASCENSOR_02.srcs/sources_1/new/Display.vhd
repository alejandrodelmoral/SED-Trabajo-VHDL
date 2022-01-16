
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity Display is
    Port ( clock : in STD_LOGIC;
           display_selection : out STD_LOGIC_VECTOR (7 downto 0);
           display_number : out STD_LOGIC_VECTOR (6 downto 0);
           Display_P_A : in STD_LOGIC_VECTOR (6 downto 0);
           Display_P_D : in STD_LOGIC_VECTOR (6 downto 0));
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
 
        WHEN 0 => display_selection <="11111101";
                  display_number <= Display_P_D;
 
        WHEN 1 => display_selection <= "11111110";
                  display_number <= Display_P_A;
                  
                
   END CASE;
   END PROCESS;
   
end Behavioral;