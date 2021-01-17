
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity nRegister IS

GENERIC (n : integer := 16);
	PORT(clk,E_OUT,E_IN,rst: IN std_logic;
	data : INOUT std_logic_vector(n-1 DOWNTO 0));
END nRegister;

ARCHITECTURE nRegister_arch OF nRegister IS
BEGIN
	PROCESS (clk,E_OUT,E_IN,data,rst)
	variable temp: std_logic_vector(n-1 DOWNTO 0);
	BEGIN 
		IF rst = '1' THEN
		temp:=(others => '0');
		ELSIF rising_edge(clk) and E_IN = '1' THEN
		temp := data;
		END IF;

		IF E_OUT = '1' THEN
		data <= temp;
		ELSIF E_OUT = '0' THEN
		data <= (others => 'Z');
		END IF;
		

	END PROCESS;

END nRegister_arch;