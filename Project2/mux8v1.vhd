
-- Project 2 ECE 585
-- Multiplexer 8 to 1 used for the ALU

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity mux8v1 is

    port(control : in std_logic_vector(2 downto 0);
         output : out std_logic);
         
end mux8v1;

architecture Behavioral of mux8v1 is
begin
    process (control)
    begin
	case control IS
		when "000" => -- ALUAND
			output <= '0';
		when "001" => -- ALUNOT
			output <= '0';
		when "010" => -- ALUADD
			output <= '0';
		when "011" => -- ALUSLT
			output <= '1';
		when "100" => -- ALUSUB
        output <= '1';
		when "101" => -- ALUXOR
			output <= '0';
		when "110" => -- ALUSLL
			output <= '0';    	 
		when "111" => -- ALUSRA
			output <= '0';     	  		
		when others =>
			output <= '0';
	end case;
    end process;
end Behavioral;
