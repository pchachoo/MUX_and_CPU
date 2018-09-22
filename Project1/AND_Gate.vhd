library ieee;
use ieee.std_logic_1164.all;

entity AND_Gate is
	port(
			AndInput1: in std_logic;
			AndInput2: in std_logic;
			AndInput3: in std_logic;
			AndInput4: in std_logic;
			AndOutput: out std_logic);
			
end AND_Gate;

architecture Structural of AND_Gate is
begin
	AndOutput <= (AndInput1 AND AndInput2 AND AndInput3 AND AndInput4);
	
end Structural;

