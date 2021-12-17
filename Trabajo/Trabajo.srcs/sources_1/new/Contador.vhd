----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/16 20:04:39
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Contador is
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
end Contador;

architecture Behavioral of Contador is
signal s_segundo_digitos: std_logic_vector(3 downto 0); 
signal s_segundo_decenas: std_logic_vector(3 downto 0);
signal s_minutos_digitos: std_logic_vector(3 downto 0);
signal s_minutos_decenas: std_logic_vector(3 downto 0);

signal d_segundo_digitos: std_logic_vector(6 downto 0); 
signal d_segundo_decenas: std_logic_vector(6 downto 0);
signal d_minutos_digitos: std_logic_vector(6 downto 0);
signal d_minutos_decenas: std_logic_vector(6 downto 0);

signal s_div_clk:std_logic;
begin
process(reset,s_div_clk)
    begin
        if(reset='1') then
        s_segundo_digitos<="0000";
        s_segundo_decenas<="0000";
        s_minutos_digitos<="0000";
        s_minutos_decenas<="0000";
        elsif(s_div_clk'event and s_div_clk='1') then
            if(stop='1')then
        s_segundo_digitos<= s_segundo_digitos;
        s_segundo_decenas<= s_segundo_decenas;
        s_minutos_digitos<= s_minutos_digitos;
        s_minutos_decenas<= s_minutos_decenas;
        
            else
            s_segundo_digitos<=s_segundo_digitos+1;
            if( s_segundo_digitos="1001") then 
             s_segundo_digitos<="0000";
             s_segundo_decenas<= s_segundo_decenas +1;
                if(s_segundo_decenas="0110") then
                s_segundo_decenas<="0000";
                s_minutos_digitos<= s_minutos_digitos+1;
                    if(s_minutos_digitos="1001") then
                     s_minutos_decenas<= s_minutos_decenas+1;
             
     end if;
     end if;
     end if;
     end if;
     end if;
     
        segundo_digitos<= s_segundo_digitos;
        segundo_decenas<= s_segundo_decenas;
        minutos_digitos<= s_minutos_digitos;
        minutos_decenas<= s_minutos_decenas;
          
       if(reset='1') then
       d_segundo_digitos<="1000000";
       else 
            case s_segundo_digitos is 
            when "0000"=>d_segundo_digitos<="1000000";
            when "0001"=>d_segundo_digitos<="1111001";
            when "0010"=>d_segundo_digitos<="0100100";
            when "0011"=>d_segundo_digitos<="0110000";
            when "0100"=>d_segundo_digitos<="0011001";
            when "0101"=>d_segundo_digitos<="0010010";
            when "0110"=>d_segundo_digitos<="0000010";
            when "0111"=>d_segundo_digitos<="1111000";
            when "1000"=>d_segundo_digitos<="0000000";
            when "1001"=>d_segundo_digitos<="0010000";
            when others=>d_segundo_digitos<= "1111111";
            end case;
            end if;
            display_segundo_digitos<=d_segundo_digitos;
        
        if(reset='1') then
       d_segundo_decenas<="1000000";
       else 
            case s_segundo_decenas is 
            when "0000"=>d_segundo_decenas<="1000000";
            when "0001"=>d_segundo_decenas<="1111001";
            when "0010"=>d_segundo_decenas<="0100100";
            when "0011"=>d_segundo_decenas<="0110000";
            when "0100"=>d_segundo_decenas<="0011001";
            when "0101"=>d_segundo_decenas<="0010010";
            when others=>d_segundo_decenas<= "1111111";
            end case;
            end if;
            display_segundo_decenas<=d_segundo_decenas;
            
            if(reset='1') then
       d_minutos_digitos<="1000000";
       else 
            case s_minutos_digitos is 
            when "0000"=>d_minutos_digitos<="1000000";
            when "0001"=>d_minutos_digitos<="1111001";
            when "0010"=>d_minutos_digitos<="0100100";
            when "0011"=>d_minutos_digitos<="0110000";
            when "0100"=>d_minutos_digitos<="0011001";
            when "0101"=>d_minutos_digitos<="0010010";
            when "0110"=>d_minutos_digitos<="0000010";
            when "0111"=>d_minutos_digitos<="1111000";
            when "1000"=>d_minutos_digitos<="0000000";
            when "1001"=>d_minutos_digitos<="0010000";
            when others=>d_minutos_digitos<= "1111111";
            end case;
            end if;
            display_minutos_digitos<=d_minutos_digitos;
            
             if(reset='1') then
       d_minutos_decenas<="1000000";
       else 
            case s_segundo_decenas is 
            when "0000"=>d_minutos_decenas<="1000000";
            when "0001"=>d_minutos_decenas<="1111001";
            when "0010"=>d_minutos_decenas<="0100100";
            when "0011"=>d_minutos_decenas<="0110000";
            when "0100"=>d_minutos_decenas<="0011001";
            when "0101"=>d_minutos_decenas<="0010010";
            when others=>d_minutos_decenas<= "1111111";
            end case;
            end if;
            display_segundo_decenas<=d_segundo_decenas;
            
end process;

end Behavioral;
