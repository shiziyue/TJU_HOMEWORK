vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -sv \
"../../../../vend_machine.srcs/sources_1/ip/bin2bcd_0/bin2bcd.sv" \
"../../../../vend_machine.srcs/sources_1/ip/bin2bcd_0/sim/bin2bcd_0.sv" \


vlog -work xil_defaultlib \
"glbl.v"

