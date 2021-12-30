
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity clock_div_1Hz is
    Generic (   frec2: integer:=500000  );
             
    Port ( clock : in STD_LOGIC;
           clock_200Hz: out STD_LOGIC);
end clock_div_1Hz;

architecture Behavioral of clock_div_1Hz is
signal clk_sig2: std_logic:= '0';

begin
 
  RELOJ_200HZ: process (clock)
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
  clock_200Hz<=clk_sig2;


end Behavioral;