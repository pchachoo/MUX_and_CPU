
-- Project 2 ECE 585
-- This module includes all what is needed into the CPU, with the Instruction Cache and the Data cache.
-- We used a FSM to be able to wait until the end of the operations in the caches.
-- The FSM has 5 states.

library ieee;

use ieee.std_logic_1164.all;

entity cpu is
   port (clk : in std_logic;
         reset : in std_logic;
         MemAddress : out std_logic_vector(11 downto 0);
         MemRead : out std_logic;
			 MemWrite : out std_logic;
			 MemResp : in std_logic;
         MemDataIn : out std_logic_vector(31 downto 0);
         MemDataOut : in std_logic_vector(127 downto 0));
end cpu;

architecture behavioral of cpu is

	 -- Declare all the signals we need to wires all the block inside the CPU.
    type StateType is (InstructionFetchState, InstructionRegisterState, ExecuteState, MemoryState, WriteBackState);
    signal CurrentState : StateType := InstructionFetchState;

    signal IFdone : std_logic;
	 signal MEMdone : std_logic;
	 signal ContinuePC : std_logic := '0';

    signal ICacheRead : std_logic := '0';
    signal ICacheWrite : std_logic := '0';
	 signal DCacheRead : std_logic := '0';
    signal DCacheWrite : std_logic := '0';
    signal ICacheInputEmpty : std_logic_vector(31 downto 0) := (others => '0');

    signal RegDest : std_logic;
    signal ALUSource : std_logic;
    signal MemtoReg : std_logic;
    signal RegWrite : std_logic;
    signal PCsel : std_logic_vector(1 downto 0);
    signal ExtOp : std_logic;
    signal ALUcontrol : std_logic_vector(2 downto 0);

    signal PCNext : std_logic_vector(31 downto 0);
    signal PCaddress : std_logic_vector(31 downto 0) := (others => '0');
    signal instruction : std_logic_vector(31 downto 0);
    signal instructionFromCache : std_logic_vector(31 downto 0);
	 
    signal opcode : std_logic_vector(5 downto 0);
    signal func : std_logic_vector(5 downto 0);
    signal Rt : std_logic_vector(4 downto 0);
    signal Rs : std_logic_vector(4 downto 0);
    signal Rd : std_logic_vector(4 downto 0);
    signal DestAddrReg : std_logic_vector(4 downto 0);
    signal busA : std_logic_vector(31 downto 0);
    signal busB : std_logic_vector(31 downto 0);    
    signal OutExtender : std_logic_vector(31 downto 0);
    signal Imm16 : std_logic_vector(15 downto 0);
    signal busBprime : std_logic_vector(31 downto 0);
    signal ALUout : std_logic_vector(31 downto 0);
    signal overflow : std_logic;
    signal COUT : std_logic;
    signal MemoryOut : std_logic_vector(31 downto 0);
    signal busWrite : std_logic_vector(31 downto 0);
    
    signal PCPlus4 : std_logic_vector(31 downto 0);
    signal overflow2 : std_logic;
    signal COUT2 : std_logic;
    signal ShiftedAndSignExtended : std_logic_vector(31 downto 0);
    signal Imm16Shifted : std_logic_vector(17 downto 0);
    signal ToLabel : std_logic_vector(31 downto 0);
    signal overflow3 : std_logic;
    signal COUT3 : std_logic;
    signal ToJump : std_logic_vector(31 downto 0);

    signal selectorCache : std_logic;
	 signal MemAddressInstruction : std_logic_vector(11 downto 0);
    signal MemReadInstruction : std_logic;
	 signal MemWriteInstruction : std_logic;
	 signal MemDataInInstruction : std_logic_vector(31 downto 0);
    signal MemAddressData : std_logic_vector(11 downto 0);
    signal MemReadData : std_logic;
	 signal MemWriteData : std_logic;
	 signal MemDataInData : std_logic_vector(31 downto 0);
begin

-- Map the Instruction Cache
InstructionCache : entity work.icache port map (clk, ICacheRead, ICacheWrite, IFdone, PCaddress, ICacheInputEmpty, instructionFromCache, MemAddressInstruction, MemReadInstruction, MemWriteInstruction, MemResp, MemDataInInstruction, MemDataOut);

-- Map the Data Cache
DataCache : entity work.dcache port map (clk, DCacheRead, DCacheWrite, MEMdone, ALUout, busB, MemoryOut, MemAddressData, MemReadData, MemWriteData, MemResp, MemDataInData, MemDataOut, opcode);

-- Map the other blocks needed
MuxForMemory : entity work.mux_for_memory port map (selectorCache, MemAddressInstruction, MemReadInstruction, MemWriteInstruction, MemDataInInstruction, MemAddressData, MemReadData, MemWriteData, MemDataInData, MemAddress, MemRead, MemWrite, MemDataIn);
selectorCache <= '1' when (ICacheRead = '1' AND ICacheWrite = '0') else '0';

