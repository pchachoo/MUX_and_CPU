
-- Project 2 ECE 585
-- This is the Data Cache (256 Bytes). We have commented it.

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity dcache is
	generic (SizeOftheCache: positive := 256;
		    SizeOfaBlock: positive := 16);
	port(clk        : in std_logic;
		CacheRead   : in std_logic;
	   CacheWrite  : in std_logic;
		CacheResp   : out std_logic := '0';
		CPUAddress  : in std_logic_vector (31 downto 0);
		CacheDataIn  : in std_logic_vector (31 downto 0);
	   CacheDataOut : out std_logic_vector (31 downto 0);
	   MemAddress  : out std_logic_vector (11 downto 0) := (others => '0');
		MemRead     : out std_logic := '0';
	   MemWrite    : out std_logic := '0';
	   MemResp     : in std_logic;
		MemDataIn   : out std_logic_vector(31 downto 0) := (others => '0');
	   MemDataOut  : in std_logic_vector(127 downto 0);
	   opcode : in std_logic_vector(5 downto 0)
	);
end dcache;

architecture Behavioral of dcache is
	constant NbrOfSets : positive := SizeOftheCache/SizeOfaBlock;
	type set is array(0 to 3) of std_logic_vector(31 downto 0);
	type entry is record
		Valid : boolean;
		Tag : natural;
		Data : set;
	end record;
	type CacheType is array (0 to NbrOfSets-1) of entry;
	signal CACHE : CacheType;
	
	signal hit	: std_logic := '0'; -- 0 refers to a miss and 1 refers to a hit
	
	type StateCacheType is (Sleeping, CheckForHitOrMiss, Activated, Completed, WaitForReading, WaitForWriting); -- 5 states
	signal CurrentState : StateCacheType := Sleeping; -- Start at the sleeping mode
begin

MemAddress <= CPUAddress(11 downto 0); -- Crop the address signal to provide it to the Memory

process(clk)

	variable Tag : natural;
	variable index : natural range 0 to NbrOfSets-1;
	variable offset : natural range 0 to 3;
	variable IntegerAddress : integer;
	
	begin
	if falling_edge(clk) then
		case CurrentState is
			when Sleeping => -- This is a state to wait for something to do
				CacheResp <= '0';
				-- No operation to do in the Memory so
				MemRead <= '0';
				MemWrite <= '0';
				MemDataIn <= (others => '0');
				hit <= '0'; -- set hit signal to 0 by default
				if (CacheRead = '1' OR CacheWrite = '1') then -- If the cache is required to do something
				 	 CurrentState <= CheckForHitOrMiss; -- go to the next stage
				 end if;
				 if (CacheRead = '0' AND CacheWrite = '0') AND (NOT(opcode = "100011") AND NOT(opcode = "101011")) then -- if the cache is not necessary for the MEM step in the FSM of the CPU, then we notice the FSM of the CPU to continue to the next state.
			 		 CacheResp <= '1';
				 else -- Otherwise we wait for the operation to start
				    CacheResp <= '0';
				 end if;
			
			when CheckForHitOrMiss => -- This state determines if there is a hit or a miss
			    CacheResp <= '0';
				 IntegerAddress := to_integer(unsigned(CPUAddress));
				 -- Determine the Tag, the index and the offset
				 Tag := IntegerAddress/SizeOfaBlock / NbrOfSets;
				 index := (IntegerAddress/SizeOfaBlock) mod NbrOfSets;
				 offset := (IntegerAddress mod SizeOfaBlock)/4;
				-- Checking for cache hit (block in cache must be valid (already used once), and Tags matching)
				 if ((CACHE(index).valid = true) and (CACHE(index).Tag = Tag)) then -- both valid bit and tag must be matching
				 	 hit <= '1';
				 else 
				    hit <= '0'; -- this is a miss
				 end if;
				 CurrentState <= Activated; -- go to the next state
			
			when Activated => -- this state determines what to do depending on a hit or a miss we obtained
				if (hit = '1') then -- We had a hit
					if (CacheRead = '1') then -- Hit Read
						CacheResp <= '1'; -- to notice the FSM of the CPU
						MemRead <= '0';
						MemWrite <= '0';
						CurrentState <= Completed; -- go to the next state to complete
					end if;
					if (CacheWrite = '1') then -- Hit Write (we use write through)
						-- Write into the cache
						CACHE(index).data(offset) <= CacheDataIn(31 downto 0);
						-- Write also into the memory
						MemRead <= '0';
						MemWrite <= '1';
						CurrentState <= WaitForWriting; -- go to the state to wait for the memory to perform the write operation
					end if;
				else -- We had a miss
					if (CacheRead = '1') then -- Miss Read
						MemRead <= '1';
						MemWrite <= '0';
						CurrentState <= WaitForReading;
					end if;
					if (CacheWrite = '1') then -- Miss Write (we use no write allocate)
					   -- We do not write into the cache
					   -- Write only into the memory
					   MemRead <= '0';
						MemWrite <= '1';
						CurrentState <= WaitForWriting; -- go to the state to wait for the memory to perform the write operation
					end if;
				end if;
			
			when Completed =>
				 CacheResp <= '0';
				 -- The cache is read and this is provided in the output of the cache
				 CacheDataOut(31 downto 0) <= CACHE(index).data(offset);
				 CurrentState <= Sleeping;
			
			when WaitForReading => -- This state waits for the Memory to bring a block to the cache
			   -- Set the output signal for a Read operation in the Memory
				MemRead <= '1';
				MemWrite <= '0';
				CacheResp <= '0';
				if (MemResp = '1') then -- When the memory has completed the read operation
					CACHE(index).data(0) <= MemDataOut(31 downto 0); -- write word 1 into cache
					CACHE(index).data(1) <= MemDataOut(63 downto 32); -- write word 2 into cache
					CACHE(index).data(2) <= MemDataOut(95 downto 64); -- write word 3 into cache
					CACHE(index).data(3) <= MemDataOut(127 downto 96); -- write word 4 into cache
					CACHE(index).valid <= true; -- This new block is valid
					CACHE(index).Tag <= Tag; -- Assign the tag related to the block
					CacheResp <= '1'; -- to notice the FSM of the CPU
				   CurrentState <= Completed; -- go to the next state to complete
				end if;
			
			when WaitForWriting => -- This state waits for the Memory to write a word
				-- Set the output signal for a Write operation in the Memory
				MemRead <= '0';
				MemWrite <= '1';
				CacheResp <= '0';
				MemDataIn(31 downto 0) <= CacheDataIn(31 downto 0); -- Provide the word to write
				if (MemResp = '1') then -- When the memory has completed the write operation
					CacheResp <= '1'; -- to notice the FSM of the CPU
					CurrentState <= Completed; -- go to the next state to complete
				end if;
			
		end case;
	end if;
end process;

end Behavioral;

