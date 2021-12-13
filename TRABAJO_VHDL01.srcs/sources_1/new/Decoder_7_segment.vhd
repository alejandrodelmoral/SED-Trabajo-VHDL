----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/13 14:54:12
-- Design Name: 
-- Module Name: Decoder_7_segment - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder_7_segment is
    Port(CLK:in std_logic;
        S1,S2,S3,S4,S5,S6:in std_logic_vector(3 downto 0);
        code:out std_logic_vector(2 downto 0);
        segment:out std_logic_vector(6 downto 0));
    
end entity;


architecture Behavioral of Decoder_7_segment is
signal decode: integer range 0 to 5 := 0;
signal data:std_logic_vector(3 DOWNTO 0);
begin

PRO1:process (CLK)
begin
    if CLK'event and CLK ='1' then
        decode<=decode+1;
        case decode is
            when 0 =>code<="000";segment<=S1;
            when 1 =>code<="001";segment<=S2;
            when 2 =>code<="010";segment<=S3;
            when 3 =>code<="011";segment<=S4;
            when 4 =>code<="100";segment<=S5;
            when 5 =>code<="101";segment<=S6;decode<=0;
            when others =>NULL;
            end case;
            end if;
            end process;
PRO2:process(CLK)
begin 
    case data is
    when "0000" => segment<= "1111110" ;
    when "0001" => segment<= "0110000" ;
    when "0010" => segment<= "1101101" ; 
    when "0011" => segment<= "1111001" ;
    when "0100" => segment<= "0110011" ; 
    when "0101" => segment<= "1011011" ;
    when "0110" => segment<= "1011111" ; 
    when "0111" => segment<= "1110000" ;
    when "1000" => segment<= "1111111" ;
    when "1001" => segment<= "1111011" ;
    when others=>   segment<= "0000000" ;  
   end case;
   end process;
   end Behavioral;
