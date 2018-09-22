library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity MuxS_1bit is
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
         
end MuxS_1bit;

architecture structural of MuxS_1bit is

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

signal S0, S1, S2,NotS0, NotS1, NotS2: std_logic;
signal AndOutput0, AndOutput1, AndOutput2, AndOutput3, AndOutput4, AndOutput5, AndOutput6, AndOutput7: std_logic;

begin
S0 <= selector(2);
S1 <= selector(1);
S2 <= selector(0);

	INST_NOT0 : NOT_Gate
    PORT MAP(
		NotInput => S0,
		NotOutput => NotS0
    );
	
	INST_NOT1 : NOT_Gate
    PORT MAP(
		NotInput => S1,
		NotOutput => NotS1
    );
	
	INST_NOT2 : NOT_Gate
    PORT MAP(
		NotInput => S2,
		NotOutput => NotS2
    );

	INST_AND0 : AND_Gate
    PORT MAP(
		AndInput1 => Input0,
		AndInput2 => NotS0,
		AndInput3 => NotS1,
		AndInput4 => NotS2,
		AndOutput => AndOutput0
    );
	
	INST_AND1 : AND_Gate
    PORT MAP(
		AndInput1 => Input1,
		AndInput2 => NotS0,
		AndInput3 => NotS1,
		AndInput4 => S2,
		AndOutput => AndOutput1
    );
	
	INST_AND2 : AND_Gate
    PORT MAP(
		AndInput1 => Input2,
		AndInput2 => NotS0,
		AndInput3 => S1,
		AndInput4 => NotS2,
		AndOutput => AndOutput2
    );
	
	INST_AND3 : AND_Gate
    PORT MAP(
		AndInput1 => Input3,
		AndInput2 => NotS0,
		AndInput3 => S1,
		AndInput4 => S2,
		AndOutput => AndOutput3
    );
	
	INST_AND4 : AND_Gate
    PORT MAP(
		AndInput1 => Input4,
		AndInput2 => S0,
		AndInput3 => NotS1,
		AndInput4 => NotS2,
		AndOutput => AndOutput4
    );
	
	INST_AND5 : AND_Gate
    PORT MAP(
		AndInput1 => Input5,
		AndInput2 => S0,
		AndInput3 => NotS1,
		AndInput4 => S2,
		AndOutput => AndOutput5
    );
	
	INST_AND6 : AND_Gate
    PORT MAP(
		AndInput1 => Input6,
		AndInput2 => S0,
		AndInput3 => S1,
		AndInput4 => NotS2,
		AndOutput => AndOutput6
    );
	
	INST_AND7 : AND_Gate
    PORT MAP(
		AndInput1 => Input7, --undefined input
		AndInput2 => S0,
		AndInput3 => S1,
		AndInput4 => S2,
		AndOutput => AndOutput7
    );
	
	INST_OR : OR_Gate --move this to the bottom?
    PORT MAP(
		OrInput1 => AndOutput0,
		OrInput2 => AndOutput1,
		OrInput3 => AndOutput2,
		OrInput4 => AndOutput3,
		OrInput5 => AndOutput4,
		OrInput6 => AndOutput5,
		OrInput7 => AndOutput6,
		OrInput8 => AndOutput7,
		OrOutput => Output
    );

end structural;