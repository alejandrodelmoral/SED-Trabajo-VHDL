-- Divisor de frecuencia

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_frecuencia is
    generic ( 
        frecuencia: integer := 50000
     );

    port ( 
        clk_in  : in   std_logic; -- 100 MHz
        reset   : in   std_logic;
        clk_out : out  std_logic
    );
end divisor_frecuencia;

architecture Behavioral of divisor_frecuencia is

	signal count: integer range 1 to frecuencia;
	signal clk_out_i: std_logic := '0';
	
begin

	divisor_frecuencia: process (clk_in, reset) 
	begin
	   if reset = '0' then
		   count <= 1;
		   clk_out_i <= '0';
	   elsif clk_in'event and clk_in = '1' then
	       if (count = frecuencia) then
		       count <= 1;
		       clk_out_i <= not (clk_out_i);
		   else
		       count <= count + 1;
	       end if;
           end if;
    end process;
	
	clk_out <= clk_out_i ;
	
end Behavioral;