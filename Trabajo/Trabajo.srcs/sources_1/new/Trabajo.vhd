----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/16 19:26:32
-- Design Name: 
-- Module Name: RELOJ_AJEDREZ - Behavioral
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

entity RELOJ_AJEDREZ is
port(
    clk:in std_logic;
    reset:in std_logic;--- 
    stop:in std_logic;
    
    display_segundo_digitos:out std_logic_vector(6 downto 0);
    display_segundo_decenas:out std_logic_vector(6 downto 0);
    display_minutos_digitos:out std_logic_vector(6 downto 0);
    display_minutos_decenas:out std_logic_vector(6 downto 0)
    );
end RELOJ_AJEDREZ;

architecture Behavioral of RELOJ_AJEDREZ is

 
component divisor_frecuencia is
generic(
    reloj_interno_valor:integer:= 450000000;
    divisor_frecuencia_valor:integer:=1
);
port(
    clk:in std_logic;
    clear:in std_logic;---- para el divisor de frecuencia
    divisor_clk:out std_logic
);

end component;

component Contador is
port(
    clk:in std_logic;
    reset:in std_logic;--- 
    stop:in std_logic; ----
    
    display_segundo_digitos:out std_logic_vector(6 downto 0);
    display_segundo_decenas:out std_logic_vector(6 downto 0);
    display_minutos_digitos:out std_logic_vector(6 downto 0);
    display_minutos_decenas:out std_logic_vector(6 downto 0);
    
    segundo_digitos: out std_logic_vector(3 downto 0);
    segundo_decenas: out std_logic_vector(3 downto 0);
    minutos_digitos: out std_logic_vector(3 downto 0);
    minutos_decenas: out std_logic_vector(3 downto 0)
);
end component;

signal w_segundo_digitos: std_logic_vector(3 downto 0);
 signal   w_segundo_decenas:  std_logic_vector(3 downto 0);
 signal   w_minutos_digitos:  std_logic_vector(3 downto 0);
 signal w_minutos_decenas:  std_logic_vector(3 downto 0);
 
 signal w_clk:std_logic;
 signal w_divisor_clk:std_logic;
 signal w_clear:std_logic;
 signal w_reset:std_logic;
 signal w_stop:std_logic;
begin
frecuencia:divisor_frecuencia port map(
    clk=>clk,
    divisor_clk=>w_divisor_clk,
    clear=>w_clear
    


);

display:Contador port map(
    clk=>clk,
    reset=>w_reset,
    stop=>w_stop,
    display_segundo_digitos=>display_segundo_digitos,
    display_segundo_decenas=>display_segundo_decenas,
    display_minutos_digitos=>display_minutos_digitos,
    display_minutos_decenas=>display_minutos_decenas,
    segundo_digitos=>w_segundo_digitos,
    segundo_decenas=>w_segundo_decenas,
    minutos_digitos=>w_minutos_digitos,
    minutos_decenas=>w_minutos_decenas
    
);


end Behavioral;