----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/13 14:08:19
-- Design Name: 
-- Module Name: Contador - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Contador is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           seconds : out STD_LOGIC_VECTOR (5 downto 0);
           minutes : out STD_LOGIC_VECTOR (5 downto 0));
end Contador;

architecture Behavioral of Contador is
signal contar_sec : STD_LOGIC_VECTOR (5 downto 0);
signal contar_min : STD_LOGIC_VECTOR (5 downto 0);
begin

process (reset,clk)
begin     
if reset='0'    then    
contar_sec (5 downto 0) <="000000";
contar_min (5 downto 0) <="000000";   

else
    if clk'event and clk = '1' then 
        if contar_sec="111011" then 
           contar_sec<="000000";
           if contar_min="111011" then
              contar_min<="000000";
           else 
           contar_min<=contar_min+1;
           end if;
        else 
        contar_sec<=contar_sec+1;
        end if;
     else
     null;
     end if;
 end if;
 end process;
 seconds (5 downto 0) <=contar_sec(5 downto 0);
 minutes (5 downto 0) <=contar_min(5 downto 0);
 end Behavioral;
              


