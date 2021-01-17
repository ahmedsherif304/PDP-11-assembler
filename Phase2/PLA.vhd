library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


Entity PLA is
port (
Enable : in std_logic;
IR : in std_logic_vector(15 downto 0);
Z_flag : in std_logic;
N_flag : in std_logic;
C_flag : in std_logic;
uAR : out std_logic_vector(8 downto 0));
end entity PLA;

architecture PLA_Arc of PLA is

signal TWOOPERAND : std_logic_vector (8 downto 0);
signal ONEOPERAND : std_logic_vector (8 downto 0);
begin

TWOOPERAND(8 downto 6)<="000";
TWOOPERAND(2 downto 0)<="000";
TWOOPERAND(5)<=IR(11);
TWOOPERAND(4)<=IR(10);
TWOOPERAND(3)<=IR(9) and (not IR(10)) and (not IR(11));

ONEOPERAND(8 downto 6)<="000";
ONEOPERAND(2 downto 0)<="000";
ONEOPERAND(5)<=IR(5);
ONEOPERAND(4)<=IR(4);
ONEOPERAND(3)<=IR(3) and (not IR(4)) and (not IR(5));


uAR<="010000001" or ONEOPERAND when IR(15 downto 12)="0000" and Enable = '1'	--one operand instructions
else "000000011" when IR(15 downto 9)="0010000" and Enable = '1' 		--HLT (Halt)
else "000000100" when IR(15 downto 9)="0010001" and Enable = '1'		--NOP (No operation)
else "000000101" when IR(15 downto 8)="00010101" and Enable = '1' 	--BNE
else "001000001" or TWOOPERAND when Enable = '1'	--two operand instructions
else "000000000";
end architecture PLA_Arc;
