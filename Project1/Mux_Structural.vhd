library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity mux8s is
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
         
end mux8s;


architecture structural of mux8s is

component MuxS_1bit is
    port(
	Input0 : in std_logic;
	Input1 : in std_logic;
	Input2 : in std_logic;
	Input3 : in std_logic;
	Input4 : in std_logic;
	Input5 : in std_logic;
	Input6 : in std_logic;
	Input7 : in std_logic;
	selector : in std_logic_vector(2 downto 0);
    Output : out std_logic
	);
         
end component;

begin

	INST_MuxS0 : MuxS_1bit
    PORT MAP(
		Input0 => input0(0),
		Input1 => input1(0),
		Input2 => input2(0),
		Input3 => input3(0),
		Input4 => input4(0),
		Input5 => input5(0),
		Input6 => input6(0),
		Input7 => input7(0),
		selector => selector,
		Output => output(0)
    );
	
	INST_MuxS1 : MuxS_1bit
    PORT MAP(
		Input0 => input0(1),
		Input1 => input1(1),
		Input2 => input2(1),
		Input3 => input3(1),
		Input4 => input4(1),
		Input5 => input5(1),
		Input6 => input6(1),
		Input7 => input7(1),
		selector => selector,
		Output => output(1)
    );
	
	INST_MuxS2 : MuxS_1bit
    PORT MAP(
		Input0 => input0(2),
		Input1 => input1(2),
		Input2 => input2(2),
		Input3 => input3(2),
		Input4 => input4(2),
		Input5 => input5(2),
		Input6 => input6(2),
		Input7 => input7(2),
		selector => selector,
		Output => output(2)
    );
	
	INST_MuxS3 : MuxS_1bit
    PORT MAP(
		Input0 => input0(3),
		Input1 => input1(3),
		Input2 => input2(3),
		Input3 => input3(3),
		Input4 => input4(3),
		Input5 => input5(3),
		Input6 => input6(3),
		Input7 => input7(3),
		selector => selector,
		Output => output(3)
    );
	
	INST_MuxS4 : MuxS_1bit
    PORT MAP(
		Input0 => input0(4),
		Input1 => input1(4),
		Input2 => input2(4),
		Input3 => input3(4),
		Input4 => input4(4),
		Input5 => input5(4),
		Input6 => input6(4),
		Input7 => input7(4),
		selector => selector,
		Output => output(4)
    );
	
	INST_MuxS5 : MuxS_1bit
    PORT MAP(
		Input0 => input0(5),
		Input1 => input1(5),
		Input2 => input2(5),
		Input3 => input3(5),
		Input4 => input4(5),
		Input5 => input5(5),
		Input6 => input6(5),
		Input7 => input7(5),
		selector => selector,
		Output => output(5)
    );
	
	INST_MuxS6 : MuxS_1bit
    PORT MAP(
		Input0 => input0(6),
		Input1 => input1(6),
		Input2 => input2(6),
		Input3 => input3(6),
		Input4 => input4(6),
		Input5 => input5(6),
		Input6 => input6(6),
		Input7 => input7(6),
		selector => selector,
		Output => output(6)
    );
	
	INST_MuxS7 : MuxS_1bit
    PORT MAP(
		Input0 => input0(7),
		Input1 => input1(7),
		Input2 => input2(7),
		Input3 => input3(7),
		Input4 => input4(7),
		Input5 => input5(7),
		Input6 => input6(7),
		Input7 => input7(7),
		selector => selector,
		Output => output(7)
    );

end structural;