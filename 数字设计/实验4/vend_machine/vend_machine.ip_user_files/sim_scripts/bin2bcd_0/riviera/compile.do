vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -sv2k12 \
"../../../../vend_machine.srcs/sources_1/ip/bin2bcd_0/bin2bcd.sv" \
"../../../../vend_machine.srcs/sources_1/ip/bin2bcd_0/sim/bin2bcd_0.sv" \


vlog -work xil_defaultlib \
"glbl.v"

