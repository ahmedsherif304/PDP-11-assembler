LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity lab3 IS
	GENERIC (k : integer := 32);
	PORT(ES, ED, clk,rst: IN std_logic;
	src,dst : IN std_logic_vector(1 DOWNTO 0);
	data : INOUT std_logic_vector(k-1 DOWNTO 0));
END lab3;

ARCHITECTURE arch_lab3 OF lab3 IS

COMPONENT decoder IS
	PORT(enable: IN std_logic;
	s : IN std_logic_vector(1 DOWNTO 0);
	result : OUT std_logic_vector(3 DOWNTO 0));
END COMPONENT decoder;

COMPONENT nRegister IS
GENERIC (n : integer := k);
PORT(clk,E_OUT,E_IN,rst: IN std_logic;
data : INOUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT nRegister;

signal IN_EN_BUS : std_logic_vector (3 downto 0);
signal OUT_EN_BUS : std_logic_vector (3 downto 0);
BEGIN

d0: decoder PORT MAP (ES,src,OUT_EN_BUS); 
d1: decoder PORT MAP (ED,dst,IN_EN_BUS); 
r0: nRegister GENERIC MAP(k) PORT MAP (clk, OUT_EN_BUS(0),IN_EN_BUS(0), rst, data);
r1: nRegister GENERIC MAP(k) PORT MAP (clk, OUT_EN_BUS(1),IN_EN_BUS(1), rst, data);
r2: nRegister GENERIC MAP(k) PORT MAP (clk, OUT_EN_BUS(2),IN_EN_BUS(2), rst, data);
r3: nRegister GENERIC MAP(k) PORT MAP (clk, OUT_EN_BUS(3),IN_EN_BUS(3), rst, data);

END arch_lab3;