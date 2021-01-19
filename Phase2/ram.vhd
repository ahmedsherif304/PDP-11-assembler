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
0   =>      "0011010111000110",--mov 100,r6
1   =>      "0000000001100100",--100
2   =>      "0011010111000010",--mov 10,r2
3   =>      "0000000000001010",--10
4   =>      "0011110010000110",
5   =>      "0000000000000100",
6   =>      "0100110010000010",
7   =>      "0000000000000100",
8   =>      "0000001100000100",
9   =>      "0000001100000100",
10  =>      "0010001000000000",
11  =>      "1011000100000100",
12  =>      "0001010111111100",
13  =>      "0010000000000000",
14  =>      "0000000000001010",
others => "0000000000000000"
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

