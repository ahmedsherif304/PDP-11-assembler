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

begin
		process(NEXT_ADDRESS,OR_BIT,IR) is
		  Begin
			if OR_BIT = "001" then 
				uAR <= NEXT_ADDRESS; 
				uAR(5 downto 4) <= IR(5 downto 4);
				uAR(3) <= IR(3) and (not IR(4)) and (not IR(5));
			elsif OR_BIT = "010" then
				uAR <= NEXT_ADDRESS;
				uAR(0) <= not IR(9);
			elsif OR_BIT = "011" then
				uAR <= NEXT_ADDRESS;
				uAR(0) <= not IR(3);
			elsif OR_BIT = "100" then
				uAR <= NEXT_ADDRESS;
				uAR(0) <= (not IR(3)) and (not IR(4)) and (not IR(5));
			elsif OR_BIT = "111" and IR(15 downto 12) = "0000"then
				uAR <= NEXT_ADDRESS;
				uAR(2 downto 0) <= IR(10 downto 8);
				uAR(3) <= IR(11);
				uAR(8 downto 6) <= "100";
			elsif OR_BIT = "111" then
				uAR <= NEXT_ADDRESS;
				uAR(2 downto 0) <= IR(14 downto 12);
				uAR(3) <= IR(15);
			elsif OR_BIT = "000" then	-- do nothing
				uAR <= "000000000";
			end if;
		end process;
end OR_Arc;
