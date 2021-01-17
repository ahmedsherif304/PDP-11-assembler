vsim work.lab4
# vsim 
# Start time: 15:31:38 on Nov 14,2020
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.lab4(arch_lab4)
# Loading work.lab3(arch_lab3)
# Loading work.decoder(arch_decoder)
# Loading work.nregister(nregister_arch)
# Loading work.ram(syncrama)
add wave -position end  sim:/lab4/src
add wave -position end  sim:/lab4/rst
add wave -position end  sim:/lab4/not_ed
add wave -position end  sim:/lab4/lab3_bus
add wave -position end  sim:/lab4/dst
add wave -position end  sim:/lab4/data_out_bus
add wave -position end  sim:/lab4/data_in_bus
add wave -position end  sim:/lab4/count_sig
add wave -position end  sim:/lab4/clk
add wave -position end  sim:/lab4/ES
add wave -position end  sim:/lab4/ED

force -freeze sim:/lab4/rst 1 0
force -freeze sim:/lab4/clk 0 0, 1 {25 ns} -r 50	
run
mem load -filltype value -filldata 700 -fillradix hexadecimal /lab4/m0/ram(10)
mem load -filltype value -filldata 699 -fillradix hexadecimal /lab4/m0/ram(9)
mem load -filltype value -filldata 698 -fillradix hexadecimal /lab4/m0/ram(8)
mem load -filltype value -filldata 697 -fillradix hexadecimal /lab4/m0/ram(7)
mem load -filltype value -filldata 696 -fillradix hexadecimal /lab4/m0/ram(6)
mem load -filltype value -filldata 695 -fillradix hexadecimal /lab4/m0/ram(5)
mem load -filltype value -filldata 694 -fillradix hexadecimal /lab4/m0/ram(4)
mem load -filltype value -filldata 693 -fillradix hexadecimal /lab4/m0/ram(3)
mem load -filltype value -filldata 692 -fillradix hexadecimal /lab4/m0/ram(2)
mem load -filltype value -filldata 691 -fillradix hexadecimal /lab4/m0/ram(1)
mem load -filltype value -filldata 690 -fillradix hexadecimal /lab4/m0/ram(0)
# move m[10] to r0
force -freeze sim:/lab4/ED 1 0
force -freeze sim:/lab4/rst 0 0
force -freeze sim:/lab4/ES 0 0
force -freeze sim:/lab4/dst 2'h0 0
run
# move m[9] to r1
force -freeze sim:/lab4/dst 2'h1 0
run
# move r0 to r3
force -freeze sim:/lab4/src 2'h0 0
force -freeze sim:/lab4/ES 1 0
force -freeze sim:/lab4/dst 2'h3 0
run
# move r1 to m[7]
force -freeze sim:/lab4/ED 0 0
force -freeze sim:/lab4/src 2'h1 0
run