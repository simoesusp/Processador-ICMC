library ieee;
use ieee.std_LOGIC_1164.all;
use ieee.std_LOGIC_ARITH.all;
use ieee.std_LOGIC_unsigned.all;

entity testeabc is
	port( clk			: in	std_logic;
			reset			: in	std_logic;
			breakIn		: in  std_logic;
			mudouClock	: in  std_logic;
			breakOut 	: out std_logic
		);
end testeabc;

ARCHITECTURE ab of testeabc is

begin

process(clk, reset)

	variable estadoAnterior : std_logic;
	variable estado			: std_logic_vector(3 downto 0);
	
begin

	if(reset = '1') then
		estadoAnterior := '0';
		estado := x"0";
	elsif(clk'event and clk = '1') then
	
		if(estado = x"0") then
			if(breakIn = not estadoAnterior) then
				breakOut <= '1';
			end if;

			if(mudouClock = '0') then -- mudouClock = 0 -> clock manual
				estado := x"1";
			end if;	
				
		elsif (estado = x"1")	then
			if(mudouClock = '1') then
				estadoAnterior := breakIn;
				estado := x"0";
				breakOut <= '0';
			end if;	
			
		end if;
		
	end if;
	
end process;

end ab;
