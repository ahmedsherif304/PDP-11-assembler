vsim work.partd
# vsim 
# Start time: 17:37:06 on Oct 30,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.partd(arch_partd)
add wave -position insertpoint  \
sim:/partd/A \
sim:/partd/cin \
sim:/partd/S \
sim:/partd/F \
sim:/partd/cout
force -freeze sim:/partd/A 16'hf00f 0
force -freeze sim:/partd/cin 0 0
force -freeze sim:/partd/S 2'h0 0
run
force -freeze sim:/partd/S 2'h1 0
run
force -freeze sim:/partd/S 2'h2 0
run
force -freeze sim:/partd/cin 1 0
run
force -freeze sim:/partd/S 2'h3 0
run