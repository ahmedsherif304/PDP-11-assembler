vsim work.alsu

add wave -position insertpoint  \
sim:/alsu/cin \
sim:/alsu/A \
sim:/alsu/B \
sim:/alsu/sel \
sim:/alsu/F \
sim:/alsu/cout

force -freeze sim:/alsu/sel 4'h0 0
force -freeze sim:/alsu/cin 0 0
force -freeze sim:/alsu/B 16'h0001 0
force -freeze sim:/alsu/A 16'h0f0f 0
run
force -freeze sim:/alsu/sel 4'h1 0
run
force -freeze sim:/alsu/A 16'hFFFF 0
run
force -freeze sim:/alsu/sel 4'h2 0
run
force -freeze sim:/alsu/sel 4'h3 0
run
force -freeze sim:/alsu/A 16'h0f0e 0
force -freeze sim:/alsu/cin 1 0
force -freeze sim:/alsu/sel 4'h0 0
run
force -freeze sim:/alsu/A 16'hffff 0
force -freeze sim:/alsu/sel 4'h1 0
run
force -freeze sim:/alsu/A 16'h0f0f 0
force -freeze sim:/alsu/sel 4'h2 0
run
force -freeze sim:/alsu/sel 4'h3 0
run

force -freeze sim:/alsu/sel 4'h4 0
force -freeze sim:/alsu/A 16'hf00f 0
force -freeze sim:/alsu/B 16'h000a 0
force -freeze sim:/alsu/cin 0 0
run
force -freeze sim:/alsu/sel 4'h5 0
run
force -freeze sim:/alsu/sel 4'h6 0
run
force -freeze sim:/alsu/sel 4'h7 0
run
force -freeze sim:/alsu/sel 4'h8 0
run
force -freeze sim:/alsu/sel 4'h9 0
run
force -freeze sim:/alsu/sel 4'ha 0
run
force -freeze sim:/alsu/cin 1 0
run
force -freeze sim:/alsu/sel 4'hB 0
run
force -freeze sim:/alsu/cin 0 0
force -freeze sim:/alsu/sel 4'hC 0
run
force -freeze sim:/alsu/sel 4'hD 0
run
force -freeze sim:/alsu/sel 4'hE 0
run
force -freeze sim:/alsu/cin 1 0
run
force -freeze sim:/alsu/sel 4'hF 0
run