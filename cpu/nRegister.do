vsim work.nregister
# vsim 
# Start time: 20:58:23 on Nov 11,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.nregister(nregister_mux)
add wave -position insertpoint  \
sim:/nregister/rst
add wave -position end  sim:/nregister/n
add wave -position end  sim:/nregister/data
add wave -position end  sim:/nregister/clk
add wave -position end  sim:/nregister/E_OUT
add wave -position end  sim:/nregister/E_IN
force -freeze sim:/nregister/rst 1 0
force -freeze sim:/nregister/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/nregister/E_OUT 1 0
run
force -freeze sim:/nregister/rst 0 0
force -freeze sim:/nregister/E_OUT 0 0
force -freeze sim:/nregister/E_IN 1 0
force -freeze sim:/nregister/data 16'h0055 0
run
noforce sim:/nregister/data
force -freeze sim:/nregister/E_OUT 1 0
force -freeze sim:/nregister/E_IN 0 0
run
force -freeze sim:/nregister/E_IN 0 0
run
force -freeze sim:/nregister/E_OUT 0 0
run
force -freeze sim:/nregister/E_OUT 1 0
run
force -freeze sim:/nregister/rst 1 0
run