LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
GENERIC (n : integer := 16);
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(n-1 DOWNTO 0);
		dataout : OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS
	TYPE ram_type IS ARRAY(0 TO 2047) OF std_logic_vector(n-1 DOWNTO 0);
signal ram : ram_type := (
0   =>  "0000000011100000",	-- Mov @(R3),R0
1   =>  "0000000011000001",	-- Mov @(R2),R1
others => "1100000000000001"
);
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF we = '1' THEN
						ram(to_integer(unsigned(address))) <= datain;
					END IF;
				END IF;
		END PROCESS;
		dataout <= ram(to_integer(unsigned(address)));
END syncrama;