u0 : entity work.control_unit port map (opcode, func, RegDest, ALUSource, MemtoReg, RegWrite, PCsel, ExtOp, ALUout, ALUcontrol);
u1 : entity work.Mux2to1_5bits port map (Rt, Rd, RegDest, DestAddrReg);
u2 : entity work.registerfile port map (clk, Rs, Rt, busA, busB, DestAddrReg, busWrite, RegWrite);
u3 : entity work.alu port map (ALUcontrol, busA, busBprime, ALUout, overflow, COUT);
u4 : entity work.extender port map (Imm16, ExtOp, OutExtender);
u5 : entity work.Mux2to1_32bits port map (busB, OutExtender, ALUSource, busBprime);
u7 : entity work.Mux2to1_32bits port map (ALUout, MemoryOut, MemtoReg, busWrite);

ContinuePC <= '1' when (CurrentState = WriteBackState) else '0';
u12 : entity work.Mux3to1_32bitsforPC port map (PCPlus4, ToLabel, ToJump, PCsel, PCNext);   
u10 : entity work.PC_DFlipFlop_32bits port map (ContinuePC, PCNext, PCaddress); -- the clock signal is the signal transition of the last stage
u11 : entity work.alu port map ("010", "00000000000000000000000000000100", PCaddress, PCPlus4, overflow2, COUT2);
u13 : entity work.SignExtend port map (Imm16Shifted, ShiftedAndSignExtended);
u14 : entity work.alu port map ("010", PCPlus4, ShiftedAndSignExtended, ToLabel, overflow3, COUT3);

-- Assign the signals used
instruction(31 downto 0) <= instructionFromCache(31 downto 0);
ToJump <= busA when (opcode = "000000" AND func = "001000") else PCaddress(31 downto 28) & instruction(25 downto 0) & "00";
opcode(5 downto 0) <= instruction(31 downto 26);
func(5 downto 0) <= instruction(5 downto 0);
Rs(4 downto 0) <= instruction(25 downto 21);
Rt(4 downto 0) <= instruction(20 downto 16);
Rd(4 downto 0) <= instruction(15 downto 11);
Imm16(15 downto 0) <= instruction(15 downto 0);
Imm16Shifted(17 downto 0) <= Imm16&"00";

process (clk)
begin
	if falling_edge(clk) then
	   case CurrentState is
		  when InstructionFetchState => -- In this state we wait for IFdone to be set to 1 by the instruction cache
			if (IFdone = '1') then
			   CurrentState <= InstructionRegisterState;
				ICacheRead <= '0';
				ICacheWrite <= '0';
				DCacheRead <= '0';
			   DCacheWrite <= '0';
			else
			   CurrentState <= InstructionFetchState;
				ICacheRead <= '1';
				ICacheWrite <= '0';
				DCacheRead <= '0';
				DCacheWrite <= '0';
			end if;

		 when InstructionRegisterState => -- no need to wait in this state so we move to the next state
			  ICacheRead <= '0';
			  ICacheWrite <= '0';
			  DCacheRead <= '0';
			 DCacheWrite <= '0';
			 CurrentState <= ExecuteState;

		  when ExecuteState => -- no need to wait in this state so we move to the next state
			   ICacheRead <= '0';
			   ICacheWrite <= '0';
			   DCacheRead <= '0';
			  DCacheWrite <= '0';
			  CurrentState <= MemoryState;
			
		  when MemoryState => -- in this state, we wait until MEMdone is set to 1 by the Data cache
			  if (MEMdone = '1') then
				 CurrentState <= WriteBackState;
					  ICacheRead <= '0';
					  ICacheWrite <= '0';
					  DCacheRead <= '0';
				 DCacheWrite <= '0';
			  else 
				 CurrentState <= MemoryState;
					  ICacheRead <= '0';
					  ICacheWrite <= '0';
					  if (opcode = "100011") then -- LW instruction
						  DCacheRead <= '1';
					  else
						 DCacheRead <= '0';
					  end if;
					  if (opcode = "101011") then -- SW instruction
						  DCacheWrite <= '1';
					  else
						 DCacheWrite <= '0';
					  end if; 
				  end if;

		 when WriteBackState => -- no need to wait in this state so we move to the next state and we set the cache signals to 0 to keep both caches in sleeping mode 
			 ICacheRead <= '0';
			  ICacheWrite <= '0';
			  DCacheRead <= '0';
			 DCacheWrite <= '0';
			 CurrentState <= InstructionFetchState;
	   end case;
   end if;
end process;

end behavioral;
