
-- Project 2 ECE 585
-- DFlip Flop (32-bit signals) used to delay the assignment of the New PC adress into NextPC.

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity PC_DFlipFlop_32bits is
    port(clk : in std_logic;
         PCin : in std_logic_vector(31 downto 0);
         PCout : out std_logic_vector(31 downto 0));
end PC_DFlipFlop_32bits;

architecture Behavioral of PC_DFlipFlop_32bits is
    signal PCTempout : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
	   PCTempout(31 downto 0) <= PCin(31 downto 0);
        end if;
    end process;

    PCout(31 downto 0) <= PCTempout(31 downto 0);

end Behavioral;
