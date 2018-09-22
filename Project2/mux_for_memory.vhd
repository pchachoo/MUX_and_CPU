
-- Project 2 ECE 585
-- Multiplexer 2 to 1 used to map the signals between the two cache and the memory.
-- Indeed, depending on which operation is performed in the caches, we need to connect the memory signals to the instruction cache or to the data cache.

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity mux_for_memory is
    port(selectorCache : in std_logic;
	     MemAddressInstruction : in std_logic_vector(11 downto 0);
         MemReadInstruction : in std_logic;
	      MemWriteInstruction : in std_logic;
		   MemDataInInstruction : in std_logic_vector(31 downto 0);
		  MemAddressData : in std_logic_vector(11 downto 0);
         MemReadData : in std_logic;
	      MemWriteData : in std_logic;
		   MemDataInData : in std_logic_vector(31 downto 0);
		  MemAddress : out std_logic_vector(11 downto 0);
         MemRead : out std_logic;
	      MemWrite : out std_logic;
		   MemDataIn : out std_logic_vector(31 downto 0)
	);
end mux_for_memory;

architecture Behavioral of mux_for_memory is
begin

	MemAddress <= MemAddressInstruction when selectorCache = '1' else MemAddressData;
	MemRead <= MemReadInstruction when selectorCache = '1' else MemReadData;
	MemWrite <= MemWriteInstruction when selectorCache = '1' else MemWriteData;
	MemDataIn <= MemDataInInstruction when selectorCache = '1' else MemDataInData;

end Behavioral;
