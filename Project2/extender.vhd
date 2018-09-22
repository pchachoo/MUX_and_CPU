
-- Project 2 ECE 585
-- Extender used to extend the Imm16 signal to a 32-bit signal

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity extender is
    port(imm16 : in std_logic_vector(15 downto 0);
         ExtOp : in std_logic;
         output : out std_logic_vector(31 downto 0));
end extender;

architecture Behavioral of extender is
begin
    
	 -- we signe or not depending on the value of ExtOp
    output <= "0000000000000000"&imm16(15 downto 0) when (ExtOp = '0' OR (ExtOp = '1' AND imm16(15) = '0')) else "1111111111111111"&imm16(15 downto 0);
             
end Behavioral;