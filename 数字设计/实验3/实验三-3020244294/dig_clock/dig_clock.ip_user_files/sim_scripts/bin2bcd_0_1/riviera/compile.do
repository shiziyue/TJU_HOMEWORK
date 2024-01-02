vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -sv2k12 \
"../../../../../../../../3/dig_clock/dig_clock.srcs/sources_1/bin2bcd_0_1/bin2bcd.sv" \
"../../../../../../../../3/dig_clock/dig_clock.srcs/sources_1/bin2bcd_0_1/sim/bin2bcd_0.sv" \


vlog -work xil_defaultlib \
"glbl.v"

