
library ieee;
use ieee.std_logic_1164.all;


entity TOP_ASCENSOR_tb is
end TOP_ASCENSOR_tb;

architecture Behavioral of TOP_ASCENSOR_tb is

 component TOP_ASCENSOR
    Port ( 
            CLK : in std_logic;
            RESET: in std_logic;
            PISO_DESTINO : in std_logic_vector (3 downto 0);
            PUERTA_ABIERTA : out std_logic_vector (1 downto 0);
            DISPLAY_NUMERO : out std_logic_vector (6 downto 0);
            DISPLAY_SELECT : out std_logic_vector (7 downto 0);
            MOTOR_PUERTA : out std_logic_vector (1 downto 0)
      );
    end component;

    signal CLK: std_logic;
    signal DISPLAY_NUMERO: std_logic_vector(6 downto 0);
    signal DISPLAY_SELECT: std_logic_vector(7 downto 0);
    signal RESET : std_logic := '1';
    signal PISO_DESTINO : std_logic_vector(3 downto 0) := "0000";
    signal PUERTA_ABIERTA: std_logic_vector (1 downto 0);
    signal MOTOR_PUERTA: std_logic_vector(1 downto 0) := "00";
    constant K: time := 10 ns;
begin

 uut: TOP_ASCENSOR port map (
        CLK => CLK,
        RESET => RESET,
        PISO_DESTINO => PISO_DESTINO,
        DISPLAY_NUMERO => DISPLAY_NUMERO,
        DISPLAY_SELECT => DISPLAY_SELECT,
        PUERTA_ABIERTA => PUERTA_ABIERTA,
        MOTOR_PUERTA => MOTOR_PUERTA
        
    );

   stim_proc: process
   begin
        wait for 0.25 * K;
        CLK <= '0';
        wait for 0.25 * K;
        CLK <= '1';
    end process;
    
    stim_proc2: process
        begin
        wait for 4 * K;
        PISO_DESTINO <= "0010";
        wait for 4 * K;
        PISO_DESTINO <= "1000";
        wait for 4 * K;
        PISO_DESTINO <= "0100";
        wait for 4 * K;
        PISO_DESTINO <= "0001";
        wait for 4 * K;
        PISO_DESTINO <= "1000";
        wait for 4 * K;
        PISO_DESTINO <= "0100";
        wait for 4 * K;
        PISO_DESTINO <= "0001";
        wait for 4 * K;
        PISO_DESTINO <= "0001";
        wait for 4 * K;
    end process;
    
    stim_proc3: process
    begin
        wait until DISPLAY_NUMERO = "1001111";
        wait until DISPLAY_NUMERO = "0000110";
        wait until DISPLAY_NUMERO = "0010010";
        wait until DISPLAY_NUMERO = "0000001";
        wait until DISPLAY_NUMERO = "0000110";
        wait until DISPLAY_NUMERO = "0000001";

    

    assert false
    report "Simulation finished."
    severity failure;
end process;

end Behavioral;
