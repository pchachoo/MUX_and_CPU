
-- Project 2 ECE 585
-- This is the Instruction Cache (512 Bytes). We have commented it.

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity icache is
	generic (SizeOftheCache: positive := 512;
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
	   MemDataOut  : in std_logic_vector(127 downto 0)
	);
end icache;

architecture Behavioral of icache is
	constant NbrOfSets : positive := SizeOftheCache/SizeOfaBlock;
	type set is array(0 to 3) of std_logic_vector(31 downto 0);
	type entry is record
		Valid : boolean;
		Tag : natural;
		Data : set;
	end record;
	type CacheType is array (0 to NbrOfSets-1) of entry;
	signal TheCache : CacheType;
	
	signal hit	: std_logic := '0'; -- 0 refers to a miss and 1 refers to a hit
	
	type StateCacheType is (Sleeping, CheckForHitOrMiss, Activated, Completed, WaitForReading); -- 5 states
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
			
			when CheckForHitOrMiss => -- This state determines if there is a hit or a miss
			    CacheResp <= '0';
				 IntegerAddress := to_integer(unsigned(CPUAddress));
				 -- Determine the Tag, the index and the offset
				 Tag := IntegerAddress/SizeOfaBlock / NbrOfSets;
				 index := (IntegerAddress/SizeOfaBlock) mod NbrOfSets;
				 offset := (IntegerAddress mod SizeOfaBlock)/4;
				 if ((TheCache(index).valid = true) and (TheCache(index).Tag = Tag)) then -- both valid bit and tag must be matching
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
				else -- We had a miss
					if (CacheRead = '1') then -- Miss Read
						MemRead <= '1';
						MemWrite <= '0';
						CurrentState <= WaitForReading; -- go to the state to wait for the memory to perform the read operation
					end if;
				end if;
			
			when Completed =>
				 CacheResp <= '0';
				 -- The cache is read and this is provided in the output of the cache
				 CacheDataOut(31 downto 0) <= TheCache(index).data(offset);
				 CurrentState <= Sleeping;
			
			when WaitForReading => -- This state waits for the Memory to bring a block to the cache
				-- Set the output signal for a Read operation in the Memory
				MemRead <= '1';
				MemWrite <= '0';
				CacheResp <= '0';
				if (MemResp = '1') then -- When the memory has completed the read operation
					TheCache(index).data(0) <= MemDataOut(31 downto 0); -- write word 1 into cache
					TheCache(index).data(1) <= MemDataOut(63 downto 32); -- write word 2 into cache
					TheCache(index).data(2) <= MemDataOut(95 downto 64); -- write word 3 into cache
					TheCache(index).data(3) <= MemDataOut(127 downto 96); -- write word 4 into cache
					TheCache(index).valid <= true; -- This new block is valid
					TheCache(index).Tag <= Tag; -- Assign the tag related to the block
					CacheResp <= '1'; -- to notice the FSM of the CPU
				   CurrentState <= Completed; -- go to the next state to complete
				end if;
			
		end case;
	end if;
end process;

end Behavioral;

