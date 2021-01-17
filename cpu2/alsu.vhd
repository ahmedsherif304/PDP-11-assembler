Library ieee;
use ieee.std_logic_1164.all;


ENTITY ALSU IS
GENERIC (m : integer := 16);
PORT( cin: IN std_logic;
	A,B : IN std_logic_vector (m-1 DOWNTO 0);		
	sel : IN std_logic_vector (3 DOWNTO 0);
	F : OUT std_logic_vector (m-1 DOWNTO 0);
	cout: OUT std_logic);
END ALSU;

ARCHITECTURE arch_ALSU OF ALSU IS
COMPONENT partB IS
GENERIC (n : integer := 16);
port(
A,B : IN std_logic_vector (n-1 DOWNTO 0);
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (n-1 DOWNTO 0)
);
END COMPONENT partB;

COMPONENT partC IS
GENERIC (n : integer := 16);
port(
A : IN std_logic_vector (n-1 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (n-1 DOWNTO 0);
cout: OUT std_logic
);
END COMPONENT partC;

COMPONENT partD IS
GENERIC (n : integer := 16);
port(
A : IN std_logic_vector (n-1 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (n-1 DOWNTO 0);
cout: OUT std_logic
);
END COMPONENT partD;

COMPONENT partA IS
GENERIC (k : integer := 16);
port(
A,B : IN std_logic_vector (k-1 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (k-1 DOWNTO 0);
cout: OUT std_logic
);
END COMPONENT partA;

SIGNAL  F1,F2,F3,F4 : std_logic_vector (15 DOWNTO 0);
SIGNAL c1,c3,c4 : std_logic;
Begin
--      u0: mux2 PORT MAP (in0,in1,sel(0),x1);
u0: partA GENERIC MAP(m) PORT MAP (A,B,cin,sel(1 DOWNTO 0),F1,c1);
u1: partB GENERIC MAP(m) PORT MAP (A,B,sel(1 DOWNTO 0),F2);
u2: partC GENERIC MAP(m) PORT MAP (A,cin,sel(1 DOWNTO 0),F3,c3);
u3: partD GENERIC MAP(m) PORT MAP (A,cin,sel(1 DOWNTO 0),F4,c4);

With sel(3 DOWNTO 2) select
F <= F1 when "00",
F2 when "01",
F3 when "10",
F4 when "11",
( others => '0') when others;


With sel(3 DOWNTO 2) select
cout <= c1 when "00",
c3 when "10",
c4 when "11",
'0' when others;

END arch_ALSU;
