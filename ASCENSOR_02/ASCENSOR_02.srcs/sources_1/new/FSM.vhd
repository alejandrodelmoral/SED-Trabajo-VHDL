
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity ASCEN is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           RST: in STD_LOGIC;
           planta_destino : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           clock_up1: in STD_LOGIC;
           clock_up2: in STD_LOGIC;
           clock_up3: in STD_LOGIC;
           motor_out : out STD_LOGIC_VECTOR (1 downto 0);
           planta_act_sal : out STD_LOGIC_VECTOR (2 DOWNTO 0);
           puerta_ordenn : out STD_LOGIC;
           empieza1: out STD_LOGIC;
           empieza2: out STD_LOGIC;
           empieza3: out STD_LOGIC
           );
                
end ASCEN;

architecture Behavioral of ASCEN is
    TYPE state_type IS (S1, S2, S3);
    SIGNAL next_state: state_type;
    SIGNAL state: state_type:=S1;
    SIGNAL P_DEST: STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL PUERTA_ORDEN: STD_LOGIC:='0';
    SIGNAL ESTADO_PUERTA: STD_LOGIC;
    SIGNAL ESTADO_MOTOR: STD_LOGIC_VECTOR (1 DOWNTO 0);

    
    SIGNAL P_D: INTEGER:=1;
    SIGNAL P_A: INTEGER:=1;
		
begin     --------------------------------------------------------------------------------------------

--		P_A <= to_integer(unsigned(planta_act_sal));  -- UNSIGNED ES OBLIGATORIO Y NO SE PREGUNTA POR QUE
		P_D <= to_integer(unsigned(planta_destino));  -- UNSIGNED ES OBLIGATORIO Y NO SE PREGUNTA POR QUE
--        planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
        

SINCRONIZACION_RELOJ: PROCESS (clock)
	BEGIN
		IF rising_edge (clock) THEN
	state <= next_state;
END IF;
END PROCESS;


NEXT_STATE_DECODE: PROCESS (clock, state, enable, P_D, P_A)
  BEGIN
	
		next_state <= S1;
	IF rising_edge (clock) THEN
	IF state=S1 THEN
IF (P_D-P_A=0 AND enable = '0') THEN
				planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
		        next_state <= S1;
ELSIF (P_D-P_A=1 AND enable = '0') THEN
				next_state <= S2;
		        empieza3 <=	'1';
		        
		        IF clock_up3 = '1' THEN
				 --   P_A <= P_D;
				    P_A <= P_A+1;     ---SUSTITUIR P_A <= P_D; POR P_A <= P_A+1;
				    planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				    next_state <= S1;
				    PUERTA_ORDEN <= '1';
				    empieza3 <= '0';
				END IF;
				
ELSIF (P_D-P_A=2 AND enable = '0') THEN
				next_state <= S2;
		        empieza3 <= '1';
		        
		        IF clock_up3 = '1' THEN
				    P_A <= P_A+1;
				    planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				    empieza3 <= '0';				
				    empieza1 <= '1';				
			    IF clock_up1 = '1' THEN
				  --  P_A <= P_D;
				    P_A <= P_A+1;
				    planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				    next_state <= S1;
				    PUERTA_ORDEN <= '1';
				    empieza1 <= '0';
				END IF;
		   END IF;
		   
ELSIF (P_D-P_A=3 AND enable = '0') THEN
				next_state <= S2;
				empieza3 <= '1';
				
			IF clock_up3 = '1' THEN
				P_A <= P_A+1;
				planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				empieza3 <= '0';
				empieza1 <= '1';
			IF clock_up1 = '1' THEN--	WAIT FOR 1000000us;
				P_A <= P_A+1;
				planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
			    empieza1 <= '0';
			    empieza2 <= '1';
            IF clock_up2 = '1' THEN 
                empieza2 <= '0';
               -- P_A <= P_D;
                P_A <= P_A+1;
                planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				next_state <= S1;
				PUERTA_ORDEN <= '1';
			END IF;		
		END IF;
	END IF;	
	
ELSIF (P_A-P_D=1 AND enable = '0') THEN
				next_state <= S3;
				empieza3 <= '1';
				
			IF clock_up3 = '1' THEN--    WAIT FOR 3000000us;
			--	P_A <= P_D;
				P_A <= P_A-1;
				planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				next_state <= S1;
				PUERTA_ORDEN <= '1';
				empieza3 <= '0';
			END IF;
			
ELSIF (P_A-P_D=2 AND enable = '0') THEN
				next_state <= S3;
				empieza3 <= '1';
				
		    IF clock_up3 = '1' THEN         --		WAIT FOR 3000000us;
				P_A <= P_A-1;
				planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				empieza3 <= '0';
				empieza1 <= '1';
			IF clock_up1 = '1' THEN--	WAIT FOR 1000000us;
             --   P_A <= P_D;
                P_A <= P_A-1;
                planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				next_state <= S1;
				PUERTA_ORDEN <= '1';
				empieza1 <= '0';
			END IF;
	   END IF;
	   
ELSIF (P_A-P_D=3 AND enable = '0') THEN
				next_state <= S3;
				empieza3 <= '1';
				
		IF clock_up3 = '1' THEN--		WAIT FOR 3000000us;
				P_A <= P_A-1;
				planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				empieza3 <= '0';
				empieza1 <= '1';
		IF clock_up1 = '1' THEN--		WAIT FOR 1000000us;
				P_A <= P_A-1;
				planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				empieza1 <= '0';
				empieza2 <= '1';
        IF clock_up2 = '1' THEN--        WAIT FOR 1000000us;
            --    P_A <= P_D;
                P_A <= P_A-1;
                planta_act_sal <= STD_LOGIC_VECTOR(TO_UNSIGNED(P_A, planta_destino'length));
				next_state <= S1;
				PUERTA_ORDEN <= '1';
				empieza2 <= '0';
			END IF;
			 END IF;
			     END IF;
END IF;
END IF;
END IF;

END PROCESS;




TRATAMIENTO_PUERTA: PROCESS(clock, P_D, state, PUERTA_ORDEN)
BEGIN
--CASE (state) IS
--	WHEN S1 =>
	IF rising_edge (clock) THEN
    IF state=S1 THEN	
	IF (P_D=1 OR P_D=2 OR P_D=3 OR P_D=4) THEN
    PUERTA_ORDEN <= '0';
END IF; 
END IF;
END IF;
--END CASE;
puerta_ordenn <= PUERTA_ORDEN;   ---asignar la senial a la salida, no puedo asignar la salida en los dos process, que sale error de implementacion
END PROCESS;

--puerta_ordenn <= PUERTA_ORDEN;   ---asignar la senial a la salida, no puedo asignar la salida en los dos process, que sale error de implementacion

Estado_del_motor: PROCESS (clock, state)
	BEGIN
  --  motor_out <= "00" WHEN state=S1 ELSE
   --              "01" WHEN state=S2 ELSE
     --            "10" WHEN state=S3 ;  
     IF rising_edge (clock) THEN  
     IF state=S1 THEN   --SUSTITUIR CONSTRUCCION WHEN/ELSE POR CONSTRUCCION IF THEN PORQUE SOLO LA VERSION VHDL2008 PERMITE LA CONSTRUCCION WHEN
         motor_out <= "00";
     ELSIF state=S2 THEN
        motor_out <= "01";
     ELSIF state=S3 THEN
         motor_out <= "10";
     END IF;     
     END IF;
	END PROCESS;

end Behavioral;
