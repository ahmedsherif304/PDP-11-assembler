vsim work.alu
# vsim 
# Start time: 19:56:41 on Oct 30,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alu(arch_alu)
# ** Warning: (vsim-3473) Component instance "u0 : portB" is not bound.
#    Time: 0 ns  Iteration: 0  Instance: /alu File: D:/3rd-year-1st-semster/computer architecture/labs/lab1/design/ALU.vhd
# ** Warning: (vsim-3473) Component instance "u1 : portC" is not bound.
#    Time: 0 ns  Iteration: 0  Instance: /alu File: D:/3rd-year-1st-semster/computer architecture/labs/lab1/design/ALU.vhd
# ** Warning: (vsim-3473) Component instance "u2 : portD" is not bound.
#    Time: 0 ns  Iteration: 0  Instance: /alu File: D:/3rd-year-1st-semster/computer architecture/labs/lab1/design/ALU.vhd
add wave -position insertpoint  \
sim:/alu/cin \
sim:/alu/A \
sim:/alu/B \
sim:/alu/sel \
sim:/alu/F \
sim:/alu/cout
force -freeze sim:/alu/sel 4'h4 0
force -freeze sim:/alu/A 16'hf00f 0
force -freeze sim:/alu/B 16'h000a 0
force -freeze sim:/alu/cin 0 0
run
force -freeze sim:/alu/sel 4'h5 0
run
force -freeze sim:/alu/sel 4'h6 0
run
force -freeze sim:/alu/sel 4'h7 0
run
force -freeze sim:/alu/sel 4'h8 0
run
force -freeze sim:/alu/sel 4'h9 0
run
force -freeze sim:/alu/sel 4'ha 0
run
force -freeze sim:/alu/cin 1 0
run
force -freeze sim:/alu/sel 4'hB 0
run
force -freeze sim:/alu/cin 0 0
force -freeze sim:/alu/sel 4'hC 0
run
force -freeze sim:/alu/sel 4'hD 0
run
force -freeze sim:/alu/sel 4'hE 0
run
force -freeze sim:/alu/cin 1 0
run
force -freeze sim:/alu/sel 4'hF 0
run