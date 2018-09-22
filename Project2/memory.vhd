
-- Project 2 ECE 585
-- This is our Memory. We put initial values inside : the instructions and some data to read during the simulation.
-- The read and write operations are delayed as expected for this project. The clock cycle is 50 ns.
-- Memory port access time : 4 cycles/word for read so 200 ns ; 8 cycles/word for write so 400 ns.
-- Additional memory read time : 2 cycles/word so 100 ns ; 3 cycles/word so 150 ns.
-- That's why, for a read operation, it takes 1*200ns + 15*100 ns = 1700 ns.
-- and for a write operation, it takes 1*400 ns + 3*150 ns = 850 ns.

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
    port(clk : in std_logic;
         MemAddress : in std_logic_vector(11 downto 0);
         MemRead : in std_logic;
	      MemWrite : in std_logic;
	      MemResp : out std_logic := '0';
         DataIn : in std_logic_vector(31 downto 0);
         DataOut : out std_logic_vector(127 downto 0) := (others => '0')
		);
end Memory;

architecture MemoryBehavioral of Memory is
    type HardDisk is array (0 to 4095) of std_logic_vector (7 downto 0);
    signal MainMemory : HardDisk := ("00100000", "01000000", "11001111", "00000001", -- Address 0 : add $t0, $t6, $t7
										 "00100000", "10000000", "11001110", "00000001", -- Address 4 : ll $s0, $t6, 1
										 "00100111", "01100000", "01010011", "00000010", -- Address 8 : nor $t4, $s2, $s3
										 "00101100", "00000001", "10110001", "00010010", -- Address 12 : beq $s5, $s1, 300
										 "00100000", "10111000", "10110110", "00000010", -- Address 16 : add $s7, $s5, $s6 
										 "10010001", "00000000", "11110001", "00010010", -- Address 20 : beq $s7, $s1, 145
										x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00",
					  "01100100", "00000000", "01001001", "10001110", -- Address 512 : lw $t1, 100($s2)
				     "01100100", "00000000", "01101010", "10001110", -- Address 516 : lw $t2, 100($s3)
				     "00101100", "00000001", "10001111", "10101110", -- Address 520 : sw $t7, 300($s4)
				     "01000000", "00000001", "10001110", "10101110", -- Address 524 : sw $t6, 320($s4)
					  "00001000", "00000000", "10100000", "00000001", -- Address 528 : jr $t5
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", 
					  "10000000", "00000000", "00000000", "00001000",
					  x"00", x"00", x"00", x"00",
					  "11111111", "11111111", "00101011", "00111010",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
					  x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- Following are DATA stored
					  x"AA", x"AA", x"AA", x"AA",
					  x"BB", x"BB", x"BB", x"BB", -- Address 996
					  x"CC", x"CC", x"CC", x"CC", -- Address 1000
					  x"DD", x"DD", x"DD", x"DD", -- Address 1004
					  others => "00000000");
begin

process (clk)
begin
		if MemRead = '1' then
		   -- Each word read is delayed as expected and put into the bus
		   -- We read a block into the memory to provide to the cache
		   DataOut(7 downto 0) <= MainMemory(to_integer(unsigned(MemAddress))) after 200 ns;
			DataOut(15 downto 8) <= MainMemory(to_integer(unsigned(MemAddress)) + 1) after 300 ns;
			DataOut(23 downto 16) <= MainMemory(to_integer(unsigned(MemAddress)) + 2) after 400 ns;
			DataOut(31 downto 24) <= MainMemory(to_integer(unsigned(MemAddress)) + 3) after 500 ns;
		   DataOut(39 downto 32) <= MainMemory(to_integer(unsigned(MemAddress)) + 4) after 600 ns;
		   DataOut(47 downto 40) <= MainMemory(to_integer(unsigned(MemAddress)) + 5) after 700 ns;
		   DataOut(55 downto 48) <= MainMemory(to_integer(unsigned(MemAddress)) + 6) after 800 ns;
		   DataOut(63 downto 56) <= MainMemory(to_integer(unsigned(MemAddress)) + 7) after 900 ns;
		   DataOut(71 downto 64) <= MainMemory(to_integer(unsigned(MemAddress)) + 8) after 1000 ns;
		   DataOut(79 downto 72) <= MainMemory(to_integer(unsigned(MemAddress)) + 9) after 1100 ns;
		   DataOut(87 downto 80) <= MainMemory(to_integer(unsigned(MemAddress)) + 10) after 1200 ns;
		   DataOut(95 downto 88) <= MainMemory(to_integer(unsigned(MemAddress)) + 11) after 1300 ns;
		   DataOut(103 downto 96) <= MainMemory(to_integer(unsigned(MemAddress)) + 12) after 1400 ns;
		   DataOut(111 downto 104) <= MainMemory(to_integer(unsigned(MemAddress)) + 13) after 1500 ns;
		   DataOut(119 downto 112) <= MainMemory(to_integer(unsigned(MemAddress)) + 14)	 after 1600 ns;
		   DataOut(127 downto 120) <= MainMemory(to_integer(unsigned(MemAddress)) + 15)	 after 1700 ns;
			
			MemResp <= '1' after 1700 ns; -- once the read operation is done, we notice the cache that the bloc read is on ready on the bus.
		
		elsif MemWrite = '1' then
		   -- The word written into the memory is delayed as expected
		   -- We write a word into the memory (coming from the cache)
		   MainMemory(to_integer(unsigned(MemAddress)) + 3) <= DataIn(7 downto 0) after 400 ns;
		   MainMemory(to_integer(unsigned(MemAddress)) + 2) <= DataIn(15 downto 8) after 550 ns;
		   MainMemory(to_integer(unsigned(MemAddress)) + 1) <= DataIn(23 downto 16) after 700 ns;
		   MainMemory(to_integer(unsigned(MemAddress))) <= DataIn(31 downto 24) after 850 ns;
		   DataOut(127 downto 0) <= (others => '0');
		   MemResp <= '1' after 850 ns; -- once the write operation is done, we notice the cache that the word is written.
		else
		   -- When the Memory has nothing to do, sleeping mode.
			DataOut(127 downto 0) <= (others => '0');
			MemResp <= '0';
		end if;
end process;

end MemoryBehavioral;
