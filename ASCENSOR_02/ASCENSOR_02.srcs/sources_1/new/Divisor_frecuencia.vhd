library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Divisor_frecuencia is
    generic
    (
        frec  : integer := 100000000;
        frec2 : integer := 500000
    );

    port
    (
        clock       : in  std_logic;
        clock_1Hz   : out std_logic;
        clock_200Hz : out std_logic
    );
end Divisor_frecuencia;

architecture Behavioral of Divisor_frecuencia is
    signal clk_sig  : std_logic := '0';
    signal clk_sig2 : std_logic := '0';
begin
    RELOJ_1HZ: process (clock)
        variable cnt : integer;
    begin
        if clock'event and clock = '1' then
            if cnt = frec then
                cnt :=0 ;
                clk_sig <= not clk_sig;
            else
                cnt := cnt + 1;
            end if;
        end if;
    end process;
    clock_1Hz<=clk_sig;

    RELOJ_200HZ: process (clock)
        variable cnt1 : integer;
    begin
        if clock'event and clock = '1' then
            if cnt1 = frec2 then
                cnt1 := 0;
                clk_sig2 <= not clk_sig2;
            else
                cnt1 := cnt1 + 1;
            end if;
        end if;
    end process;
    clock_200Hz<=clk_sig2;

end architecture Behavioral;