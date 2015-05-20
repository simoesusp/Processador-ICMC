library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
ENTITY debounce IS
	PORT(pb, clock_100Hz : IN	STD_LOGIC;
		 pb_debounced	: OUT	STD_LOGIC);
END debounce;

ARCHITECTURE a OF debounce IS
	SIGNAL SHIFT_PB : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

-- Debounce Button: Filters out mechanical switch bounce for around 40Ms.
-- Debounce clock should be approximately 10ms
process 
begin
  wait until (clock_100Hz'EVENT) AND (clock_100Hz = '1');
  	SHIFT_PB(2 Downto 0) <= SHIFT_PB(3 Downto 1);
  	SHIFT_PB(3) <=  PB;
  	If SHIFT_PB(3 Downto 0)="0000" THEN
   	 PB_DEBOUNCED <= '0';
  	ELSE 
   	 PB_DEBOUNCED <= '1';
  	End if;
end process;
end a;