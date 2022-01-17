library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DOOR is
    GENERIC (DOS: INTEGER:=2);
    Port ( clock_1Hz: in STD_LOGIC;
           clock: in STD_LOGIC;
           orden : in STD_LOGIC;
           resultado : out STD_LOGIC;
           LED0 : out STD_LOGIC);
end DOOR;

architecture Behavioral of DOOR is
        SIGNAL SENIAL2: STD_LOGIC:='0';
        SIGNAL START: STD_LOGIC:='0';
begin

contadorr: PROCESS (clock_1Hz, START)
VARIABLE contador: INTEGER:=0;
    BEGIN
        IF RISING_EDGE (clock_1Hz) THEN
            IF START='1' THEN
                 IF (contador=DOS) then
				SENIAL2 <= '1';
				contador:=0;
			     ELSE
			    SENIAL2 <= '0';
				contador:=contador+1;
    END IF;
        END IF;
            END IF;
END PROCESS;


puerrta: PROCESS (clock, orden, SENIAL2)
BEGIN
IF rising_edge (clock) THEN
		IF orden = '1' THEN
		      START <= '1';
        IF SENIAL2='1' THEN  --   WAIT FOR 2000000us;
            resultado <= '1';
           LED0 <= '1';
            START <= '0';
         ELSE
            resultado <= '0';
           LED0 <= '0';
        END IF;
        
        ELSIF orden = '0' THEN
           START <= '1';
        IF SENIAL2='1' THEN  --   WAIT FOR 2000000us;
            resultado <= '0';
            LED0 <= '0';
            START <= '0';       
     END IF;
        END IF;   
    END IF;
END PROCESS;

end Behavioral;
