-- Detector de flancos

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detector_flanco is
    port (
        clk      : in  std_logic;
        edge_in  : in  std_logic;
        edge_out : out std_logic
    );
end detector_flanco;

architecture Behavioral of detector_flanco is

    signal sreg : std_logic_vector(2 downto 0);

begin

    process (clk)
    begin
        if rising_edge(clk) then
            sreg <= sreg(1 downto 0) & edge_in;
        end if;
    end process;

    with sreg select
 	edge_out <= '1' when "100",
        '0' when others;

end Behavioral;