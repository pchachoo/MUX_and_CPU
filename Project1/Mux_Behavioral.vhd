library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity mux8b is
    port(
	input1 : in std_logic_vector(7 downto 0);
	input2 : in std_logic_vector(7 downto 0);
	input3 : in std_logic_vector(7 downto 0);
	input4 : in std_logic_vector(7 downto 0);
	input5 : in std_logic_vector(7 downto 0);
	input6 : in std_logic_vector(7 downto 0);
	input7 : in std_logic_vector(7 downto 0);
	selector : in std_logic_vector(2 downto 0);
        output : out std_logic_vector(7 downto 0)
	);
         
end mux8b;

architecture Behavioral of mux8b is
begin
    process (input1, input2, input3, input4, input5, input6, input7, selector)
    begin
	case selector IS --3 bit select signal implies 8 possible cases plus one default. This Mux uses only 7 cases, so selector '111' is unused.
		when "000" =>  -- case 1
			output <= input1;
		when "001" =>  -- case 2
			output <= input2;
		when "010" =>  -- case 3
			output <= input3;
		when "011" =>  -- case 4
			output <= input4;
		when "100" =>  -- case 5
            		output <= input5;
		when "101" =>  -- case 6
			output <= input6;
		when "110" =>  -- case 7
			output <= input7;    	    	  		
		when others => -- case 0 - default
			output <= "UUUUUUUU"; -- undefined
	end case;
    end process;
end Behavioral;
