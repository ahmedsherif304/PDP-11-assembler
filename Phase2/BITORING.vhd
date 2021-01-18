Library ieee;

Use ieee.std_logic_1164.all;

entity BITORing is
	port( IR : in std_logic_vector( 15 downto 0);
	NEXT_ADDRESS : in std_logic_vector(8 downto 0);
	OR_BIT: in std_logic_vector(2 downto 0);
	uAR : out std_logic_vector(8 downto 0)
	);
end entity BITORing;

architecture OR_Arc of BITORing is

signal tmp_NEXT_ADDRESS : std_logic_vector( 7 downto 0);
signal tmp_signal : std_logic_vector( 17 downto 0);

begin
	uAR <= NEXT_ADDRESS;
		process(NEXT_ADDRESS,OR_BIT,IR) is
		  Begin
			if OR_BIT = "001" then  
				uAR(5 downto 4) <= IR(5 downto 4);
				uAR(3) <= IR(3) and (not IR(4)) and (not IR(5));
			elsif OR_BIT = "010" then
				uAR(0) <= not IR(9);
			elsif OR_BIT = "011" then
				uAR(0) <= not IR(3);
			elsif OR_BIT = "100" then
				uAR(0) <= (not IR(3)) and (not IR(4)) and (not IR(5));
			elsif OR_BIT = "000" then
				uAR <= "000000000";
			end if;
		end process;
end OR_Arc;