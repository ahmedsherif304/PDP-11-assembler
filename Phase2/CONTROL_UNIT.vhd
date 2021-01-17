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
		PCout,MDRout,Zout,RsrcOut,RdstOut,SrcOut,DstOut :out std_logic;
		-- F2 signals --
		PCin,IRin,Zin,Rsrcin,Rdstin : out std_logic;
		-- F3 signals --
		MARin,MDRin : out std_logic;
		-- F4 signals --
		Yin,SRCin,DSTin : out std_logic;
		-- F5 signals --
		ALU : out std_logic_vector(4 downto 0); --decoder ytl3ly el operation ely hat7sal
		-- F6 signals --
		RE_AD,Wr_ite : out std_logic;
		-- F7 signal --
		ClearY : out std_logic;
		-- F8 signal --
		Carryin : out std_logic;
		-- F9 signal --
		WMFC : out std_logic;
		--F10--------
		OR_BIT : out std_logic_vector(2 downto 0);
		--F11--------
		PLA_ENABLE : out std_logic;
		R0in,R0out,R1in,R1out,R2in,R2out,R3in,R3out,R4in,R4out,R5in,R5out,R6in,R6out,R7in : out std_logic); 
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
	--todo---------------
	Component my_nDFF is
	Generic ( n : integer := 16);
	port( Clk,Rst,EN : in std_logic;
	d : in std_logic_vector(n-1 downto 0);
	q : out std_logic_vector(n-1 downto 0));
	end Component;
	-----------------------------------
	Component ROM is
	port (
		clk : in std_logic;
		uAR : in std_logic_vector(8 downto 0);
		CW : out std_logic_vector(31 downto 0) );
	end Component;
	------------------------------------------------
	Component my_2x4Decoder is
	port(A : in std_logic_vector(1 downto 0);
		E : in std_logic;
		D : out std_logic_vector(3 downto 0));
	end Component;

	Component my_3x8Decoder is
	port(A : in std_logic_vector(2 downto 0);
		E : in std_logic;
		D : out std_logic_vector(7 downto 0));
	end Component;
	
	Component my_4x16Decoder is
	port(A : in std_logic_vector(3 downto 0);
		E : in std_logic;
		D : out std_logic_vector(15 downto 0));
	end Component;
	---------------------------------------------------------
	
signal 	CW : std_logic_vector (31 downto 0);	-- Control Word
signal 	uAR,uAR_in,NEXT_ADDRESS : std_logic_vector (7 downto 0);
signal Rsrcout,Rdstout,Rsrcin,Rdstin : std_logic;
signal ORdst,ORindsrc,ORinddst,ORresult,OR2op,ORop,OR1op : std_logic;
signal PLAout :std_logic;
signal SRCout_reg,DSTout_reg,SRCin_reg,DSTin_reg : std_logic_vector(3 downto 0);
signal F1 : std_logic_vector(15 downto 0);
signal F2,F10 : std_logic_vector(7 downto 0);
signal F3,F4,F6 : std_logic_vector(3 downto 0);

begin

	-- uAR register --
	uAR_r: my_nDFF generic map(8) port map(CLK,RST,'1',uAR_in,uAR);	-- uAR
	-- Decoding Cercuit component --
	dec_cercuit_comp:DECODING_CIRCUIT port map(ORresult,ORinddst,ORindsrc,ORdst,OR2op,ORop,OR1op,PLAout,NEXT_ADDRESS,IR,Z_flag,uAR_in);
	-- ROM component --
	rom_comp:rom port map(CLK,uAR,CW);


	-- control signal decoders
	F1_dec: my_4x16Decoder port map(CW(23 downto 20),'1',F1);
	F2_dec: my_3x8Decoder port map(CW(19 downto 17),'1',F2);
	F3_dec: my_2x4Decoder port map(CW(16 downto 15),'1',F3);
	F4_dec: my_2x4Decoder port map(CW(14 downto 13),'1',F4);
	F6_dec: my_2x4Decoder port map(CW(8 downto 7),'1',F6);
	F10_dec: my_3x8Decoder port map(CW(3 downto 1),'1',F10);
	Rsrcout_dec:my_2x4Decoder port map(IR(6 downto 5),Rsrcout,SRCout_reg);
	Rdstout_dec:my_2x4Decoder port map(IR(1 downto 0),Rdstout,DSTout_reg);
	Rsrcin_dec:my_2x4Decoder port map(IR(6 downto 5),Rsrcin,SRCin_reg);
	Rdstin_dec:my_2x4Decoder port map(IR(1 downto 0),Rdstin,DSTin_reg);


-- assignment of all control signals by the results of the decoders
	
	-- Registers in --
	R0in <= SRCin_reg(0) or DSTin_reg(0);
	R1in <= SRCin_reg(1) or DSTin_reg(1);
	R2in <= SRCin_reg(2) or DSTin_reg(2);
	
	-- Registers out --
	R0out <= SRCout_reg(0) or DSTout_reg(0);
	R1out <= SRCout_reg(1) or DSTout_reg(1);
	R2out <= SRCout_reg(2) or DSTout_reg(2);

	
	-- F0 signals --
	NEXT_ADDRESS <= CW(31 downto 24);
	
	-- F1 signals --
	PCout  <= F1(1) or SRCout_reg(3) or DSTout_reg(3);
	MDRout <= F1(2);
	Zout   <= F1(3);
	Rsrcout<= F1(4);
	Rdstout<= F1(5);
	SPout  <= F1(6);
	SRCout <= F1(8);
	DSTout <= F1(9);
	TMPout <= F1(10);
	Addressout<= F1(11);
	
	-- F2 signals --
	PCin <= F2(1) or SRCin_reg(3) or DSTin_reg(3);
	IRin <= F2(2);
	Zin  <= F2(3);
	Rsrcin<= F2(4);
	Rdstin<= F2(5);
	SPin <= F2(6);
	
	-- F3 signals --
	MARin <= F3(1);
	MDRin <= F3(2);
	TMPin <= F3(3);
	
	-- F4 signals --
	Yin <= F4(1);
	SRCin<= F4(2);
	DSTin<= F4(3);
	
	-- F5 signal --
	ALSUin<=CW(12 downto 9);
	
	-- F6 signals --
	R <= F6(1);
	W <= F6(2);
	HLT <= F6(3);
	
	-- F7 signals -- 
	ClearY <= CW(6);
	
	-- F8 signals --
	Carryin <= CW(5);
	
	-- F9 signals --
	FLAGS_E <= CW(4);
	
	-- F10 signals --
	ORdst <= F10(1);
	ORindsrc <= F10(2);
	ORinddst <= F10(3);
	ORresult <= F10(4);
	OR2op <= F10(5);
	ORop <= F10(6);
	OR1op <= F10(7);
	
	-- F11 signals --
	PLAout <= CW(0);
	
end CU_Arc;
