-- Sincronizador

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sincronizador is
    port (
        clk      : in  std_logic;
        sync_in  : in  std_logic;
        sync_out : out std_logic
    );
end sincronizador;

architecture Behavioral of sincronizador is

    signal sreg : std_logic_vector(1 downto 0);

begin

    process (Cclk)
    begin
        if rising_edge(clk) then
            sync_out <= sreg(1);
            sreg <= sreg(0) & sync_in;
        end if;
    end process;

end Behavioral;