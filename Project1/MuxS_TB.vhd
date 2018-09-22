library ieee;
use ieee.std_logic_1164.all;

entity MuxS_TB is
end MuxS_TB;

architecture testbench of MuxS_TB is
	component mux8s
	port(
	input0 : in std_logic_vector(7 downto 0);
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
	
	component AND_Gate is
port(
			AndInput1: in std_logic;
			AndInput2: in std_logic;
			AndInput3: in std_logic;
			AndInput4: in std_logic;
			AndOutput: out std_logic
);
end component;

component OR_Gate is
port(
			OrInput1: in std_logic;
			OrInput2: in std_logic;
			OrInput3: in std_logic;
			OrInput4: in std_logic;
			OrInput5: in std_logic;
			OrInput6: in std_logic;
			OrInput7: in std_logic;
			OrInput8: in std_logic;
			OrOutput: out std_logic
);
end component;

component NOT_Gate is
port(
			NotInput: in std_logic;
			NotOutput: out std_logic
);
end component;
	
	signal input1s : std_logic_vector(7 downto 0);
	signal input2s : std_logic_vector(7 downto 0);
	signal input3s : std_logic_vector(7 downto 0);
	signal input4s : std_logic_vector(7 downto 0);
	signal input5s : std_logic_vector(7 downto 0);
	signal input6s : std_logic_vector(7 downto 0);
	signal input7s : std_logic_vector(7 downto 0);
	signal input8s : std_logic_vector(7 downto 0);
	signal selectors : std_logic_vector(2 downto 0);
	signal outputs : std_logic_vector(7 downto 0);
	
	signal input1bit1, input1bit2, input1bit3, input1bit4, input1bit5, input1bit6, input1bit7, input1bit8, output1bitor, output1bitand, output1bitnot : std_logic;
	begin --testbench
	
	INST_OR : OR_Gate --move this to the bottom?
    PORT MAP(
		OrInput1 => input1bit1,
		OrInput2 => input1bit2,
		OrInput3 => input1bit3,
		OrInput4 => input1bit4,
		OrInput5 => input1bit5,
		OrInput6 => input1bit6,
		OrInput7 => input1bit7,
		OrInput8 => input1bit8,
		OrOutput => output1bitor
    );
	
	INST_AND : AND_Gate
port map(
			AndInput1 => input1bit1,
			AndInput2 => input1bit2,
			AndInput3 => input1bit3,
			AndInput4 => input1bit4,
			AndOutput => output1bitand
);

	INST_NOT0 : NOT_Gate
    PORT MAP(
		NotInput => input1bit1,
		NotOutput => output1bitnot
    );

		inst1 : mux8s port map (
			input0 => input1s,
			input1 => input2s,
			input2 => input3s,
			input3 => input4s,
			input4 => input5s,
			input5 => input6s,
			input6 => input7s,
			input7 => input8s,
			selector => selectors,
			output => outputs);
	
	
	testprocess : process
	begin
	
		input1bit1 <= '0';
		input1bit2 <= '1';
		input1bit3 <= '0';
		input1bit4 <= '0';
		input1bit5 <= '0';
		input1bit6 <= '0';
		input1bit7 <= '0';
		input1bit8 <= '0';
		wait for 50ns; --test OR - output = 1, And output = 0
		
		input1bit1 <= '1';
		input1bit2 <= '0';
		input1bit3 <= '1';
		input1bit4 <= '1';
		wait for 50ns; --test AND - output = 0
		
		input1bit1 <= '1';
		input1bit2 <= '1';
		input1bit3 <= '1';
		input1bit4 <= '1';
		wait for 50ns; --test AND - output = 1
		
		input1bit1 <= '0';
		wait for 50ns; --test NOT
		input1bit1 <= '1';
		wait for 50ns; --test NOT
		
		
		input1s <= "00000000";
		input2s <= "00000001";
		input3s <= "00000010";
		input4s <= "00000011";
		input5s <= "00000100";
		input6s <= "00000101";
		input7s <= "00000110";
		input8s <= "XXXXXXXX";
		selectors <= "001"; --select input 2
		wait for 50ns;
		
		input1s <= "00000000";
		input2s <= "00000001";
		input3s <= "00000010";
		input4s <= "00000011";
		input5s <= "00000100";
		input6s <= "00000101";
		input7s <= "00000110";
		input8s <= "XXXXXXXX";
		selectors <= "111"; --select invalid
		wait for 50ns;
		
		input1s <= "00000000";
		input2s <= "00000001";
		input3s <= "00000010";
		input4s <= "00000011";
		input5s <= "00010100";
		input6s <= "00000101";
		input7s <= "00000110";
		input8s <= "XXXXXXXX";
		selectors <= "100"; --select input 5
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		input8s <= "XXXXXXXX";
		selectors <= "000"; --select input 1
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		input8s <= "XXXXXXXX";
		selectors <= "001"; --select input 2
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		input8s <= "XXXXXXXX";
		selectors <= "010"; --select input 3
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		input8s <= "XXXXXXXX";
		selectors <= "011"; --select input 4
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		input8s <= "XXXXXXXX";
		selectors <= "100"; --select input 5
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		input8s <= "XXXXXXXX";
		selectors <= "101"; --select input 6
		wait for 50ns;
		
		input1s <= "10000000";
		input2s <= "10000001";
		input3s <= "10000010";
		input4s <= "10000011";
		input5s <= "10000100";
		input6s <= "10000101";
		input7s <= "10000110";
		input8s <= "XXXXXXXX";
		selectors <= "110"; --select input 7
		wait for 50ns;
		
		
	end process;
	
end testbench;