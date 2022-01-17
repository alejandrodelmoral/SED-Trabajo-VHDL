library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DIVISOR_FRECUENCIA_RELOJ is
    generic
    (
        FREC : integer := 200000000
    );
    port
    (
        CLK_100MHz : in  std_logic;
        RESET      : in  std_logic;
        CLK_100Hz  : out std_logic
    ); 
end entity;

architecture behavioral of DIVISOR_FRECUENCIA_RELOJ is
    signal CONTADOR : integer := 1;
    signal CLK_TEMP : std_logic;
begin
    process(CLK_100MHz, RESET)
    begin
        if RESET = '0' then
            CONTADOR <= 1;
            CLK_TEMP <= '0';
        elsif rising_edge(CLK_100MHz) then
            CONTADOR <= CONTADOR + 1;
            if CONTADOR = FREC then
                CLK_TEMP <= not CLK_TEMP;
                CONTADOR <= 1;
            end if;
        end if;
        CLK_100Hz <= CLK_TEMP;
     end process;
end architecture behavioral;