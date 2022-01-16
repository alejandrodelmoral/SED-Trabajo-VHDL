
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.ALL;

entity ASCENSOR is
    Port ( clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           ASCENSOR_PLANTA_DESTINO : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           ASCENSOR_PLANTA_ACTUAL : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DISPLAY_DESTINO: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DISPLAY_ACTUAL: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_INDICADOR_DE_LLEGADA: out STD_LOGIC;
           LED0: out STD_LOGIC; --led de la puerta, 0 cerrada, 1 abierta
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
           );               
end ASCENSOR;

architecture Behavioral of ASCENSOR is
    TYPE state_type IS (E1, E2, E3); --E1 es estado en reposo, E2 subiendo, E3 bajando
    SIGNAL next_state: state_type;
    SIGNAL state: state_type;
    SIGNAL LED_E1: STD_LOGIC;
    SIGNAL ASCEN_Planta_destino: INTEGER ;
    SIGNAL ASCEN_Planta_actual: INTEGER;
    SIGNAL MOTOR: STD_LOGIC_VECTOR (1 downto 0);
		
begin     --------------------------------------------------------------------------------------------

        

SINCRONIZACION_RELOJ: PROCESS (clock,RST)
	BEGIN  
	  --  state <= E1;	  
	  IF RST= '1' THEN
	       state <= E1;
	       DISPLAY_DESTINO <= "001";
	       DISPLAY_ACTUAL <= "001";  
	       ASCEN_Planta_destino <= 1;
	       ASCEN_Planta_actual <= 1;
	             
		ELSIF (clock'event and clock='1') AND RST='0' THEN
		ASCEN_Planta_actual<= to_integer(unsigned(ASCENSOR_PLANTA_ACTUAL));  	   	     
	    DISPLAY_ACTUAL <= STD_LOGIC_VECTOR(TO_UNSIGNED(ASCEN_Planta_actual, DISPLAY_DESTINO'LENGTH));
	    state <= next_state;
	  IF MOTOR = "00" THEN
	    ASCEN_Planta_destino <= to_integer(unsigned(ASCENSOR_PLANTA_DESTINO));  
	    DISPLAY_DESTINO <= STD_LOGIC_VECTOR(TO_UNSIGNED(ASCEN_Planta_destino, DISPLAY_DESTINO'LENGTH)); 
	    END IF;
	    END IF;
END PROCESS;


NEXT_STATE_DECODE: PROCESS (clock, state, ASCEN_Planta_destino, ASCEN_Planta_actual)  

  BEGIN	
	next_state <= state;    	     
     case state is
     when E1 =>
     IF (ASCEN_Planta_destino-ASCEN_Planta_actual=0 ) THEN		--si estamos en la planta que queremos		
		        next_state <= E1;
   		        
      
ELSIF (ASCEN_Planta_destino-ASCEN_Planta_actual>0) THEN   --si estamos en planta mas abajo, subiremos
				next_state <= E2;	


ELSIF (ASCEN_Planta_destino-ASCEN_Planta_actual<0) THEN
				next_state <= E3;


END IF;
        when E2=>         
       IF (ASCEN_Planta_destino-ASCEN_Planta_actual=0) THEN		--si estamos en la planta que queremos		
		        next_state <= E1;
		        END IF;   
        when E3=> 
         IF (ASCEN_Planta_destino-ASCEN_Planta_actual=0) THEN		--si estamos en la planta que queremos	
		        next_state <= E1;

		        END IF;
END CASE;
END PROCESS;


Estado_del_motor: PROCESS (clock, state )
begin       
        case state is 
        when E1=>
                MOTOR <= "00";
                motor_out <= "00";
                LED0 <= '1';
                 LED_INDICADOR_DE_LLEGADA <= '1';
        when E2 =>               
                 MOTOR <= "01";
                 motor_out <= "01";  
                 LED0 <= '0';
                  LED_INDICADOR_DE_LLEGADA <= '0';          
         when E3 => 
                 MOTOR <= "10";
                 motor_out <= "10"; 
                 LED0 <= '0';
                  LED_INDICADOR_DE_LLEGADA <= '0';    
end case;
	END PROCESS;

end Behavioral;
