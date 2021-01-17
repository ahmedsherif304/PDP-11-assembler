vsim work.my_nadder
# vsim 
# Start time: 16:31:40 on Oct 31,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# A bookmarks file was found in the current directory with 11 bookmarks
add wave -position insertpoint  \
sim:/my_nadder/temp \
sim:/my_nadder/s \
sim:/my_nadder/n \
sim:/my_nadder/cout \
sim:/my_nadder/cin \
sim:/my_nadder/b \
sim:/my_nadder/a
force -freeze sim:/my_nadder/cin 1 0
force -freeze sim:/my_nadder/b 4'h4 0
force -freeze sim:/my_nadder/a 4'h3 0
run
force -freeze sim:/my_nadder/b 4'hf 0
run