Library ieee;
use ieee.std_logic_1164.all;

ENTITY temp_ALU IS
PORT( cin1: IN std_logic;
	A1,B1 : IN std_logic_vector (15 DOWNTO 0);		
	sel : IN std_logic_vector (3 DOWNTO 0);
	F1 : OUT std_logic_vector (15 DOWNTO 0);
	cout1: OUT std_logic);
END ENTITY temp_ALU;

ARCHITECTURE structure OF temp_ALU IS

COMPONENT portA
port(
A,B : IN std_logic_vector (15 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (15 DOWNTO 0);
cout: OUT std_logic
);

END COMPONENT;
Begin
s0: portA PORT MAP (A1,B1,cin1,sel(1 DOWNTO 0),F1,cout1);
END structure;
