----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/29 13:02:21
-- Design Name: 
-- Module Name: TOP - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
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
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           B3 : in STD_LOGIC;
           B4 : in STD_LOGIC;   
           reset : in STD_LOGIC;
           motor_LED1 : out STD_LOGIC;
           motor_LED2 : out STD_LOGIC;
           puerta : out STD_LOGIC;
           LED_INDICADOR_LLEGADDA: out STD_LOGIC;
           DISPLAY_SELEC : out STD_LOGIC_VECTOR (7 downto 0);
           DISPLAY_NUMER : out STD_LOGIC_VECTOR (6 downto 0));
end TOP;

architecture Behavioral of TOP is

COMPONENT clock_div_1Hz
    PORT(
        clock: IN STD_LOGIC;
        clock_200Hz: OUT STD_LOGIC);
    END COMPONENT;
    
 COMPONENT Decoder1 
	PORT(
	clock: IN STD_LOGIC;
	boton1: IN STD_LOGIC;
	boton2: IN STD_LOGIC;
	boton3: IN STD_LOGIC;
	boton4: IN STD_LOGIC;
	planta_destino1: OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
);
		END COMPONENT;
		
COMPONENT ASCEN
	PORT(
	       clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           planta_destino : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           planta_actual : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_DEST: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_ACT: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_INDICADOR_DE_LLEGADA:out STD_LOGIC;
           LED0: out STD_LOGIC;
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
);
    END COMPONENT;
COMPONENT Decoder2
	PORT(
	clock: IN STD_LOGIC;
	planta_actual_2: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	pines_display2: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
);
		END COMPONENT;
		
COMPONENT Decoder3
	PORT(
	clock: IN STD_LOGIC;
	planta_destino3: IN STD_LOGIC_VECTOR (2 DOWNTO 0) ;
	pines_display1: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
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
           display_selection : out STD_LOGIC_VECTOR (7 downto 0);
           display_number : out STD_LOGIC_VECTOR (6 downto 0);
           planta_actual_last  : in STD_LOGIC_VECTOR (6 downto 0);
           planta_destino_last  : in STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;

COMPONENT Ascensor
	PORT(
	       clock : in STD_LOGIC;
           RST: in STD_LOGIC;
           planta_destino : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           planta_actual : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_DEST: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           DIS_ACT: out STD_LOGIC_VECTOR (2 DOWNTO 0);
           LED_INDICADOR_DE_LLEGADA:out STD_LOGIC;
           LED0: out STD_LOGIC;
           motor_out : out STD_LOGIC_VECTOR (1 downto 0)
);
  END COMPONENT;
SIGNAL P_DEST: STD_LOGIC_VECTOR (2 DOWNTO 0);
signal RELOJ_200Hz:STD_LOGIC;
SIGNAL ESTADO_MOTOR: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL PLANTA_ACTUAL: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL PLANTA_DESTINO_S: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL PLANTA_ACTUAL_S: STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL DISPLAY1, DISPLAY2: STD_LOGIC_VECTOR (6 DOWNTO 0);

begin

C_D_1Hz: clock_div_1Hz
    PORT MAP(
        clock => clk,
        clock_200Hz => RELOJ_200Hz
        );


Primer_decodificador_1: Decoder1
	PORT MAP( 
	clock => clk,
	boton1 => A1,
	boton2 => A2,
	boton3 => A3,
    boton4 => A4,
    planta_destino1 => PLANTA_ACTUAL  );


Primer_decodificador_2: Decoder1
	PORT MAP( 
	clock => clk,
	boton1 => B1,
	boton2 => B2,
	boton3 => B3,
    boton4 => B4,
    planta_destino1 => P_DEST  );
 Motor_Ascensor: Motor
	PORT MAP(
	clock => clk,
	SENSOR_MOTOR => ESTADO_MOTOR,
	LED1 => motor_LED1,
	LED2 => motor_LED2
);  
Tercer_decodificador: Decoder3
	PORT MAP(
	clock => clk,
	planta_destino3 =>  PLANTA_DESTINO_S,
	pines_display1 => DISPLAY1
);
Segundo_decodificador: Decoder2
	PORT MAP(
	clock => clk,
	pines_display2 => DISPLAY2,
	planta_actual_2 => PLANTA_ACTUAL_S
);

FSM:Ascensor
PORT MAP(
	clock => clk,
	RST => reset,
	motor_out => ESTADO_MOTOR,
	planta_actual => PLANTA_ACTUAL,
	planta_destino => P_DEST,
	DIS_DEST => PLANTA_DESTINO_S,
	DIS_ACT => PLANTA_ACTUAL_S,
	LED_INDICADOR_DE_LLEGADA => LED_INDICADOR_LLEGADDA,
	LED0 => puerta
);

Display_7: Display
        PORT MAP(
        clock => RELOJ_200Hz,
        display_selection => DISPLAY_SELEC,
        display_number => DISPLAY_NUMER,
        planta_actual_last  => DISPLAY2,
        planta_destino_last => DISPLAY1
);
end Behavioral;
