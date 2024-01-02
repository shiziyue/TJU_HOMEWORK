vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -sv \
"../../../../dig_clock.srcs/sources_1/ip/bin2bcd_0/bin2bcd.sv" \
"../../../../dig_clock.srcs/sources_1/ip/bin2bcd_0/sim/bin2bcd_0.sv" \


vlog -work xil_defaultlib \
"glbl.v"

