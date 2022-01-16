
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity clock_div_100Hz is
    Generic (   frec2: integer:=1000000  );
             
    Port ( clock : in STD_LOGIC;
           clock_100Hz: out STD_LOGIC);
end clock_div_100Hz;

architecture Behavioral of clock_div_100Hz is
signal clk_sig2: std_logic:= '0';

begin
 
  RELOJ_100HZ: process (clock)
  variable cnt1:integer:=0;
  begin

		if clock'event and clock='1' then
			if (cnt1=frec2) then
				cnt1:=0;
				clk_sig2<=not(clk_sig2);
			else
				cnt1:=cnt1+1;
			end if;
		end if;
  end process;
  clock_100Hz<=clk_sig2;


end Behavioral;