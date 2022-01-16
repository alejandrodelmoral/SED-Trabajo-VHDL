
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity TOP is
    Port ( clk : in STD_LOGIC;
           P1 : in STD_LOGIC;
           P2 : in STD_LOGIC;
           P3 : in STD_LOGIC;
           P4 : in STD_LOGIC;
           reset : in STD_LOGIC;
           motor_LED1 : out STD_LOGIC;
           motor_LED2 : out STD_LOGIC;
           puerta : out STD_LOGIC;
           DISPLAY_SELEC : out STD_LOGIC_VECTOR (7 downto 0);
           DISPLAY_NUMER : out STD_LOGIC_VECTOR (6 downto 0));
end TOP;

architecture Behavioral of TOP is

COMPONENT Divisor_frecuencia
    PORT(
        clock: IN STD_LOGIC;
        clock_1Hz : OUT STD_LOGIC;
        clock_200Hz: OUT STD_LOGIC);
    END COMPONENT;




COMPONENT Decoder1 
	PORT(
	clock, Decodificador1_boton1, Decodificador1_boton2, Decodificador1_boton3, Decodificador1_boton4: IN STD_LOGIC;
	Decoder_P_D_1: OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
);
		END COMPONENT;
		
COMPONENT Decoder2
	PORT(
	clock: IN STD_LOGIC;
	Decoder_P_A_2: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	Decoder_Pin_Display_2: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
);
		END COMPONENT;

COMPONENT Decoder3
	PORT(
	clock: IN STD_LOGIC;
	Decoder_P_D_3: IN STD_LOGIC_VECTOR (2 DOWNTO 0) ;
	Decoder_Pin_Display_3: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
);
		END COMPONENT;

COMPONENT DOOR 
	PORT(
	orden: IN STD_LOGIC;
	clock_1Hz: IN STD_LOGIC;
	clock: IN STD_LOGIC;
	resultado: OUT STD_LOGIC;
	LED0: OUT STD_LOGIC
);
		END COMPONENT;


COMPONENT MOTOR 
	PORT(
	clock: IN STD_LOGIC;
	SENSOR_MOTOR: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	LED1: OUT STD_LOGIC;
    LED2: OUT STD_LOGIC
);
		END COMPONENT;

COMPONENT contador_tiempo 
    Port ( 
           start1: in STD_LOGIC;
           start2: in STD_LOGIC;
           start3: in STD_LOGIC;
           clock_1Hz: in STD_LOGIC;
           tiempo_1s : out STD_LOGIC;
           tiempo_2s : out STD_LOGIC;
           tiempo_3s : out STD_LOGIC);
end COMPONENT;


COMPONENT ASCEN
	PORT(
	planta_destino: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    clock: IN STD_LOGIC;
    enable: IN STD_LOGIC;
    RST: IN STD_LOGIC;
    clock_up1: in STD_LOGIC;
    clock_up2: in STD_LOGIC;
    clock_up3: in STD_LOGIC;
    motor_out: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    planta_act_sal: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
    puerta_ordenn: OUT STD_LOGIC;
    empieza1: out STD_LOGIC;
    empieza2: out STD_LOGIC;
    empieza3: out STD_LOGIC
);
		END COMPONENT;
		
		
COMPONENT Display 
    Port ( clock : in STD_LOGIC;
           display_selection : out STD_LOGIC_VECTOR (7 downto 0);
           display_number : out STD_LOGIC_VECTOR (6 downto 0);
           Display_P_A : in STD_LOGIC_VECTOR (6 downto 0);
           Display_P_D : in STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;
		

------------------------------------ DECLARACION DE SENIALES
SIGNAL P_DEST: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL PUERTA_ORDEN: STD_LOGIC;
SIGNAL ESTADO_PUERTA: STD_LOGIC;
SIGNAL ESTADO_MOTOR: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL PLANTA_ACTUAL: STD_LOGIC_VECTOR (2 DOWNTO 0) := "001";
TYPE state_type IS (S1, S2, S3);
SIGNAL state, next_state: state_type;

SIGNAL DISPLAY1, DISPLAY2: STD_LOGIC_VECTOR (6 DOWNTO 0);
--SIGNAL RELOJ_REF: STD_LOGIC;
SIGNAL RELOJ_1Hz, RELOJ_200Hz: STD_LOGIC;
SIGNAL T1, T2, T3: STD_LOGIC;
SIGNAL E1, E2, E3: STD_LOGIC;

begin



C_D_1Hz: Divisor_frecuencia
    PORT MAP(
        clock => clk,
        clock_1Hz => RELOJ_1Hz,
        clock_200Hz => RELOJ_200Hz
        );

Dec1: Decoder1
	PORT MAP( 
	clock => clk,
	Decodificador1_boton1 => P1,
	Decodificador1_boton2 => P2,
	Decodificador1_boton3 => P3,
    Decodificador1_boton4 => P4,
               Decoder_P_D_1 => P_DEST  );

Dec3: Decoder3
	PORT MAP(
	clock => clk,
	Decoder_P_D_3 => P_DEST,
	Decoder_Pin_Display_3 => DISPLAY1
);


Puertaa: DOOR 
	PORT MAP(	
	clock_1Hz => RELOJ_1Hz,
	clock => clk,
	orden => PUERTA_ORDEN,
	resultado => ESTADO_PUERTA,
    LED0 => puerta
);


Mottor: MOTOR
	PORT MAP(
	clock => clk,
	SENSOR_MOTOR => ESTADO_MOTOR,
	LED1 => motor_LED1,
	LED2 => motor_LED2
);

D_R: Display
        PORT MAP(
        clock => RELOJ_200Hz,
        display_selection => DISPLAY_SELEC,
        display_number => DISPLAY_NUMER,
        Display_P_A => DISPLAY2,
        Display_P_D => DISPLAY1
);

cont: contador_tiempo
    PORT MAP(
        start1 => E1,
        start2 => E2,
        start3 => E3,
        clock_1Hz => RELOJ_1Hz,
        tiempo_1s => T1,
        tiempo_2s => T2,
        tiempo_3s => T3
        );

Dec2: Decoder2
	PORT MAP(
	clock => clk,
	Decoder_Pin_Display_2 => DISPLAY2,
	Decoder_P_A_2 => PLANTA_ACTUAL
);


Inst_Ascensor: ASCEN 
    PORT MAP(
	clock => clk,
	enable => ESTADO_PUERTA,
	RST => reset,
	clock_up1 => T1,
    clock_up2 => T2,
    clock_up3 => T3,
	motor_out => ESTADO_MOTOR,
	puerta_ordenn => PUERTA_ORDEN,
	planta_act_sal => PLANTA_ACTUAL,
	planta_destino => P_DEST,
	empieza1 => E1,
	empieza2 => E2,
	empieza3 => E3
);

end Behavioral;
