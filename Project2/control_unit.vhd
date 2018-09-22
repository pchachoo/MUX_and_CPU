
-- Project 2 ECE 585
-- Control unit used to generate the signals to control the blocks in our datapath

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity control_unit is

    port(op  : in std_logic_vector(5 downto 0);
         func : in std_logic_vector(5 downto 0);
         RegDst : out std_logic;
         ALUSrc : out std_logic;
         MemtoReg : out std_logic;
         RegWrite : out std_logic;
         PCsel : out std_logic_vector(1 downto 0);
         ExtOp : out std_logic;
         Zero : in std_logic_vector(31 downto 0);
         ALUcontrol : out std_logic_vector(2 downto 0));
         
end control_unit;

architecture Behavioral of control_unit is
begin
    RegDst <= '1' when (op = "000000") else '0';
	 -- to select whether Rd or Rt as the destination register to write in the register file
	 
    ALUSrc <= '1' when (op = "001110" OR op = "001101" OR op = "100011" OR op = "101011" or op = "001000") else '0';
	 -- to select the second input of the ALU (from the Extender or from BusB)
	 
    MemtoReg <= '1' when op = "100011" else '0'; -- for LW
    -- to select the signal to write back into the register file (output of the ALU of output of the cache)
	
	  RegWrite <= '1' when (op = "001110" OR op = "000000" OR op = "001101" OR op = "100011") OR (op = "001000") else '0';
	  -- to define when we must write into the register file during the WB step.
	  
    PCsel <= "01" when (op = "000100" AND Zero = "00000000000000000000000000000000") else "11" when (op = "000010" OR (op = "000000" AND func = "001000")) else "00";
	  -- PCsel set to "00" to select the PCNext=PCAddress+4
	  -- PCsel set to "01" to select the address to take the branch
	  -- PCsel set to "11" to select the address to jump
	   
    ExtOp <= '1' when (op = "001110" OR op = "100011" OR op = "101011") else '0';
    -- to select if we need to sign extend or not
	
    ALUcontrol <= "010" when (op = "000000" AND func = "100000") OR (op = "100011") OR (op = "101011") OR (op = "001000") else -- for ADD, LW, SW, ADDI
                  "100" when op = "000100" else -- for BEQ we perform a subtraction and the control unit will check the result if it is 0 or not
                  "101" when (op = "001110") else -- for XORI
                  "110" when (op = "000000" AND func = "0000000") else -- for SLL
                  "001" when (op = "000000" AND func = "0100111") else -- for NOR
                  "111";
   --- to control the operation to perform into the ALU
   
end Behavioral;
