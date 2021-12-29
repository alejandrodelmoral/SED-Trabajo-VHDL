----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/16 19:37:34
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisor_frecuencia is
generic(
    reloj_interno_valor:integer:= 100000000;
    divisor_frecuencia_valor:integer:=1
);
port(
    clk:in std_logic;
    clear:in std_logic;---- para el divisor de frecuencia
    divisor_clk:out std_logic
);
end divisor_frecuencia;

architecture Behavioral of divisor_frecuencia is
signal s_div_contador:std_logic_vector(31 downto 0);
signal s_div_clk:std_logic;
begin
process(clk,clear)
    begin 
        if(clear='1') then 
        s_div_contador<=x"00000000";
        s_div_clk<='0';
        elsif (clk'event and clk ='1') then
            if (s_div_contador = reloj_interno_valor/divisor_frecuencia_valor/2-1) then
            s_div_contador<=x"00000000";
            s_div_clk<=NOT s_div_clk;
            else
            s_div_contador<=s_div_contador+1;
         end if;
      end if;
    end process;


end Behavioral;


