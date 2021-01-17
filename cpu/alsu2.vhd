Library ieee;
use ieee.std_logic_1164.all;


ENTITY ALSU IS
GENERIC (m : integer := 16);
PORT( cin: IN std_logic;
	A,B : IN std_logic_vector (m-1 DOWNTO 0);		
	sel : IN std_logic_vector (3 DOWNTO 0);
	F : OUT std_logic_vector (m-1 DOWNTO 0);
	cout: OUT std_logic;
	z_flag: OUT std_logic;
	n_flag: OUT std_logic
);
END ALSU;

ARCHITECTURE arch_ALSU OF ALSU IS
COMPONENT my_nadder IS
GENERIC (n : integer := 16);
 PORT   (a, b : IN std_logic_vector(n-1 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(n-1 DOWNTO 0);
             cout : OUT std_logic);
end component my_nadder;

SIGNAL  F_sig,B_inv : std_logic_vector (15 DOWNTO 0);
SIGNAL  op_2,ADD1,ADC1,SUB1,SBC1,AND1, XOR1, OR1, CMP1 : std_logic_vector (15 DOWNTO 0);
SIGNAL c1,c2,c3,c4,cin_inv : std_logic;
signal N_BUS : std_logic_vector (2 downto 0);

Begin
-- utilities
cin_inv <= not(cin);
F <= F_sig;
B_inv <= not(b);


-- functions
u0: my_nadder GENERIC MAP (n => m) PORT MAP (A,B,'0',ADD1,c1); -- ADD
u1: my_nadder GENERIC MAP (n => m) PORT MAP (A,B,cin,ADC1,c2); -- ADC
u2: my_nadder GENERIC MAP (n => m) PORT MAP (A,B_inv,'1',SUB1,c3); -- A-B SUB
u3: my_nadder GENERIC MAP (n => m) PORT MAP (A, B_inv,cin_inv,SBC1,c4); -- A-B-C SBC
AND1 <= a and b;
XOR1 <= a xor b;
OR1  <= a or b;

With sel select
F_sig <= ADD1 when "0100", -- ADD
ADC1 when "0101", -- ADC
SUB1 when "0110", -- SUB
SBC1  when "0111", -- SBC
AND1 when "1000", -- AND
OR1 when "1001", -- OR
XOR1 when "1010", -- XOR
SUB1 when "1011", -- CMP
(others => '0') when others;

-- flags
N_BUS <= (a(15),b(15),F_sig(15));

With N_BUS select
n_flag <= '1' when "001", 
'1' when "110", 
'0' when others;

z_flag <= F_sig(15);

With sel select
cout <= c1 when "0100", -- ADD
c2 when "0101", -- ADC
c3 when "0110", -- SUB
c4 when "0111", -- SBC
'0'when others;

END arch_ALSU;
