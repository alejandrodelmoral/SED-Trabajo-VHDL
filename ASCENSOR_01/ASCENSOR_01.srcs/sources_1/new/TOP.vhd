
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity TOP is
    Port ( clk : in STD_LOGIC;
           A1 : in STD_LOGIC;
           A2 : in STD_LOGIC;
           A3 : in STD_LOGIC;
           A4 : in STD_LOGIC;
           A5 : in STD_LOGIC;
           A6 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           B3 : in STD_LOGIC;
           B4 : in STD_LOGIC;   
           B5 : in STD_LOGIC;
           B6 : in STD_LOGIC;
           reset : in STD_LOGIC;
           motor_LED1 : out STD_LOGIC;
           motor_LED2 : out STD_LOGIC;
           puerta : out STD_LOGIC;
           LED_INDICADOR_LLEGADDA: out STD_LOGIC;
           DISPLAY_D : out STD_LOGIC_VECTOR (7 downto 0);
           DISPLAY_A : out STD_LOGIC_VECTOR (6 downto 0));
end TOP;

architecture Behavioral of TOP is

COMPONENT clock_div_100Hz
    PORT(
        clock: IN STD_LOGIC;
        clock_100Hz: OUT STD_LOGIC);
    END COMPONENT;
    
 COMPONENT Decoder1 
	PORT(
	clock: IN STD_LOGIC;
	Decodificador1_boton1: IN STD_LOGIC;
	Decodificador1_boton2: IN STD_LOGIC;
	Decodificador1_boton3: IN STD_LOGIC;
	Decodificador1_boton4: IN STD_LOGIC;
	Decodificador1_boton5 : in STD_LOGIC;
    Decodificador1_boton6 : in STD_LOGIC;
	Decodificador1_P_D_1: OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
);
		END COMPONENT;
		
COMPONENT ASCEN
	PORT(
	       clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           ASCENSOR_PLANTA_DESTINO : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           ASCENSOR_TOP_PLANTA_ACTUAL : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DISPLAY_DESTINO: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DISPLAY_ACTUAL: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_INDICADOR_DE_LLEGADA:out STD_LOGIC;
           LED0: out STD_LOGIC;
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
);
    END COMPONENT;
COMPONENT Decoder2
	PORT(
	clock: IN STD_LOGIC;
	Decodificador2_P_A_2: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	Decodificador2_Display_2: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
	Decodificador2_P_D_2 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
    Decodificador2_Display_1 : out STD_LOGIC_VECTOR (6 downto 0)
);
		END COMPONENT;
		

		
COMPONENT Motor 
	PORT(
	clock: IN STD_LOGIC;
	SENSOR_MOTOR: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	LED1: OUT STD_LOGIC;
    LED2: OUT STD_LOGIC
);
		END COMPONENT;
		
COMPONENT Display 
    Port ( clock : in STD_LOGIC;
           Display_destino : out STD_LOGIC_VECTOR (7 downto 0);
           Display_actual : out STD_LOGIC_VECTOR (6 downto 0);
           planta_actual_last  : in STD_LOGIC_VECTOR (6 downto 0);
           planta_destino_last  : in STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;

COMPONENT Ascensor
	PORT(
	       clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           ASCENSOR_PLANTA_DESTINO : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           ASCENSOR_PLANTA_ACTUAL : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DISPLAY_DESTINO: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DISPLAY_ACTUAL: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_INDICADOR_DE_LLEGADA:out STD_LOGIC;
           LED0: out STD_LOGIC;
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
);
  END COMPONENT;
SIGNAL TOP_P_DEST: STD_LOGIC_VECTOR (2 DOWNTO 0);
signal TOP_RELOJ_100Hz:STD_LOGIC;
SIGNAL TOP_ESTADO_MOTOR: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL TOP_PLANTA_ACTUAL: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL TOP_PLANTA_DESTINO_S: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL TOP_PLANTA_ACTUAL_S: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL TOP_DISPLAY1, TOP_DISPLAY2: STD_LOGIC_VECTOR (6 DOWNTO 0);

begin

C_D_1Hz: clock_div_100Hz
    PORT MAP(
        clock => clk,
        clock_100Hz => TOP_RELOJ_100Hz
        );


Primer_decodificador_1: Decoder1
	PORT MAP( 
	clock => clk,
	Decodificador1_boton1 => A1,
	Decodificador1_boton2 => A2,
	Decodificador1_boton3 => A3,
    Decodificador1_boton4 => A4,
    Decodificador1_boton5 => A5,
    Decodificador1_boton6 => A6,
    Decodificador1_P_D_1 => TOP_PLANTA_ACTUAL  );


Primer_decodificador_2: Decoder1
	PORT MAP( 
	clock => clk,
	Decodificador1_boton1 => B1,
	Decodificador1_boton2 => B2,
	Decodificador1_boton3 => B3,
    Decodificador1_boton4 => B4,
    Decodificador1_boton5 => B5,
    Decodificador1_boton6 => B6,
    
    Decodificador1_P_D_1 => TOP_P_DEST  );
 Motor_Ascensor: Motor
	PORT MAP(
	clock => clk,
	SENSOR_MOTOR => TOP_ESTADO_MOTOR,
	LED1 => motor_LED1,
	LED2 => motor_LED2
);  

Segundo_decodificador: Decoder2
	PORT MAP(
	clock => clk,
	Decodificador2_Display_2 => TOP_DISPLAY2,
	Decodificador2_P_A_2 => TOP_PLANTA_ACTUAL_S,
	Decodificador2_P_D_2 =>  TOP_PLANTA_DESTINO_S,
	Decodificador2_Display_1 => TOP_DISPLAY1
);

FSM:Ascensor
PORT MAP(
	clock => clk,
	RST => reset,
	motor_out => TOP_ESTADO_MOTOR,
	ASCENSOR_PLANTA_ACTUAL => TOP_PLANTA_ACTUAL,
	ASCENSOR_PLANTA_DESTINO => TOP_P_DEST,
	DISPLAY_DESTINO => TOP_PLANTA_DESTINO_S,
	DISPLAY_ACTUAL => TOP_PLANTA_ACTUAL_S,
	LED_INDICADOR_DE_LLEGADA => LED_INDICADOR_LLEGADDA,
	LED0 => puerta
);

Display_7: Display
        PORT MAP(
        clock => TOP_RELOJ_100Hz,
        Display_destino => DISPLAY_D,
        Display_actual => DISPLAY_A,
        planta_actual_last  => TOP_DISPLAY2,
        planta_destino_last => TOP_DISPLAY1
);
end Behavioral;