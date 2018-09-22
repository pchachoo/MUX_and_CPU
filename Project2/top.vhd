
-- Project 2 ECE 585
-- Top level module of the project. The Memory and the CPU are mapped. The signals between them are the bus.

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity top is
    port(clk : in std_logic;
	 reset : in std_logic);
end top;

architecture Behavioral of top is
   
    -- The Bus made of several signals
    signal MemAddress : std_logic_vector(11 downto 0);
    signal MemRead : std_logic;
    signal MemWrite : std_logic;
    signal MemResp : std_logic;
    signal DataToMemory : std_logic_vector(31 downto 0);
    signal DataFromMemory : std_logic_vector(127 downto 0);

begin
    -- Map the memory
    Memory : entity work.memory port map (clk, MemAddress, MemRead, MemWrite, MemResp, DataToMemory, DataFromMemory);
    
	 -- Map the CPU
	 CPU : entity work.cpu port map (clk, reset, MemAddress, MemRead, MemWrite, MemResp, DataToMemory, DataFromMemory);
    
end Behavioral;

