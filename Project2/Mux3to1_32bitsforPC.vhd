
-- Project 2 ECE 585
-- Multiplexer 3 to 1 used to select the right 32-bit signal for the Next PC address

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Mux3to1_32bitsforPC is
    port(dataA : in std_logic_vector(31 downto 0);
	 dataB : in std_logic_vector(31 downto 0);
         dataC : in std_logic_vector(31 downto 0);
         sel : in std_logic_vector(1 downto 0);
         output : out std_logic_vector(31 downto 0));
end Mux3to1_32bitsforPC;

architecture Behavioral of Mux3to1_32bitsforPC is
    signal PCTempout : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";
begin

    PCTempout(31 downto 0) <= dataA(31 downto 0) when (sel = "00" AND NOT(dataA(31 downto 0) = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")) else
                              dataB(31 downto 0) when (sel = "01" AND NOT(dataA(31 downto 0) = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")) else
           		      dataC(31 downto 0) when (sel = "11" AND NOT(dataA(31 downto 0) = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"));
    
    output(31 downto 0) <= PCTempout(31 downto 0);

end Behavioral;
