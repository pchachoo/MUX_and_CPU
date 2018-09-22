
-- Project 2 ECE 585
-- This is a test bench file to generate the input clock for the whole simulation.
-- The reader may notice that we chose a clock cycle equals to 50 ns.

library ieee; 
use ieee.std_logic_1164.all; 

entity top_tb is 
end;
 
architecture top_tb_arch of top_tb is
    
    signal clk : std_logic;
	signal RESET_L : std_logic := '0';
    
    component top
          port (
	  clk : in std_logic;
	  RESET_L : in std_logic); 
    end component; 

begin
    
	 -- Map to the top module of the project
    dut : entity work.top port map (clk, RESET_L);

    process
    begin
	   -- Generate the clock
		clk <= '0';
		wait for 25 ns;
		clk <= '1';
		wait for 25 ns;
    end process;
	
end top_tb_arch;

