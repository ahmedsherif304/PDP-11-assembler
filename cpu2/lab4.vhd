LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab4 IS
	GENERIC (k : integer := 32);
	PORT(ES, ED, clk,rst: IN std_logic;
	src,dst : IN std_logic_vector(1 DOWNTO 0));
END lab4;

ARCHITECTURE arch_lab4 OF lab4 IS
signal count_sig:std_logic_vector(5 DOWNTO 0);
signal not_ed : std_logic;
signal data_in_bus, data_out_bus, lab3_bus: std_logic_vector(31 DOWNTO 0);

COMPONENT ram IS
GENERIC (n : integer := 32);
PORT(
	clk : IN std_logic;
	we  : IN std_logic;
	address : IN  std_logic_vector(5 DOWNTO 0);
	datain  : IN  std_logic_vector(n-1 DOWNTO 0);
	dataout : OUT std_logic_vector(n-1 DOWNTO 0));

END COMPONENT ram;


component lab3 IS
	GENERIC (k : integer := 32);
	PORT(ES, ED, clk, rst: IN std_logic;
	src,dst : IN std_logic_vector(1 DOWNTO 0);
	data : INOUT std_logic_vector(k-1 DOWNTO 0));
END component lab3;


BEGIN
not_ed <= not ed;
l0: lab3 generic map(32) port map(ES,ED,clk,rst,src,dst,lab3_bus);
m0: ram generic map(32) port map(clk, not_ed, count_sig,data_in_bus ,data_out_bus);
data_in_bus <= lab3_bus when ED = '0'  else (others => 'Z');
lab3_bus <= data_out_bus when ES = '0' else (others => 'Z');

PROCESS (clk,src, dst, ES, ED, rst)
	variable counter:INTEGER RANGE 0 TO 63;
	BEGIN 
		
		IF rst = '1' THEN
		counter := 10;
		ELSIF rising_edge(clk) THEN
		counter := counter - 1;
		END IF;
		count_sig <= std_logic_vector(to_unsigned(counter,count_sig'length));
END PROCESS;



END arch_lab4;
