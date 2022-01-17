library ieee;
use ieee.std_logic_1164.all;

entity DECODIFICADOR_BCD is
    port
    (
        CODIGO  : in  std_logic_vector (1 downto 0);
        LED     : out std_logic_vector (6 downto 0);
        DISPLAY : out std_logic_vector (7 downto 0)
    );
end entity;

architecture behavioral of DECODIFICADOR_BCD is
begin
    case CODIGO is
        when "00"   => 
            LED     <= "0000001";
            DISPLAY <= "11111110"; 
        when "01"   => 
            LED     <= "1001111";
            DISPLAY <= "11111101";
        when "10"   =>
            LED     <= "0010010";
            DISPLAY <= "11111011";
        when "11"   =>
            LED     <= "0000110";
            DISPLAY <= "11110111";
        when others =>
            LED     <= "1111110";
            DISPLAY <= "11111111";
    end case;
end architecture behavioral;