// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed May 18 10:43:18 2022
// Host        : Uylno running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/vivado/dig_clock/dig_clock.srcs/sources_1/ip/bin2bcd_0/bin2bcd_0_stub.v
// Design      : bin2bcd_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "bin2bcd,Vivado 2018.3" *)
module bin2bcd_0(bin, bcd)
/* synthesis syn_black_box black_box_pad_pin="bin[7:0],bcd[7:0]" */;
  input [7:0]bin;
  output [7:0]bcd;
endmodule
