
-- Project 2 ECE 585
-- ALU used in the datapath during the Execute step.
-- We implemented it as a combinational logic circuit to be fast.
-- It is able to compute the operations required for the instructions in this project.

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity alu is

    port(control  : in std_logic_vector(2 downto 0);
         DATAA : in std_logic_vector(31 downto 0);
         DATAB : in std_logic_vector(31 downto 0);
         ALUOUT : out std_logic_vector(31 downto 0);
	 overflow : out std_logic := '0';
	 COUT : out std_logic := '0');
         
end alu;

architecture Behavioral of alu is
    signal CIN : std_logic := '0';
    signal sum : std_logic_vector(31 downto 0) := (others => '0');
    signal DATAB2 : std_logic_vector(31 downto 0) := (others => '0');
    signal carry : std_logic_vector(31 downto 0) := (others => '0');
begin
    u1 : entity work.mux8v1 port map (control, CIN);
    u2 : entity work.xor_gate port map (CIN, DATAB, DATAB2);
    
    v1 : entity work.ADD_1BIT_GATE port map (DATAA(0), DATAB2(0), CIN, sum(0), carry(0));
    v2 : entity work.ADD_1BIT_GATE port map (DATAA(1), DATAB2(1), carry(0), sum(1), carry(1));
    v3 : entity work.ADD_1BIT_GATE port map (DATAA(2), DATAB2(2), carry(1), sum(2), carry(2));
    v4 : entity work.ADD_1BIT_GATE port map (DATAA(3), DATAB2(3), carry(2), sum(3), carry(3));
    v5 : entity work.ADD_1BIT_GATE port map (DATAA(4), DATAB2(4), carry(3), sum(4), carry(4));
    v6 : entity work.ADD_1BIT_GATE port map (DATAA(5), DATAB2(5), carry(4), sum(5), carry(5));
    v7 : entity work.ADD_1BIT_GATE port map (DATAA(6), DATAB2(6), carry(5), sum(6), carry(6));
    v8 : entity work.ADD_1BIT_GATE port map (DATAA(7), DATAB2(7), carry(6), sum(7), carry(7)); 
    v9 : entity work.ADD_1BIT_GATE port map (DATAA(8), DATAB2(8), carry(7), sum(8), carry(8)); 
    v10 : entity work.ADD_1BIT_GATE port map (DATAA(9), DATAB2(9), carry(8), sum(9), carry(9)); 
    v11 : entity work.ADD_1BIT_GATE port map (DATAA(10), DATAB2(10), carry(9), sum(10), carry(10)); 
    v12 : entity work.ADD_1BIT_GATE port map (DATAA(11), DATAB2(11), carry(10), sum(11), carry(11)); 
    v13 : entity work.ADD_1BIT_GATE port map (DATAA(12), DATAB2(12), carry(11), sum(12), carry(12)); 
    v14 : entity work.ADD_1BIT_GATE port map (DATAA(13), DATAB2(13), carry(12), sum(13), carry(13)); 
    v15 : entity work.ADD_1BIT_GATE port map (DATAA(14), DATAB2(14), carry(13), sum(14), carry(14)); 
    v16 : entity work.ADD_1BIT_GATE port map (DATAA(15), DATAB2(15), carry(14), sum(15), carry(15)); 
    v17 : entity work.ADD_1BIT_GATE port map (DATAA(16), DATAB2(16), carry(15), sum(16), carry(16)); 
    v18 : entity work.ADD_1BIT_GATE port map (DATAA(17), DATAB2(17), carry(16), sum(17), carry(17)); 
    v19 : entity work.ADD_1BIT_GATE port map (DATAA(18), DATAB2(18), carry(17), sum(18), carry(18)); 
    v20 : entity work.ADD_1BIT_GATE port map (DATAA(19), DATAB2(19), carry(18), sum(19), carry(19)); 
    v21 : entity work.ADD_1BIT_GATE port map (DATAA(20), DATAB2(20), carry(19), sum(20), carry(20)); 
    v22 : entity work.ADD_1BIT_GATE port map (DATAA(21), DATAB2(21), carry(20), sum(21), carry(21)); 
    v23 : entity work.ADD_1BIT_GATE port map (DATAA(22), DATAB2(22), carry(21), sum(22), carry(22)); 
    v24 : entity work.ADD_1BIT_GATE port map (DATAA(23), DATAB2(23), carry(22), sum(23), carry(23)); 
    v25 : entity work.ADD_1BIT_GATE port map (DATAA(24), DATAB2(24), carry(23), sum(24), carry(24)); 
    v26 : entity work.ADD_1BIT_GATE port map (DATAA(25), DATAB2(25), carry(24), sum(25), carry(25)); 
    v27 : entity work.ADD_1BIT_GATE port map (DATAA(26), DATAB2(26), carry(25), sum(26), carry(26)); 
    v28 : entity work.ADD_1BIT_GATE port map (DATAA(27), DATAB2(27), carry(26), sum(27), carry(27)); 
    v29 : entity work.ADD_1BIT_GATE port map (DATAA(28), DATAB2(28), carry(27), sum(28), carry(28)); 
    v30 : entity work.ADD_1BIT_GATE port map (DATAA(29), DATAB2(29), carry(28), sum(29), carry(29)); 
    v31 : entity work.ADD_1BIT_GATE port map (DATAA(30), DATAB2(30), carry(29), sum(30), carry(30)); 
    v32 : entity work.ADD_1BIT_GATE port map (DATAA(31), DATAB2(31), carry(30), sum(31), carry(31)); 
    
    ALUOUT(0) <= sum(0) when (control = "010" OR control = "111") else
	      sum(0) when control = "100" else
	      DATAA(0) XOR DATAB(0) when control = "101" else
         DATAA(0) NOR DATAB(0) when control = "001" else
	      '0' when control = "110" else
	      DATAA(0);

    ALUOUT(30 downto 1) <= sum(30 downto 1) when (control = "010" OR control = "111") else
	      sum(30 downto 1) when control = "100" else
	      DATAA(30 downto 1) XOR DATAB(30 downto 1) when control = "101" else
         DATAA(30 downto 1) NOR DATAB(30 downto 1) when control = "001" else
	      DATAA(29 downto 0) when control = "110" else
	      DATAA(30 downto 1);

    ALUOUT(31) <= sum(31) when (control = "010" OR control = "111") else
	      sum(31) when control = "100" else
	      DATAA(31) XOR DATAB(31) when control = "101" else
	      DATAA(31) NOR DATAB(31) when control = "001" else
	      DATAA(30) when control = "110" else
	      DATAA(31);
    
    overflow <= (carry(30) XOR carry(31));
    COUT <= carry(31);

end Behavioral;
