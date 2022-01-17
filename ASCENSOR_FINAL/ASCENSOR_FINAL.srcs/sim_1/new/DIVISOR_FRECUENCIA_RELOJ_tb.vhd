library ieee;
use ieee.std_logic_1164.all;

entity DIVISOR_FRECUENCIA_RELOJ_tb is
--  Port ( );
end entity;

architecture behavioral of DIVISOR_FRECUENCIA_RELOJ_tb is

component DIVISOR_FRECUENCIA_RELOJ
    port
    (
        CLK_100MHz : in  std_logic;
        RESET      : in  std_logic;
        CLK_100Hz  : out std_logic
    );
end component;

    signal clk_100MHz : std_logic := '0';
    signal reset      : std_logic := '0';
    signal clk_100Hz  : std_logic;
    constant K        : time := 10 ns;

begin

    uut: DIVISOR_FRECUENCIA_RELOJ port map
    (
        CLK_100MHz => clk_100MHz,
        RESET      => reset,
        CLK_100Hz  => clk_100Hz
    );

    clk_process: process
    begin
        clk <= '0';
        wait for K;
        clk <= '1';
        wait for k;
    end process;

    stim_proc: process
    begin
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait;
    end process;

end architecture behavioral;