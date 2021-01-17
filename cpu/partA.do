vsim work.parta
add wave -position insertpoint  \
sim:/parta/cout \
sim:/parta/cin \
sim:/parta/c4 \
sim:/parta/c3 \
sim:/parta/c2 \
sim:/parta/c1 \
sim:/parta/Z_BUS \
sim:/parta/S \
sim:/parta/F4 \
sim:/parta/F3 \
sim:/parta/F2 \
sim:/parta/F1 \
sim:/parta/F \
sim:/parta/B_inv \
sim:/parta/B \
sim:/parta/A
force -freeze sim:/parta/S 2'h0 0
force -freeze sim:/parta/cin 0 0
force -freeze sim:/parta/B 16'h0001 0
force -freeze sim:/parta/A 16'h0f0f 0
run
force -freeze sim:/parta/S 2'h1 0
run
force -freeze sim:/parta/A 16'hFFFF 0
run
force -freeze sim:/parta/S 2'h2 0
run
force -freeze sim:/parta/S 2'h3 0
run
force -freeze sim:/parta/A 16'h0f0e 0
force -freeze sim:/parta/cin 1 0
force -freeze sim:/parta/S 2'h0 0
run
force -freeze sim:/parta/A 16'hffff 0
force -freeze sim:/parta/S 2'h1 0
run
force -freeze sim:/parta/A 16'h0f0f 0
force -freeze sim:/parta/S 2'h2 0
run
force -freeze sim:/parta/S 2'h3 0
run