
-- Project 2 ECE 585
-- ADD_1BIT_GATE used to perform a 1 bit addition

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity ADD_1BIT_GATE is

    port(a : in std_logic;
         b : in std_logic;
	 cin : in std_logic;
         s : out std_logic;
		 cout : out std_logic);
         
end ADD_1BIT_GATE;

architecture Behavioral of ADD_1BIT_GATE is
begin
    
    cout <= (a AND b) OR (a AND cin) OR (b AND cin);
    s <= a XOR b XOR cin;

end Behavioral;
