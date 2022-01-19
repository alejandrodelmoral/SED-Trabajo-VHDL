library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FSM_MASTER_tb is
end FSM_MASTER_tb;

architecture Behavioral of FSM_MASTER_tb is

 component FSM_MASTER
     port
    (
        CLK         : in  std_logic;                            -- Reloj
        RESET       : in  std_logic;                            -- Reset
        DESTINO     : in  std_logic_vector (1 downto 0);        -- Planta destino
        DESTINO_OUT : out std_logic_vector (1 downto 0);        -- Planta destino salida
        PUERTA      : out std_logic_vector (1 downto 0);        -- Estado de la PUERTA, abierta (01) o cerrada (10)
        MOTOR       : out std_logic_vector (1 downto 0)        -- Estado del MOTOR, en marcha (01 (subiendo) | 10 (bajando)) o parado (00)
                       
    );
    end component;

    signal CLK: std_logic;
    signal DESTINO_OUT: std_logic_vector(1 downto 0);
    signal RESET : std_logic := '1';
    signal DESTINO : std_logic_vector(1 downto 0) := "00";
    signal PUERTA: std_logic_vector (1 downto 0);
    signal MOTOR: std_logic_vector(1 downto 0) := "00";
    constant K: time := 1000000000ns;
begin

 uut: FSM_MASTER port map (
        CLK => CLK,
        RESET => RESET,
        DESTINO => DESTINO,
        DESTINO_OUT => DESTINO_OUT,
        PUERTA => PUERTA,
        MOTOR => MOTOR
        
    );
   stim_proc: process
   begin
        wait for 0.5 * K;
        CLK <= '0';
        wait for 0.5 * K;
        CLK <= '1';
    end process;
    
    stim_proc2: process
    begin
        wait for 1 * K;
        DESTINO <= "11";
        wait for 1 * K;
        DESTINO <= "01";
        wait for 1 * K;
        DESTINO <= "10";
        wait for 1 * K;
        DESTINO <= "00";
        wait for 2 * K;
        DESTINO <= "10";
        wait for 1 * K;
        DESTINO <= "11";
        wait for 5 * K;
        DESTINO <= "00";
        wait for 7 * K;
        DESTINO <= "01";
    end process;
    
    stim_proc3: process
    begin
    wait until DESTINO_OUT = "10";
    wait until DESTINO_OUT = "00";
    wait until DESTINO_OUT = "11";
    wait until DESTINO_OUT = "00";
    wait until DESTINO_OUT = "11";
    wait until DESTINO_OUT = "01";
    RESET <= '0';
    wait until DESTINO_OUT = "11";
    wait until DESTINO_OUT = "10";
    wait until DESTINO_OUT = "00";
    wait until DESTINO_OUT = "11";

    

    assert false
    report "Simulation finished."
    severity failure;
end process;
end Behavioral;