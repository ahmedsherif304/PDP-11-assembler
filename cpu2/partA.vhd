Library ieee;
use ieee.std_logic_1164.all;

entity partA is
GENERIC (k : integer := 16);
port(
A,B : IN std_logic_vector (k-1 DOWNTO 0);
cin: IN std_logic;
S : IN std_logic_vector (1 DOWNTO 0);
F : OUT std_logic_vector (k-1 DOWNTO 0);
cout: OUT std_logic
);
end entity;

Architecture arch_partA of partA is
COMPONENT my_nadder IS
GENERIC (n : integer := 16);
 PORT   (a, b : IN std_logic_vector(n-1 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(n-1 DOWNTO 0);
             cout : OUT std_logic);
end component my_nadder;
Signal F1,F2,F3,F4,F5,B_inv: std_logic_vector(15 DOWNTO 0);
signal c1,c2,c3,c4,c5: std_logic;
signal Z_BUS : std_logic_vector (2 downto 0);
  begin
u0: my_nadder GENERIC MAP (n => k) PORT MAP (A,( others => '0'),cin,F1,c1); -- ok
u1: my_nadder GENERIC MAP (n => k) PORT MAP (A,B,cin,F2,c2);	-- A+B A+B+1
u2: my_nadder GENERIC MAP (n => k) PORT MAP (A,B_inv,'1',F3,c3); -- A-B
u3: my_nadder GENERIC MAP (n => k) PORT MAP (F3, (others => '0') ,'0',F4,c4); -- A-B-1
u4: my_nadder GENERIC MAP (n => k) PORT MAP (A, (others => '0'),'0',F5,c5); -- A-1

B_inv <= not(B);

Z_BUS <= (S(1),S(0),cin);

With Z_BUS select
cout <= c1 when "000", -- A
c1 when "001", -- A+1
c2 when "010", -- 
c2 when "011",
c4 when "100",
c3 when "101",
c5 when "110",
'0' when "111",
'0' when others;

With Z_BUS select
F <= F1 when "000", -- A
F1 when "001", -- A+1
F2 when "010", --A+B 
F2 when "011", -- A+B+1
F4 when "100", -- A-B-1
F3 when "101", -- A-B
F5 when "110", -- A-1
(others => '0') when "111", -- A-1
(others => '0') when others;


end Architecture;