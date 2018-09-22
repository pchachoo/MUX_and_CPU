
-- Project 2 ECE 585
-- Sign extend the Imm16 signal to 32 bits

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity SignExtend is
    port(imm16 : in std_logic_vector(17 downto 0);
         output : out std_logic_vector(31 downto 0));
end SignExtend;

architecture Behavioral of SignExtend is
begin
    
    output <= "00000000000000"&imm16(17 downto 0) when (imm16(17) = '0') else "11111111111111"&imm16(17 downto 0);
             
end Behavioral;
