

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity decoder IS
	PORT(enable: IN std_logic;
	s : IN std_logic_vector(1 DOWNTO 0);
	result : OUT std_logic_vector(3 DOWNTO 0));
END decoder;

ARCHITECTURE arch_decoder OF decoder IS
signal Z_BUS : std_logic_vector (2 downto 0);
BEGIN
Z_BUS <= (s(1), s(0), enable);
With Z_BUS select
result <= "0001" when "001", 
"0010" when "011",  
"0100" when "101",  
"1000" when "111", 
"0000" when others;	
END arch_decoder;