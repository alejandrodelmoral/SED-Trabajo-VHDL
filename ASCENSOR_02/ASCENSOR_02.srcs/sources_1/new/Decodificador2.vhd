library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder2 is
    port
    (
        clock                 : in  std_logic;                          -- Reloj
        Decoder_P_A_2         : in  std_logic_vector (2 downto 0);      -- ?
        Decoder_Pin_Display_2 : out std_logic_vector (6 downto 0)       -- ?
    );
end Decoder2;

architecture Behavioral of Decoder2 is
begin
    DECODIFICADOR2: process (clock, Decoder_P_A_2)
    begin
        if (clock'event and clock = '1') then       -- Si hay un flanco ascendente de reloj (Sincrono)
            if Decoder_P_A_2 = "001" then
                Decoder_Pin_Display_2 <= "1001111";
            elsif Decoder_P_A_2 = "010" then
                Decoder_Pin_Display_2 <= "0010010";
            elsif Decoder_P_A_2 = "011" then
                Decoder_Pin_Display_2 <= "0000110";
            elsif Decoder_P_A_2 = "100" then
                Decoder_Pin_Display_2 <= "1001100";
            end if;
        end if;
    end process;
end architecture Behavioral;
