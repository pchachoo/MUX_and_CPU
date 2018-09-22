
-- Project 2 ECE 585
-- This is a 32 bits XOR gate

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity xor_gate is

    port(invert : in std_logic;
         DATAB : in std_logic_vector(31 downto 0);
         DATAB2 : out std_logic_vector(31 downto 0));
   
end xor_gate;

architecture Behavioral of xor_gate is
begin
    
    DATAB2(0) <= DATAB(0) XOR invert;
    DATAB2(1) <= DATAB(1) XOR invert;
    DATAB2(2) <= DATAB(2) XOR invert;
    DATAB2(3) <= DATAB(3) XOR invert;
    DATAB2(4) <= DATAB(4) XOR invert;
    DATAB2(5) <= DATAB(5) XOR invert;
    DATAB2(6) <= DATAB(6) XOR invert;
    DATAB2(7) <= DATAB(7) XOR invert;
    DATAB2(8) <= DATAB(8) XOR invert;
    DATAB2(9) <= DATAB(9) XOR invert;
    DATAB2(10) <= DATAB(10) XOR invert;
    DATAB2(11) <= DATAB(11) XOR invert;
    DATAB2(12) <= DATAB(12) XOR invert;
    DATAB2(13) <= DATAB(13) XOR invert;
    DATAB2(14) <= DATAB(14) XOR invert;
    DATAB2(15) <= DATAB(15) XOR invert;
    DATAB2(16) <= DATAB(16) XOR invert;
    DATAB2(17) <= DATAB(17) XOR invert;
    DATAB2(18) <= DATAB(18) XOR invert;
    DATAB2(19) <= DATAB(19) XOR invert;
    DATAB2(20) <= DATAB(20) XOR invert;
    DATAB2(21) <= DATAB(21) XOR invert;
    DATAB2(22) <= DATAB(22) XOR invert;
    DATAB2(23) <= DATAB(23) XOR invert;
    DATAB2(24) <= DATAB(24) XOR invert;
    DATAB2(25) <= DATAB(25) XOR invert;
    DATAB2(26) <= DATAB(26) XOR invert;
    DATAB2(27) <= DATAB(27) XOR invert;
    DATAB2(28) <= DATAB(28) XOR invert;
    DATAB2(29) <= DATAB(29) XOR invert;
    DATAB2(30) <= DATAB(30) XOR invert;
    DATAB2(31) <= DATAB(31) XOR invert;
    
end Behavioral;