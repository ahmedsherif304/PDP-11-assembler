Library ieee;
use ieee.std_logic_1164.all;
Entity DECODING_CIRCUIT is
port(  
OR_BIT: in std_logic_vector(2 downto 0);
Enable: in std_logic;
NEXT_ADDRESS:in std_logic_vector(8 downto 0);
IR: in std_logic_vector(15 downto 0);
Z_flag : in std_logic;
N_flag : in std_logic;
C_flag : in std_logic;
NEW_uAR:out std_logic_vector(8 downto 0) );
		
end entity DECODING_CIRCUIT;

Architecture DECODING_CIRCUIT_Arc of DECODING_CIRCUIT is
component PLA is
	port (
		Enable : in std_logic;
		IR : in std_logic_vector(15 downto 0);
		Z_flag : in std_logic;
		N_flag : in std_logic;
		C_flag : in std_logic;
		uAR : out std_logic_vector(8 downto 0));
	end component;

component BITORING is
	 port( 
		IR : in std_logic_vector( 15 downto 0);
		NEXT_ADDRESS : in std_logic_vector(8 downto 0);
		OR_BIT: in std_logic_vector(2 downto 0);
		uAR : out std_logic_vector(8 downto 0));
	end component;
	
	signal PLA_OUT:std_logic_vector(8 downto 0);
	signal OR_OUT:std_logic_vector(8 downto 0);
	
begin
PLA0:PLA port map(Enable,IR,Z_flag,N_flag,C_flag,PLA_OUT);
BITORING0: BITORING port map(IR,NEXT_ADDRESS,OR_BIT,OR_OUT);
NEW_uAR<= PLA_OUT or OR_OUT;

end DECODING_CIRCUIT_Arc;
