vsim work.decoder
# vsim 
# Start time: 21:35:35 on Nov 11,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.decoder(arch_decoder)
add wave -position insertpoint  \
sim:/decoder/s \
sim:/decoder/result \
sim:/decoder/enable \
sim:/decoder/Z_BUS
force -freeze sim:/decoder/enable 0 0
run
force -freeze sim:/decoder/s 2'h0 0
force -freeze sim:/decoder/enable 1 0
run
force -freeze sim:/decoder/s 2'h1 0
run
force -freeze sim:/decoder/s 2'h2 0
run
force -freeze sim:/decoder/s 2'h3 0
run
