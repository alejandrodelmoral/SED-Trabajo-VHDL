library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity top is
    port
    (
        code    : in  std_logic_vector(3 downto 0);
        digsel  : in  std_logic_vector(3 downto 0);
        AN : out std_logic_vector(3 downto 0); -- Digcontrol
        segment : out std_logic_vector(6 downto 0) -- Segmentos display
     );
end top;

architecture structural of top is
    component decoder
    port
    (
        code : in  std_logic_vector(3 downto 0);
        led  : out std_logic_vector(6 downto 0)
    );
    end component;
    
begin
    Inst_decoder: decoder port map
    (
        code => code,
        led => segment
    );
    AN <= not digsel;
    
end structural;