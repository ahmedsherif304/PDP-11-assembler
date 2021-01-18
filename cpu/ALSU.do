vsim work.alsu
# vsim 
# Start time: 23:33:01 on Jan 17,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alsu(arch_alsu)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# A bookmarks file was found in the current directory with 11 bookmarks
add wave -position end  sim:/alsu/sel
add wave -position end  sim:/alsu/cin
add wave -position end  sim:/alsu/B
add wave -position end  sim:/alsu/A
add wave -position end  sim:/alsu/z_flag
add wave -position end  sim:/alsu/n_flag
add wave -position end  sim:/alsu/cout
add wave -position end  sim:/alsu/F
add wave -position end  sim:/alsu/z_flag
add wave -position end  sim:/alsu/n_flag

# test add
force -freeze sim:/alsu/A 16'h0005 0
force -freeze sim:/alsu/B 16'h0004 0
force -freeze sim:/alsu/cin 0 0
force -freeze sim:/alsu/sel 4'h4 0
run
# test addc
force -freeze sim:/alsu/A 16'h0005 0
force -freeze sim:/alsu/B 16'h0004 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'h5 0
run

# test addc result A
force -freeze sim:/alsu/A 16'h0005 0
force -freeze sim:/alsu/B 16'h0004 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'h5 0
run

# test sub result 2
force -freeze sim:/alsu/A 16'h0005 0
force -freeze sim:/alsu/B 16'h0003 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'h6 0
run

# test sbc result 1
force -freeze sim:/alsu/A 16'h0005 0
force -freeze sim:/alsu/B 16'h0003 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'h7 0
run

# test and result = 00001
force -freeze sim:/alsu/A 16'h0005 0
force -freeze sim:/alsu/B 16'h0003 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'h8 0
run

# test xor zero flag result = 00000
force -freeze sim:/alsu/A 16'h0005 0
force -freeze sim:/alsu/B 16'h0005 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'hA 0
run

# test xor zero flag result = 00000
force -freeze sim:/alsu/A 16'h0F00 0
force -freeze sim:/alsu/B 16'h0005 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'h1 0
run
