vlib work
vcom -93 -work work ../rtl/imaging/readImage.vhd
vcom -93 -work work ../simulation/binaryImages/binaryIMG.txt
vcom -93 -work work ../testbench/readImage_tb.vhd
vsim -voptargs=+acc readImage_tb
do wave.do
run 36 us