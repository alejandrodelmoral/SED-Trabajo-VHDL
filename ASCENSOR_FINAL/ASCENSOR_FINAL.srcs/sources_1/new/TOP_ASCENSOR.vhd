library ieee;
use ieee.std_logic_1164.all;

entity TOP_ASCENSOR is
    port
        ( 
            CLK            : in  std_logic;
            RESET          : in  std_logic;
            PISO_DESTINO   : in  std_logic_vector (3 downto 0);
            PUERTA_ABIERTA : out std_logic_vector (1 downto 0);
            DISPLAY_NUMERO : out std_logic_vector (6 downto 0);
            DISPLAY_SELECT : out std_logic_vector (7 downto 0);
            MOTOR_PUERTA   : out std_logic_vector (1 downto 0)
     );
end entity;

architecture structural of TOP_ASCENSOR is
    signal clk_sinc    : std_logic;
    signal piso_actual : std_logic_vector (1 downto 0);
    signal piso_d      : std_logic_vector (1 downto 0);
    signal motor       : std_logic;

component FSM_MASTER is
    port
    (
        CLK         : in  std_logic;
        RESET       : in  std_logic;
        DESTINO     : in  std_logic_vector (1 downto 0);
        DESTINO_OUT : out std_logic_vector (1 downto 0);
        PUERTA      : out std_logic_vector (1 downto 0);
        MOTOR       : out std_logic_vector (1 downto 0);
        FLAG_MOTOR  : out std_logic
    );
end component;

component FSM_ESCLAVO is
    port
    (
        CLK        : in  std_logic;
        RESET      : in  std_logic;
        FLAG_MOTOR : in  std_logic := '0';
        SWITCH     : in  std_logic_vector (3 downto 0);
        DESTINO    : out std_logic_vector (1 downto 0)
    );
end component;
          
component DIVISOR_FRECUENCIA_RELOJ is
    generic
    (
        FREC : integer := 100000000
    );
    port
    (
        CLK_100MHz : in  std_logic;
        RESET      : in  std_logic;
        CLK_100Hz  : out std_logic
    ); 
end component;
     
component DECODIFICADOR_BCD is
    port
    (
        CODIGO  : in  std_logic_vector (1 downto 0);    -- Codigo
        LED     : out std_logic_vector (6 downto 0);    -- Muestra numero
        DISPLAY : out std_logic_vector (7 downto 0)     -- Muestra por pantalla
    );
end component;
      
begin
    inst_FSM_MASTER: FSM_MASTER
        port map
        (
            CLK         => clk_sinc,
            RESET       => RESET,
            DESTINO     => piso_d,
            DESTINO_OUT => piso_actual,
            PUERTA      => PUERTA_ABIERTA,
            MOTOR       => MOTOR_PUERTA,
            FLAG_MOTOR  => motor
        );

    inst_FSM_ESCLAVO: FSM_ESCLAVO
        port map
        (
            CLK        => CLK,
            RESET      => RESET,
            SWITCH     => PISO_DESTINO,
            DESTINO    => piso_d,
            FLAG_MOTOR => motor
        );

    inst_DIVISOR_FRECUENCIA_RELOJ: DIVISOR_FRECUENCIA_RELOJ
        port map
        (
            CLK_100MHz => CLK,
            RESET      => RESET,
            CLK_100Hz  => clk_sinc
        );

    inst_DECODIFICADOR_BCD: DECODIFICADOR_BCD
        port map
        (
            LED     => DISPLAY_NUMERO,
            CODIGO  => piso_actual,
            DISPLAY => DISPLAY_SELECT
        );
end architecture structural;