// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Fri Apr  9 15:26:25 2021
// Host        : LAPTOP-BEASOA6F running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub d:/x7seg_d_port.sv
// Design      : x7seg_d
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module x7seg_d(sys_clk, sys_rst_n, Y0, Y1, an, a_to_g)
/* synthesis syn_black_box black_box_pad_pin="sys_clk,sys_rst_n,Y0[3:0],Y1[3:0],an[3:0],a_to_g[7:0]" */;
  input sys_clk;
  input sys_rst_n;
  input [3:0]Y0;
  input [3:0]Y1;
  output [3:0]an;
  output [7:0]a_to_g;
endmodule
