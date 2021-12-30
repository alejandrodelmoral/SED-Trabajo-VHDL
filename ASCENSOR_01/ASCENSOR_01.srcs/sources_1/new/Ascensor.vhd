
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.ALL;

entity ASCENSOR is
    Port ( clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           planta_destino : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           planta_actual : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_DEST: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_ACT: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_INDICADOR_DE_LLEGADA: out STD_LOGIC;
           LED0: out STD_LOGIC; --led de la puerta, 0 cerrada, 1 abierta
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
           );               
end ASCENSOR;

architecture Behavioral of ASCENSOR is
    TYPE state_type IS (S1, S2, S3); --S1 es estado en reposo, S2 subiendo, S3 bajando
    SIGNAL next_state: state_type;
    SIGNAL state: state_type;
    SIGNAL LED_S1: STD_LOGIC;
    SIGNAL planta_destinoo: INTEGER ;
    SIGNAL planta_actuall: INTEGER;
    SIGNAL MOTOR: STD_LOGIC_VECTOR (1 downto 0);
		
begin     --------------------------------------------------------------------------------------------

        

SINCRONIZACION_RELOJ: PROCESS (clock,RST)
	BEGIN  
	  --  state <= S1;	  
	  IF RST= '1' THEN
	       state <= S1;
	       DIS_DEST <= "001";
	       DIS_ACT <= "001";  
	       planta_destinoo <= 1;
	       planta_actuall <= 1;
	             
		ELSIF (clock'event and clock='1') AND RST='0' THEN
		planta_actuall<= to_integer(unsigned(planta_actual));  	   	     
	    DIS_ACT <= STD_LOGIC_VECTOR(TO_UNSIGNED(planta_actuall, DIS_DEST'LENGTH));
	    state <= next_state;
	  IF MOTOR = "00" THEN
	    planta_destinoo <= to_integer(unsigned(planta_destino));  
	    DIS_DEST <= STD_LOGIC_VECTOR(TO_UNSIGNED(planta_destinoo, DIS_DEST'LENGTH)); 
	    END IF;
	    END IF;
END PROCESS;


NEXT_STATE_DECODE: PROCESS (clock, state, planta_destinoo, planta_actuall)  

  BEGIN	
	next_state <= state;    	     
     case state is
     when S1 =>
     IF (planta_destinoo-planta_actuall=0 ) THEN		--si estamos en la planta que queremos		
		        next_state <= S1;
   		        
      
ELSIF (planta_destinoo-planta_actuall>0) THEN   --si estamos en planta mas abajo, subiremos
				next_state <= S2;	


ELSIF (planta_destinoo-planta_actuall<0) THEN
				next_state <= S3;


END IF;
        when S2=>         
       IF (planta_destinoo-planta_actuall=0) THEN		--si estamos en la planta que queremos		
		        next_state <= S1;
		        END IF;   
        when S3=> 
         IF (planta_destinoo-planta_actuall=0) THEN		--si estamos en la planta que queremos	
		        next_state <= S1;

		        END IF;
END CASE;
END PROCESS;


Estado_del_motor: PROCESS (clock, state )
begin       
        case state is 
        when S1=>
                MOTOR <= "00";
                motor_out <= "00";
                LED0 <= '1';
                 LED_INDICADOR_DE_LLEGADA <= '1';
        when S2 =>               
                 MOTOR <= "01";
                 motor_out <= "01";  
                 LED0 <= '0';
                  LED_INDICADOR_DE_LLEGADA <= '0';          
         when S3 => 
                 MOTOR <= "10";
                 motor_out <= "10"; 
                 LED0 <= '0';
                  LED_INDICADOR_DE_LLEGADA <= '0';    
end case;
	END PROCESS;

end Behavioral;
