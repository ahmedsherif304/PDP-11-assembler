vsim work.partc
add wave -position insertpoint  \
sim:/partc/A \
sim:/partc/cin \
sim:/partc/S \
sim:/partc/F \
sim:/partc/cout \

force -freeze sim:/partc/A 16'hf00f 0
force -freeze sim:/partc/S 2'h0 0
run
force -freeze sim:/partc/S 2'h1 0
run
force -freeze sim:/partc/cin 0 0
force -freeze sim:/partc/S 2'h2 0
run
force -freeze sim:/partc/cin 1 0
run
force -freeze sim:/partc/S 2'h3 0
run