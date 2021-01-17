Library ieee;
use ieee.std_logic_1164.all;

entity partC is 
GENERIC (n : integer := 16);
port(
A : IN std_logic_vector (n-1 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (n-1 DOWNTO 0);
cout: OUT std_logic
);
end entity;

Architecture arch_partC of partC is
begin
F(n-2 DOWNTO 0) <= (A(n-1 DOWNTO 1));
  
With S select
F(n-1) <= ('0') when "00",
	(A(0)) when "01",
	(cin) when "10",
	(A(n-1)) when "11",
     '0' when others;

cout <= A(0);
end Architecture;