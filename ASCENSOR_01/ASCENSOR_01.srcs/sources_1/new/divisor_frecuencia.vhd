----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/29 13:03:34
-- Design Name: 
-- Module Name: divisor_frecuencia - Behavioral
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

entity divisor_frecuencia is
    Generic (frecuencia1: integer:=100000000;
            -- frecuencia2: integer:=500000 
             );
             
    Port ( clk : in STD_LOGIC;
           reset:in STD_LOGIC;
           clk_1Hz : out STD_LOGIC;
           clk_200Hz: out STD_LOGIC);
end divisor_frecuencia;

architecture Behavioral of divisor_frecuencia is

signal clk_sig : std_logic:= '0';
--signal clk_sig2: std_logic:= '0';

begin

 RELOJ_1HZ: process (clk,reset)
  variable contador:integer;
  begin

		 if(reset='1') then
		 
            contador:= 0;
            clk_sig<='0';
         elsif rising_edge(clk) 
          then
        if (contador = frecuencia1)   then
            contador := 0;
            clk_sig<=not (clk_sig);
            else
				contador:=contador+1;
			end if;
		end if;
  end process;
  clk_1Hz<=clk_sig;
  
  
 -- RELOJ_200HZ: process (clk)
  --variable contador1:integer;
  --begin

	 --if(reset='1') then
		 
            --contador1:= 0;
           -- clk_sig2<='0';
         --elsif rising_edge(clk) 
          --then
        --if (contador1 = frecuencia2)   then
            --contador1 := 0;
           -- clk_sig2<=not (clk_sig2);
			--else
				--contador1:=contador1+1;
			--end if;
		--end if;
  --end process;
  --clk_200Hz<=clk_sig2;


end Behavioral;
