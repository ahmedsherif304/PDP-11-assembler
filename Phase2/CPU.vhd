Library ieee;
use ieee.std_logic_1164.all;

Entity CPU is
port(CLK,RST: in std_logic);   
end CPU;

Architecture CPU_Arc of CPU is

	Component CU is
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
	end Component;
	--------------------------------------------
	Component ALSU  is  
		GENERIC (m : integer := 16);
		PORT( cin: IN std_logic;
			A,B : IN std_logic_vector (m-1 DOWNTO 0);		
			sel : IN std_logic_vector (3 DOWNTO 0);
			F : OUT std_logic_vector (m-1 DOWNTO 0);
			cout: OUT std_logic;
			z_flag: OUT std_logic;
			n_flag: OUT std_logic
			);
	end Component ;
	------------------------------------------------------
	Component nreg is
	generic(n: integer := 16);
    	port(
        	clk, rst, en: in std_logic;
        	d: in std_logic_vector(n-1 downto 0);
        	q: out std_logic_vector(n-1 downto 0)
    	);
	end Component;

	Component tristate is
    	generic(n: integer := 32);
    	port(
        	en: in std_logic;
        	inp: in std_logic_vector(n-1 downto 0);
        	oup: out  std_logic_vector(n-1 downto 0)
    	);
	end Component;

	component ram is
	 GENERIC (n : integer := 16);
		PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(n-1 DOWNTO 0);
		dataout : OUT std_logic_vector(n-1 DOWNTO 0));
	end component;


signal data_bus : std_logic_vector(15 downto 0);
signal R0,R1,R2,R3,R4,R5,R6,PC : std_logic_vector(15 downto 0); 
signal MAR,MDR,mem_data,IR,IR_Address,ALU_out : std_logic_vector(15 downto 0);		-- ram 
signal Z,Y,SRC,DST,ALSU_Flags,FLAGS : std_logic_vector(15 downto 0);
signal internal_CLK : std_logic;		-- CLK of the ram
signal MDR_E,E_R7in,E_R7out : std_logic;	
signal MDR_input:std_logic_vector(15 downto 0);	
signal Cout,Zero,Negative,Y_RST,addressOut,InvCLK : std_logic;
-- 4 general purpose registers signals --
signal R0in,R0out,R1in,R1out,R2in,R2out,R3in,R3out,R4in,R4out,R5in,R5out,R6in,R6out,R7in,R7out: std_logic; 
	-- control signals --
	
	-- F1 signals --
signal PCout,MDRout,Zout,SrcOut,DstOut : std_logic;

	-- F2 signals --
signal PCin,IRin,Zin : std_logic;

	-- F3 signals --
signal MARin,MDRin : std_logic;

	-- F4 signals --
signal Yin,SRCin,DSTin : std_logic;

	-- F5 signals --
signal ALU : std_logic_vector(3 downto 0);

	-- F6 signals --
signal RE_AD,Wr_ite : std_logic;

	-- F7 signal --
signal ClearY : std_logic;

	-- F8 signal --
signal Carryin : std_logic;


	-- F9 signal --
signal WMFC : std_logic;

---------------------------------------------------------------------------
begin
internal_CLK<= CLK ;
R0_r: nreg generic map(16) port map(internal_CLK,RST,R0in,data_bus,R0);	
R1_r: nreg generic map(16) port map(internal_CLK,RST,R1in,data_bus,R1);	
--SPin_EN<=R2in or SPin;
R2_r: nreg generic map(16) port map(internal_CLK,RST,R2in,data_bus,R2);
R3_r: nreg generic map(16) port map(internal_CLK,RST,R3in,data_bus,R3);
R4_r: nreg generic map(16) port map(internal_CLK,RST,R4in,data_bus,R4);
R5_r: nreg generic map(16) port map(internal_CLK,RST,R5in,data_bus,R5);
R6_r: nreg generic map(16) port map(internal_CLK,RST,R6in,data_bus,R6);	
E_R7in <= PCin or R7in;
InvCLK <= not internal_CLK;
R7_r: nreg generic map(16) port map(internal_CLK,RST,E_R7in,data_bus,PC);	
	
	-- 3 special purpose registers --
