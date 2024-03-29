Library ieee;
use ieee.std_logic_1164.all;

Entity CU is
port(  	
		CLK,RST: in std_logic;
		IR : in std_logic_vector(15 downto 0);
		Z_flag : in std_logic;
		N_flag : in std_logic;
		C_flag : in std_logic;
		-- F1 signals --
		PCout,MDRout,Zout,SrcOut,DstOut :out std_logic;
		-- F2 signals --
		PCin,IRin,Zin : out std_logic;
		-- F3 signals --
		MARin,MDRin : out std_logic;
		-- F4 signals --
		Yin,SRCin,DSTin : out std_logic;
		-- F5 signals --
		ALU : out std_logic_vector(3 downto 0); --decoder ytl3ly el operation ely hat7sal
		-- F6 signals --
		RE_AD,Wr_ite : out std_logic;
		-- F7 signal --
		ClearY : out std_logic;
		-- F8 signal --
		Carryin : out std_logic;
		-- F9 signal --
		WMFC : out std_logic;
		R0in,R0out,R1in,R1out,R2in,R2out,R3in,R3out,R4in,R4out,R5in,R5out,R6in,R6out,R7in,R7out : out std_logic); 
end CU;

Architecture CU_Arc of CU is

	Component DECODING_CIRCUIT is
	port(  
		OR_BIT: in std_logic_vector(2 downto 0);
		Enable: in std_logic;
		NEXT_ADDRESS:in std_logic_vector(8 downto 0);
		IR: in std_logic_vector(15 downto 0);
		Z_flag : in std_logic;
		N_flag : in std_logic;
		C_flag : in std_logic;
		NEW_uAR:out std_logic_vector(8 downto 0) );		
	end component;
	Component nreg is
	generic(n: integer := 16);
    	port(
        clk, rst, en: in std_logic;
        d: in std_logic_vector(n-1 downto 0);
        q: out std_logic_vector(n-1 downto 0));
	end Component;
	Component ROM is
	port (
		clk : in std_logic;
		uAR : in std_logic_vector(8 downto 0);
		CW : out std_logic_vector(31 downto 0) );
	end Component;
	------------------------------------------------
	Component dec is
	generic(n: integer := 2);
    	port(
        	en: in std_logic;
        	a: in std_logic_vector(n-1 downto 0);
        	b: out std_logic_vector((2**n)-1 downto 0)
    		);
	end Component;
	---------------------------------------------------------
	
signal 	CW : std_logic_vector (31 downto 0);	-- Control Word
signal 	uAR, uAR_in,	NEXT_ADDRESS : std_logic_vector (8 downto 0);
signal Rsrcout,Rdstout,Rsrcin,Rdstin : std_logic;
signal OR_BIT : std_logic_vector(2 downto 0);
signal PLA_ENABLE : std_logic;
signal SRCout_reg,DSTout_reg,SRCin_reg,DSTin_reg : std_logic_vector(7 downto 0);
signal F1,F2 : std_logic_vector(7 downto 0);
signal F3,F4,F6 : std_logic_vector(3 downto 0);
begin

	-- uAR register --
	uAR_r: nreg generic map(9) port map(CLK,RST,'1',uAR_in,uAR);	-- uAR
	-- Decoding Cercuit component --
	dec_cercuit_comp:DECODING_CIRCUIT port map(OR_BIT,PLA_ENABLE,NEXT_ADDRESS,IR,Z_flag,N_flag,C_flag,uAR_in);
	-- ROM component --
	rom_comp:ROM port map(CLK,uAR,CW);


	-- control signal decoders
	F1_dec: dec generic map(3) port map('1',CW(22 downto 20),F1);
	F2_dec: dec generic map(3) port map('1',CW(19 downto 17),F2);
	F3_dec: dec generic map(2) port map('1',CW(16 downto 15),F3);
	F4_dec: dec generic map(2) port map('1',CW(14 downto 13),F4);
	F6_dec: dec generic map(2) port map('1',CW(8 downto 7),F6);
	Rsrcout_dec:dec generic map(3) port map(Rsrcout,IR(8 downto 6),SRCout_reg);
	Rdstout_dec:dec generic map(3) port map(Rdstout,IR(2 downto 0),DSTout_reg);
	Rsrcin_dec:dec generic map(3) port map(Rsrcin,IR(8 downto 6),SRCin_reg);
	Rdstin_dec:dec generic map(3) port map(Rdstin,IR(2 downto 0),DSTin_reg);


-- assignment of all control signals by the results of the decoders
	
	-- Registers in --
	R0in <= SRCin_reg(0) or DSTin_reg(0);
	R1in <= SRCin_reg(1) or DSTin_reg(1);
	R2in <= SRCin_reg(2) or DSTin_reg(2);
	R3in <= SRCin_reg(3) or DSTin_reg(3);
	R4in <= SRCin_reg(4) or DSTin_reg(4);
	R5in <= SRCin_reg(5) or DSTin_reg(5);
	R6in <= SRCin_reg(6) or DSTin_reg(6);
	R7in <= SRCin_reg(7) or DSTin_reg(7);
	-- Registers out --
	R0out <= SRCout_reg(0) or DSTout_reg(0);
	R1out <= SRCout_reg(1) or DSTout_reg(1);
	R2out <= SRCout_reg(2) or DSTout_reg(2);
	R3out <= SRCout_reg(3) or DSTout_reg(3);
	R4out <= SRCout_reg(4) or DSTout_reg(4);
	R5out <= SRCout_reg(5) or DSTout_reg(5);
	R6out <= SRCout_reg(6) or DSTout_reg(6);
	R7out <= SRCout_reg(7) or DSTout_reg(7);
	-- F0 signals --
	NEXT_ADDRESS <= CW(31 downto 23);
	
	-- F1 signals --
	PCout <= F1(1);
	MDRout <= F1(2);
	Zout <= F1(3);
	Rsrcout <= F1(4);
	Rdstout <= F1(5);
	SrcOut <= F1(6);
	DstOut <= F1(7);
	-- F2 signals --
	PCin <= F2(1);
	IRin <= F2(2);
	Zin <= F2(3);
	Rsrcin <= F2(4);
	Rdstin <= F2(5);
	-- F3 signals --
	MARin <= F3(1);
	MDRin <= F3(2);
	-- F4 signals --
	Yin <= F4(1);
	SRCin <= F4(2);
	DSTin <= F4(3);
	-- F5 signal --
	ALU <=CW(12 downto 9);
	
	-- F6 signals --
	RE_AD <= F6(1);
	Wr_ite <= F6(2);
	
	-- F7 signals -- 
	ClearY <= CW(6);
	
	-- F8 signals --
	Carryin <= CW(5);
	
	-- F9 signals --
	WMFC <= CW(4);
	
	-- F10 signals --
	OR_BIT <= CW(3 downto 1);
	
	-- F11 signals --
	PLA_ENABLE <= CW(0);
	
end CU_Arc;