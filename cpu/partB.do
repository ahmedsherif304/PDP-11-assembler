vsim work.partb
# vsim 
# Start time: 16:38:55 on Oct 30,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.partb(arch_partb)
add wave -position insertpoint  \
sim:/partb/A \
sim:/partb/B \
sim:/partb/S \
sim:/partb/F
force -freeze sim:/partb/A 16'hf00f 0
force -freeze sim:/partb/B 16'hf00f 0
force -freeze sim:/partb/B 16'h000A 0
force -freeze sim:/partb/S 2'h0 0
run
force -freeze sim:/partb/S 2'h1 0
run
force -freeze sim:/partb/S 2'h2 0
run
force -freeze sim:/partb/S 2'h3 0
run
