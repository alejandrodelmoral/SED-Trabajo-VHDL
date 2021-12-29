----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/29 15:45:57
-- Design Name: 
-- Module Name: Motor - Behavioral
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

entity Motor is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           SENSOR_MOTOR : in STD_LOGIC_VECTOR (1 downto 0);
           LED1 : out STD_LOGIC;
           LED2 : out STD_LOGIC);
end Motor;

architecture Behavioral of Motor is

begin

motorrr: PROCESS (clock, SENSOR_MOTOR)
		BEGIN
    IF rising_edge (clock) THEN
      
	IF SENSOR_MOTOR = "00" THEN
	       LED1 <= '0';
	       LED2 <= '0';
	ELSIF SENSOR_MOTOR = "01" THEN     
	       LED1 <= '0';
	       LED2 <= '1';
	ELSIF SENSOR_MOTOR = "10" THEN
	       LED1 <= '1';
	       LED2 <= '0';
END IF;
	END IF;
END PROCESS;

end Behavioral;
