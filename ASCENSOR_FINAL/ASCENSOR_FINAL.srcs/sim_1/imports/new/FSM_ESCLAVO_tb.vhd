library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FSM_ESCLAVO_tb is
end FSM_ESCLAVO_tb;

architecture Behavioral of FSM_ESCLAVO_tb is

 component FSM_ESCLAVO
     port
    (
        CLK        : in  std_logic;
        RESET      : in  std_logic;
        FLAG_MOTOR : in  std_logic := '0';
        SWITCH     : in  std_logic_vector (3 downto 0);
        DESTINO    : out std_logic_vector (1 downto 0)
    );
    end component;

    signal CLK : std_logic;
    signal RESET : std_logic := '1';
    signal SWITCH : std_logic_vector(3 downto 0) := "0000";
    signal DESTINO: std_logic_vector(1 downto 0);
    signal FLAG_MOTOR : std_logic := '0';
    constant K: time := 10 ns;
begin

 uut: FSM_ESCLAVO port map (
        CLK => CLK,
        RESET => RESET,
        SWITCH => SWITCH,
        DESTINO => DESTINO,
        FLAG_MOTOR => FLAG_MOTOR    
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
        SWITCH <= "1000";
        wait for 1 * K;
        SWITCH <= "0010";
        wait for 1 * K;
        SWITCH <= "0100";
        wait for 1 * K;
        SWITCH <= "1000";
        RESET <= '0';
        wait for 1 * K;
        SWITCH <= "0001";
        wait for 1 * K;
        SWITCH <= "1000";
        wait for 1 * K;
        SWITCH <= "0010";
                                                        

    end process;
    
    stim_proc3: process
    begin
    wait until DESTINO = "00";
    wait until DESTINO = "01";
    wait until DESTINO = "10";
    wait until DESTINO = "11";
    wait until DESTINO = "00";
    wait until DESTINO = "00";
    wait until DESTINO = "01";
    wait until DESTINO = "10";
    wait until DESTINO = "11";
    wait until DESTINO = "00";

    assert false
    report "Simulation finished."
    severity failure;
end process;

end Behavioral;
