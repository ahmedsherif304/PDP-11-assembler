Library ieee;
use ieee.std_logic_1164.all;

entity partB is 
GENERIC (n : integer := 16);
port(
A,B : IN std_logic_vector (n-1 DOWNTO 0);
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (n-1 DOWNTO 0)
);

end entity;

Architecture arch_partB of partB is
begin 
With S select
F <= (A and B) when "00",
	(A or B) when "01",
	(A xor B) when "10",
	(not A) when "11",
     (others => '0') when others;

end Architecture;