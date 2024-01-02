// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed May 18 10:43:18 2022
// Host        : Uylno running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/vivado/dig_clock/dig_clock.srcs/sources_1/ip/bin2bcd_0/bin2bcd_0_sim_netlist.v
// Design      : bin2bcd_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bin2bcd_0,bin2bcd,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "bin2bcd,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module bin2bcd_0
   (bin,
    bcd);
  input [7:0]bin;
  output [7:0]bcd;

  wire [7:1]\^bcd ;
  wire \bcd[4]_INST_0_i_1_n_0 ;
  wire \bcd[4]_INST_0_i_2_n_0 ;
  wire \bcd[4]_INST_0_i_3_n_0 ;
  wire [7:0]bin;

  assign bcd[7:1] = \^bcd [7:1];
  assign bcd[0] = bin[0];
  LUT5 #(
    .INIT(32'h481137EC)) 
    \bcd[1]_INST_0 
       (.I0(\bcd[4]_INST_0_i_3_n_0 ),
        .I1(\bcd[4]_INST_0_i_2_n_0 ),
        .I2(bin[2]),
        .I3(\bcd[4]_INST_0_i_1_n_0 ),
        .I4(bin[1]),
        .O(\^bcd [1]));
  LUT5 #(
    .INIT(32'h3C623C46)) 
    \bcd[2]_INST_0 
       (.I0(\bcd[4]_INST_0_i_1_n_0 ),
        .I1(bin[2]),
        .I2(\bcd[4]_INST_0_i_2_n_0 ),
        .I3(bin[1]),
        .I4(\bcd[4]_INST_0_i_3_n_0 ),
        .O(\^bcd [2]));
  LUT5 #(
    .INIT(32'h10D34A08)) 
    \bcd[3]_INST_0 
       (.I0(\bcd[4]_INST_0_i_1_n_0 ),
        .I1(bin[2]),
        .I2(\bcd[4]_INST_0_i_2_n_0 ),
        .I3(bin[1]),
        .I4(\bcd[4]_INST_0_i_3_n_0 ),
        .O(\^bcd [3]));
  LUT5 #(
    .INIT(32'h95565A5A)) 
    \bcd[4]_INST_0 
       (.I0(\bcd[4]_INST_0_i_1_n_0 ),
        .I1(bin[2]),
        .I2(\bcd[4]_INST_0_i_2_n_0 ),
        .I3(bin[1]),
        .I4(\bcd[4]_INST_0_i_3_n_0 ),
        .O(\^bcd [4]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h26926426)) 
    \bcd[4]_INST_0_i_1 
       (.I0(bin[4]),
        .I1(bin[6]),
        .I2(bin[7]),
        .I3(bin[5]),
        .I4(bin[3]),
        .O(\bcd[4]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3C799E3C38611C38)) 
    \bcd[4]_INST_0_i_2 
       (.I0(bin[3]),
        .I1(bin[4]),
        .I2(bin[6]),
        .I3(bin[7]),
        .I4(bin[5]),
        .I5(bin[2]),
        .O(\bcd[4]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h99294694)) 
    \bcd[4]_INST_0_i_3 
       (.I0(bin[5]),
        .I1(bin[7]),
        .I2(bin[6]),
        .I3(bin[4]),
        .I4(bin[3]),
        .O(\bcd[4]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h2C0BC3D00042C3FC)) 
    \bcd[5]_INST_0 
       (.I0(bin[2]),
        .I1(bin[5]),
        .I2(bin[7]),
        .I3(bin[6]),
        .I4(bin[4]),
        .I5(bin[3]),
        .O(\^bcd [5]));
  LUT6 #(
    .INIT(64'hC03C03ECC07C03C0)) 
    \bcd[6]_INST_0 
       (.I0(bin[2]),
        .I1(bin[5]),
        .I2(bin[7]),
        .I3(bin[6]),
        .I4(bin[4]),
        .I5(bin[3]),
        .O(\^bcd [6]));
  LUT6 #(
    .INIT(64'h03C0000003803400)) 
    \bcd[7]_INST_0 
       (.I0(bin[2]),
        .I1(bin[5]),
        .I2(bin[7]),
        .I3(bin[6]),
        .I4(bin[4]),
        .I5(bin[3]),
        .O(\^bcd [7]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
