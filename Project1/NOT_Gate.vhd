library ieee;
use ieee.std_logic_1164.all;

entity NOT_Gate is
	port(
			NotInput: in std_logic;
			NotOutput: out std_logic);
			
end NOT_Gate;

architecture Structural of NOT_Gate is
begin
	NotOutput <= NOT NotInput;
	
end Structural;


