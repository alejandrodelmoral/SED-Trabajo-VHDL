library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder3 is
    port
    (
        clock                 : in  std_logic;                          -- Reloj
        Decoder_P_D_3         : in  std_logic_vector (2 downto 0);      -- ?
        Decoder_Pin_Display_3 : out std_logic_vector (6 downto 0)       -- ?
    );
end Decoder3;

architecture Behavioral of Decoder3 is
begin
    DECODIFICADOR3: process (clock, Decoder_P_D_3)  
    begin
        if rising_edge (clock) then     -- Si hay un flanco ascendente de reloj (Sincrono)
            if Decoder_P_D_3 = "001" then
                Decoder_Pin_Display_3 <= "1001111";
            elsif Decoder_P_D_3 = "010" then
                Decoder_Pin_Display_3 <= "0010010";
            elsif Decoder_P_D_3 = "011" then
                Decoder_Pin_Display_3 <= "0000110";
            elsif Decoder_P_D_3 = "100" then
                Decoder_Pin_Display_3 <= "1001100";
            end if;
        end if;
    end process;
end architecture Behavioral;