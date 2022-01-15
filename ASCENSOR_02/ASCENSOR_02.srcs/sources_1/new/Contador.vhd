library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity contador_tiempo is
    GENERIC (UNO: INTEGER:=1;
             DOS: INTEGER:=2;
             TRES: INTEGER:=3
             );
    Port ( clock_1Hz : in STD_LOGIC;
           start1: in STD_LOGIC;
           start2: in STD_LOGIC;
           start3: in STD_LOGIC;
           tiempo_1s : out STD_LOGIC;
           tiempo_2s : out STD_LOGIC;
           tiempo_3s : out STD_LOGIC);
end contador_tiempo;

architecture Behavioral of contador_tiempo is
SIGNAL SENIAL1: STD_LOGIC:='0';
SIGNAL SENIAL2: STD_LOGIC:='0';
SIGNAL SENIAL3: STD_LOGIC:='0';
begin

SEC1: process (clock_1Hz, start1)
  variable contador1:integer:=0;
  begin
  
		  if clock_1Hz'event and clock_1Hz='1' then
		      if start1 = '1' then 
			     if (contador1=UNO) then
				SENIAL1 <= '1';
				contador1:=0;
			     ELSE
			    SENIAL1 <= '0';
				contador1:=contador1+1;
		end if;
		end if;
		end if;
  end process;
 tiempo_1s <= SENIAL1;
 
 
 SEC2: process (clock_1Hz, start2)
  variable contador2:integer:=0;
  begin
  
	if clock_1Hz'event and clock_1Hz='1' then
		  if start2 = '1' then 
			if (contador2=UNO) then
				SENIAL2 <= '1';
				contador2:=0;
			ELSE
			    SENIAL2 <= '0';
				contador2:=contador2+1;
		end if;
		end if;
		end if;
  end process;
 tiempo_2s <= SENIAL2;
 
 SEC3: process (clock_1Hz, start3)
  variable contador3:integer:=0;
  begin
    
		  if clock_1Hz'event and clock_1Hz='1' then
		       if start3 = '1' then 
			     if (contador3=TRES) then			
				SENIAL3 <= '1';
				contador3:=0;
			     ELSE
			    SENIAL3 <= '0';
				contador3:=contador3+1;
		end if;
		end if;
		end if;
  end process;
 tiempo_3s <= SENIAL3;
 

end Behavioral;
