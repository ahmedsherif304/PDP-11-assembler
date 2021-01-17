vsim work.lab3
add wave -position insertpoint  \
sim:/lab3/src \
sim:/lab3/rst \
sim:/lab3/dst \
sim:/lab3/data \
sim:/lab3/clk \
sim:/lab3/OUT_EN_BUS \
sim:/lab3/IN_EN_BUS \
sim:/lab3/ES \
sim:/lab3/ED
force -freeze sim:/lab3/clk 0 0, 1 {25 ns} -r 50
force -freeze sim:/lab3/rst 1 0
force -freeze sim:/lab3/ES 1 0
force -freeze sim:/lab3/rst 0 0
# test
force -freeze sim:/lab3/rst 1 0
force -freeze sim:/lab3/ES 1 0
force -freeze sim:/lab3/rst 0 0
run
run
force -freeze sim:/lab3/dst 2'h0 0
force -freeze sim:/lab3/rst 1 0
run
force -freeze sim:/lab3/ES 0 0
run
force -freeze sim:/lab3/rst 0 0
run
force -freeze sim:/lab3/ED 1 0
run

# transfer 00AA to r0
force -freeze sim:/lab3/data 32'h00AA 0
force -freeze sim:/lab3/dst 2'h0 0
force -freeze sim:/lab3/ES 0 0
force -freeze sim:/lab3/ED 1 0
run
force -freeze sim:/lab3/dst 2'h1 0
force -freeze sim:/lab3/data 32'h000000BB 0
run
force -freeze sim:/lab3/dst 2'h2 0
force -freeze sim:/lab3/data 32'h000000CC 0
run
force -freeze sim:/lab3/data 32'h000000DD 0
force -freeze sim:/lab3/dst 2'h3 0
run

# read data from r0
force -freeze sim:/lab3/ES 1 0
force -freeze sim:/lab3/ED 0 0
force -freeze sim:/lab3/src 2'h0 0
noforce sim:/lab3/data
run
# transfer r0 to r1
force -freeze sim:/lab3/dst 2'h1 0
force -freeze sim:/lab3/ED 1 0
run
#transfer r2 to r0
force -freeze sim:/lab3/dst 2'h0 0
force -freeze sim:/lab3/src 2'h2 0
run
#transfer r3 to r0
force -freeze sim:/lab3/src 2'h3 0
run