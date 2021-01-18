Library ieee;
use ieee.std_logic_1164.all;

entity partD is 
GENERIC (n : integer := 16);
port(
A : IN std_logic_vector (n-1 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (n-1 DOWNTO 0);
cout: OUT std_logic
);
end entity;

Architecture arch_partD of partD is
begin
--(others => "0")
With S select
F(n-1 DOWNTO 1) <= (others => '0') when "11",
	(A(n-2 DOWNTO 0)) when others;

With S select
F(0) <= ('0') when "00",
	(A(n-1)) when "01",
	(cin) when "10",
	('0') when "11",
     '0' when others;

cout <= A(n-1);
end Architecture;