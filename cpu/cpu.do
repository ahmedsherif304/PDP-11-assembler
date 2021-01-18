vsim work.cpu
# vsim 
# Start time: 23:31:48 on Jan 18,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.cpu(cpu_arc)
# Loading work.nreg(arch)
# Loading work.tristate(arch)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncrama)
# Loading work.alsu(arch_alsu)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.cu(cu_arc)
# Loading work.decoding_circuit(decoding_circuit_arc)
# Loading work.pla(pla_arc)
# Loading work.bitoring(or_arc)
# Loading work.rom(rom_arc)
# Loading work.dec(arch)
# ** Warning: Design size of 11062 statements or 115 leaf instances exceeds ModelSim PE Student Edition recommended capacity.
# Expect performance to be quite adversely affected.
add wave -position insertpoint  \
sim:/cpu/mem_data \
sim:/cpu/internal_CLK \
sim:/cpu/data_bus \
sim:/cpu/addressOut \
sim:/cpu/Zout \
sim:/cpu/Zin \
sim:/cpu/Zero \
sim:/cpu/Z \
sim:/cpu/Yin \
sim:/cpu/Y_RST \
sim:/cpu/Y \
sim:/cpu/Wr_ite \
sim:/cpu/WMFC \
sim:/cpu/SrcOut \
sim:/cpu/SRCin \
sim:/cpu/SRC \
sim:/cpu/RST \
sim:/cpu/RE_AD \
sim:/cpu/R6out \
sim:/cpu/R6in \
sim:/cpu/R6 \
sim:/cpu/R5out \
sim:/cpu/R5in \
sim:/cpu/R5 \
sim:/cpu/R4out \
sim:/cpu/R4in \
sim:/cpu/R4 \
sim:/cpu/R3out \
sim:/cpu/R3in \
sim:/cpu/R3 \
sim:/cpu/R2out \
sim:/cpu/R2in \
sim:/cpu/R2 \
sim:/cpu/R1out \
sim:/cpu/R1in \
sim:/cpu/R1 \
sim:/cpu/R0out \
sim:/cpu/R0in \
sim:/cpu/R0 \
sim:/cpu/PCout \
sim:/cpu/PCin \
sim:/cpu/PC \
sim:/cpu/Negative \
sim:/cpu/MDRout \
sim:/cpu/MDRin \
sim:/cpu/MDR_input \
sim:/cpu/MDR_E \
sim:/cpu/MDR \
sim:/cpu/MARin \
sim:/cpu/MAR \
sim:/cpu/IRin \
sim:/cpu/IR_Address \
sim:/cpu/IR \
sim:/cpu/FLAGS \
sim:/cpu/DstOut \
sim:/cpu/DSTin \
sim:/cpu/DST \
sim:/cpu/Cout \
sim:/cpu/ClearY \
sim:/cpu/Carryin \
sim:/cpu/CLK \
sim:/cpu/ALU_out \
sim:/cpu/ALU \
sim:/cpu/ALSU_Flags
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
# 
#           File in use by: mohammed  Hostname: DESKTOP-ME73TCT  ProcessID: 13640
# 
#           Attempting to use alternate WLF file "./wlftje04fb".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
# 
#           Using alternate file: ./wlftje04fb
# 
force -freeze sim:/cpu/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu/RST 1 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(7)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(6)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(5)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(4)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstin_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(7)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(6)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(5)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(4)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcin_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(7)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(6)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(5)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(4)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rdstout_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(7)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(6)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(5)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(4)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/Rsrcout_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F6_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F6_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F6_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F6_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F4_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F4_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F4_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F4_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F3_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F3_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F3_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F3_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(7)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(6)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(5)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(4)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F2_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(7)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(6)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(5)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(4)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(3)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(2)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(1)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Region: /cpu/CU_comp/F1_dec/lop(0)
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ns  Iteration: 0  Instance: /cpu/Ram_comp
force -freeze sim:/cpu/RST 0 0
run
run
run
run
run
run
run
run