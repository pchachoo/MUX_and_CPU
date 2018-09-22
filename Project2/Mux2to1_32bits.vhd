
-- Project 2 ECE 585
-- Multiplexer 2 to 1 for 32-bit signals

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Mux2to1_32bits is
    port(dataA : in std_logic_vector(31 downto 0);
	 dataB : in std_logic_vector(31 downto 0);
         sel : in std_logic;
         output : out std_logic_vector(31 downto 0) := "00000000000000000000000000000000");
end Mux2to1_32bits;

architecture Behavioral of Mux2to1_32bits is
begin
    
    output <= dataA(31 downto 0) when (sel = '0') else dataB(31 downto 0);

end Behavioral;