SRC_r:nreg generic map(16) port map(internal_CLK,RST,SRCin,data_bus,SRC);	
DST_r:nreg generic map(16) port map(internal_CLK,RST,DSTin,data_bus,DST);	

	-- 2 ram Registers --
MDR_E <= MDRin; --or (not WMFC);
MDR_input <= data_bus when Wr_ite='1'
	else mem_data;	
MDR_r:nreg generic map(16) port map(internal_CLK,RST,WMFC,MDR_input,MDR);	
MAR_r:nreg generic map(16) port map(internal_CLK,RST,MARin,data_bus,MAR);	

	-- 3 ALSU Registers --
Y_RST <= (RST or ClearY);

Y_r:nreg generic map(16) port map(internal_CLK,Y_RST,Yin,data_bus,Y);	
Z_r:nreg generic map(16) port map(internal_CLK,RST,Zin,ALU_out,Z);	
Flag_r:nreg generic map(16) port map(internal_CLK,RST,'1',ALSU_Flags,FLAGS);	


	-- IR register --
IR_r:nreg generic map(16) port map(internal_CLK,RST,IRin,data_bus,IR);	

-------------------------------------------------------- tri_state_buffers --------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

	-- 4 general purpose registers tri_state_buffers --
R0_t: tristate generic map(16) port map(R0out,R0,data_bus);	
R1_t: tristate generic map(16) port map(R1out,R1,data_bus);	
R2_t: tristate generic map(16) port map(R2out,R2,data_bus);	
R3_t: tristate generic map(16) port map(R3out,R3,data_bus);	
R4_t: tristate generic map(16) port map(R4out,R4,data_bus);	
R5_t: tristate generic map(16) port map(R5out,R5,data_bus);	
R6_t: tristate generic map(16) port map(R6out,R6,data_bus);
E_R7out <= R7out or PCout;	
R7_t: tristate generic map(16) port map(E_R7out,PC,data_bus);	

	-- 3 special purpose registers tri_state_buffers --
SRC_t:tristate generic map(16) port map(SRCout,SRC,data_bus);	-- SRC
DST_t:tristate generic map(16) port map(DSTout,DST,data_bus);	-- DST

	-- MDR tri_state_buffer --
MDR_t:tristate generic map(16) port map(MDRout,MDR,data_bus);	-- MDR	

	-- Z register tri_state_buffer --
Z_t:tristate generic map(16) port map(Zout,Z,data_bus);	-- Z
	


	-- Addressout tri state buffer --
IR_Address<=IR and "0001111111111111";
addressOut <= '1' when IR(15 downto 12) = "0001"
	else '0';
IR_t:tristate generic map(16) port map(addressOut,IR_Address,data_bus);	-- Z

-------------------------------------------------------- Components --------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	
	-- RAM component --
Ram_comp: ram port map(internal_CLK,Wr_ite,MAR,MDR,mem_data);

	-- ALSU component --
ALSU_comp: ALSU port map(Carryin,data_bus,Y,ALU,ALU_out,Cout,Zero,Negative);
ALSU_Flags(0) <= Cout;
ALSU_Flags(1) <= Zero;
ALSU_Flags(2) <= Negative;	
	
	-- CU component -- to do check index of flags
<<<<<<< HEAD
CU_comp: CU port map(internal_CLK,RST,IR,Zero,Negative,Cout,
PCout,MDRout,Zout,SrcOut,DstOut,PCin,IRin,Zin,MARin,
MDRin,Yin,SRCin,DSTin,
ALU,
RE_AD,Wr_ite,
ClearY,Carryin,
WMFC,R0in,R0out,R1in,R1out,R2in,R2out,R3in,R3out,R4in,R4out,R5in,R5out,R6in,R6out);
=======
CU_comp: CU port map(internal_CLK,RST,IR,Cout,Negative,Zero,PCout,MDRout,Zout,SrcOut,DstOut,PCin,IRin,Zin,MARin,MDRin,Yin,SRCin,DSTin,ALU,RE_AD,Wr_ite,ClearY,Carryin,WMFC,R0in,R0out,R1in,R1out,R2in,R2out,R3in,R3out,R4in,R4out,R5in,R5out,R6in,R6out,R7in,R7out);
>>>>>>> 0823ba4a3f035a52a510e8272fb34c3248ebd7fa

end CPU_Arc;
