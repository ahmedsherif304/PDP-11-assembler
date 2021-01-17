Library ieee;
use ieee.std_logic_1164.all;


ENTITY ALU IS
PORT( cin: IN std_logic;
	A,B : IN std_logic_vector (15 DOWNTO 0);		
	sel : IN std_logic_vector (3 DOWNTO 0);
	F : OUT std_logic_vector (15 DOWNTO 0);
	cout: OUT std_logic);
END ALU;

ARCHITECTURE arch_ALU OF ALU IS
COMPONENT partB IS
port(
A,B : IN std_logic_vector (15 DOWNTO 0);
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (15 DOWNTO 0)
);
END COMPONENT partB;

COMPONENT partC IS
port(
A : IN std_logic_vector (15 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (15 DOWNTO 0);
cout: OUT std_logic
);
END COMPONENT partC;

COMPONENT partD IS
port(
A : IN std_logic_vector (15 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (15 DOWNTO 0);
cout: OUT std_logic
);
END COMPONENT partD;

SIGNAL  F1,F2,F3,F4 : std_logic_vector (15 DOWNTO 0);
SIGNAL c1,c3,c4 : std_logic;
Begin
--      u0: mux2 PORT MAP (in0,in1,sel(0),x1);
u1: partB PORT MAP (A,B,sel(1 DOWNTO 0),F2);
u2: partC PORT MAP (A,cin,sel(1 DOWNTO 0),F3,c3);
u3: partD PORT MAP (A,cin,sel(1 DOWNTO 0),F4,c4);

With sel(3 DOWNTO 2) select
F <= F2 when "01",
F3 when "10",
F4 when "11",
( others => '0') when others;


With sel(3 DOWNTO 2) select
cout <= c3 when "10",
c4 when "11",
'0' when others;

END arch_ALU;

