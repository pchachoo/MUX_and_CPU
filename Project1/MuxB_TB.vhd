
library ieee;
use ieee.std_logic_1164.all;

entity MuxB_TB is
end MuxB_TB;

architecture testbench of MuxB_TB is
	component mux8b
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
	end component;
	
	signal input1s : std_logic_vector(7 downto 0);
	signal input2s : std_logic_vector(7 downto 0);
	signal input3s : std_logic_vector(7 downto 0);
	signal input4s : std_logic_vector(7 downto 0);
	signal input5s : std_logic_vector(7 downto 0);
	signal input6s : std_logic_vector(7 downto 0);
	signal input7s : std_logic_vector(7 downto 0);
	signal selectors : std_logic_vector(2 downto 0);
	signal outputs : std_logic_vector(7 downto 0);
	
	begin --testbench
		inst1 : mux8b port map (
			input1 => input1s,
			input2 => input2s,
			input3 => input3s,
			input4 => input4s,
			input5 => input5s,
			input6 => input6s,
			input7 => input7s,
			selector => selectors,
			output => outputs);
	
	
	testprocess : process
	begin
		input1s <= "00000000";
		input2s <= "00000001";
		input3s <= "00000010";
		input4s <= "00000011";
		input5s <= "00000100";
		input6s <= "00000101";
		input7s <= "00000110";
		selectors <= "001"; --select input 2
		wait for 50ns;
		
		input1s <= "00000000";
		input2s <= "00000001";
		input3s <= "00000010";
		input4s <= "00000011";
		input5s <= "00000100";
		input6s <= "00000101";
		input7s <= "00000110";
		selectors <= "111"; --select invalid
		wait for 50ns;
		
		input1s <= "00000000";
		input2s <= "00000001";
		input3s <= "00000010";
		input4s <= "00000011";
		input5s <= "00010100";
		input6s <= "00000101";
		input7s <= "00000110";
		selectors <= "100"; --select input 5
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		selectors <= "000"; --select input 1
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		selectors <= "001"; --select input 2
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		selectors <= "010"; --select input 3
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		selectors <= "011"; --select input 4
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		selectors <= "100"; --select input 5
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		selectors <= "101"; --select input 6
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		selectors <= "110"; --select input 7
		wait for 50ns;
		
		
	end process;
	
end testbench;