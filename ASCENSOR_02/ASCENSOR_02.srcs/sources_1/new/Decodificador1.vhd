library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder1 is
    port
    (
        clock                 : in  std_logic;                          -- Reloh
        Decodificador1_boton1 : in  std_logic;                          -- Pulsador 1
        Decodificador1_boton2 : in  std_logic;                          -- Pulsador 2
        Decodificador1_boton3 : in  std_logic;                          -- Pulsador 3 
        Decodificador1_boton4 : in  std_logic;                          -- Pulsador 4
        Decoder_P_D_1         : out std_logic_vector (2 DOWNTO 0)       -- Decoder PD1 ?
    );
end Decoder1;

architecture Behavioral of Decoder1 is
begin
    DECODIFICADOR1: PROCESS (clock, Decodificador1_boton1, Decodificador1_boton2, Decodificador1_boton3, Decodificador1_boton4)
    BEGIN
        if clock'event and clock = '1' then         -- Si hay un flanco ascendente de reloj (Sincrono)
            if Decodificador1_boton1 = '1' then     -- Si se pulsa el boton numero i, se manda al decodificador_P_D_1 el valor de ese numero en binario
                Decoder_P_D_1 <= "001";
            elsif Decodificador1_boton2 = '1' then
                Decoder_P_D_1 <= "010";
            elsif Decodificador1_boton3 = '1' then
                Decoder_P_D_1 <= "011";
            elsif Decodificador1_boton4 = '1' then
                Decoder_P_D_1 <= "100";
            end if;
        end if;
    end process;
end architecture Behavioral;
