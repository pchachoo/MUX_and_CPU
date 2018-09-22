library ieee;
use ieee.std_logic_1164.all;

entity OR_Gate is
	port(
			OrInput1: in std_logic;
			OrInput2: in std_logic;
			OrInput3: in std_logic;
			OrInput4: in std_logic;
			OrInput5: in std_logic;
			OrInput6: in std_logic;
			OrInput7: in std_logic;
			OrInput8: in std_logic;
			OrOutput: out std_logic);
			
end OR_Gate;

architecture Structural of OR_Gate is
begin
	OrOutput <= (OrInput1 OR OrInput2 OR OrInput3 OR OrInput4 OR OrInput5 OR OrInput6 OR OrInput7 OR OrInput8);
	
end Structural;


