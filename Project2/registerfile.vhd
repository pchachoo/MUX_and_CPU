
-- Project 2 ECE 585
-- This is our register file. It includes 32-bit 32 registers. It is able to read the registers and also to write them.

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity RegisterFile is

    port(clk : in std_logic;
	 Src1Addr : in std_logic_vector(4 downto 0);
         Src2Addr : in std_logic_vector(4 downto 0);
         Src1Data : out std_logic_vector(31 downto 0);
         Src2Data : out std_logic_vector(31 downto 0);
	 DestAddr : in std_logic_vector(4 downto 0);
         WriteData : in std_logic_vector(31 downto 0);
	 WriteControl : in std_logic);
         
end RegisterFile;

architecture Behavioral of RegisterFile is
    
	 -- Define the array structure
	 -- We provided initial values into the registers to perform the whole simulation
    type RegisterFile_Array is array (0 to 31) of std_logic_vector (31 downto 0);
    signal RAM : RegisterFile_Array := ("00000000000000000000000000000000", -- $zero
			   "00000000000000000000000000000001", -- $at
	        "00000000000000000000000000000000", -- $v0
			   "00000000000000000000000000000000", -- $v1
			   "00000000000000000000000000000000", -- $a0
  			   "00000000000000000000000000000000", -- $a1
			   "00000000000000000000000000000000", -- $a2
			   "00000000000000000000000000000000", -- $a3
				"00000000000000000000000000000000", -- $t0 written by the instruction ADD (0)
				"00000000000000000000000000000000", -- $t1 written by the instruction LW (504)
				"00000000000000000000000000000000", -- $t2 written by the instruction LW (508)
				"00000000000000000000000000000000", -- $t3 written by the instruction XORI (604)
				"00000000000000000000000000000000", -- $t4 written by the instruction NOR (8)
				"00000000000000000000001001011100", -- $t5 set to 604 in decimal, read by the instruction JR (528)
				"00000000000000000001100101100100", -- $t6 set to 6500 in decimal, read by the instruction SW (524)
				"00000000000000000001010110110011", -- $t7 set to 5555 in decimal, read by the instruction SW (520)
				"00000000000000000000000000000000", -- $s0 written by the instruction SLL (4)
				"00000000000000000000111111111111", -- $s1 set to 4095 in decimal
				"00000000000000000000001110000100", -- $s2 set to 900 in decimal
				"00000000000000000000001110001000", -- $s3 set to 904 in decimal 
				"00000000000000000000001010111000", -- $s4 set to 696 in decimal
				"00000000000000000000100010010101", -- $s5 set t0 2197 in decimal
				"00000000000000000000011101101010", -- $s6 set to 1898 in decimal
				"00000000000000000000000000000000", -- $s7 written by the instruction ADD (16)
				"00000000000000000000000000000000",
				"00000000000000000000000000000000",
				"00000000000000000000000000000000",
				"00000000000000000000000000000000",
				"00000000000000000000000000000000",
				"00000000000000000000000000000000",
				"00000000000000000000000000000000",
				"00000000000000000000000000000000");
  
begin
    
	 -- Read the registers
    Src1Data <= RAM(conv_integer(Src1Addr(4 downto 0)));
    Src2Data <= RAM(conv_integer(Src2Addr(4 downto 0)));
    
    process(clk)
    begin
    	if (rising_edge(clk) and WriteControl = '1') then
		   -- Write the register wanted
	      RAM(conv_integer(DestAddr(4 downto 0))) <= WriteData(31 downto 0);		
	   end if;
   end process;

end Behavioral;

