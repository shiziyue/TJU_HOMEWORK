// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat May 21 20:56:04 2022
// Host        : DESKTOP-J9TUK8S running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top bin2bcd_0 -prefix
//               bin2bcd_0_ bin2bcd_0_stub.v
// Design      : bin2bcd_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "bin2bcd,Vivado 2018.2" *)
module bin2bcd_0(bin, bcd)
/* synthesis syn_black_box black_box_pad_pin="bin[7:0],bcd[7:0]" */;
  input [7:0]bin;
  output [7:0]bcd;
endmodule
