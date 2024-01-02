vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -sv \
"../../../../../../../../3/dig_clock/dig_clock.srcs/sources_1/bin2bcd_0_1/bin2bcd.sv" \
"../../../../../../../../3/dig_clock/dig_clock.srcs/sources_1/bin2bcd_0_1/sim/bin2bcd_0.sv" \


vlog -work xil_defaultlib \
"glbl.v"

