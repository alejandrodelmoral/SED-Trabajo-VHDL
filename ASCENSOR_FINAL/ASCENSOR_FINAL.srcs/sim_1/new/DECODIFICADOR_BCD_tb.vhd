library ieee;
use ieee.std_logic_1164.all;

entity DECODIFICADOR_BCD_tb is
--  Port ( );
end entity;

architecture behavioral of DECODIFICADOR_BCD_tb is

component DECODIFICADOR_BCD
    port
    (
        CODIGO  : in  std_logic_vector (1 downto 0);
        LED     : out std_logic_vector (6 downto 0);
        DISPLAY : out std_logic_vector (7 downto 0)
    );
end component;

    signal codigo  : std_logic_vector (1 downto 0) := "00";
    signal led     : std_logic_vector (6 downto 0) := "0000000";
    signal display : std_logic_vector (7 downto 0) := "00000000";
    constant K     : time := 10 ns;

begin

    uut: DECODIFICADOR_BCD port map
    (
        CODIGO  => codigo,
        LED     => led,
        DISPLAY => display
    );
    
    process
    begin
        wait for K;
        codigo <= "00";
        wait for K;
        codigo <= "01";
        wait for K;
        codigo <= "10";
        wait for K;
        codigo <= "11";
    end process;

    process
    begin
        wait for 10 * K;
  
        assert false
        report "Simulacion finalizada."
        severity failure;
    end process;

end architecture behavioral;
