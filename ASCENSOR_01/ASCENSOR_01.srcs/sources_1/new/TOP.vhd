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
COMPONENT divisor_frecuencia
    PORT(
        clock: IN STD_LOGIC;
        reset: IN STD_LOGIC;
        clock_1Hz : OUT STD_LOGIC;
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
           planta_actuall : in STD_LOGIC_VECTOR (6 downto 0);
           planta_destinoo : in STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;


begin


end Behavioral;
