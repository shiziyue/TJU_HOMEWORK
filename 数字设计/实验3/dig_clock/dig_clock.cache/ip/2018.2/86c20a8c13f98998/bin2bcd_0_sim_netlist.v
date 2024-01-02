// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sun May 15 12:12:52 2022
// Host        : LAPTOP-627C3VIT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ bin2bcd_0_sim_netlist.v
// Design      : bin2bcd_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bin2bcd_0,bin2bcd,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "bin2bcd,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  LUT4 #(
    .INIT(16'h11EA)) 
    \bcd[1]_INST_0 
       (.I0(\bcd[4]_INST_0_i_3_n_0 ),
        .I1(\bcd[4]_INST_0_i_2_n_0 ),
        .I2(\bcd[4]_INST_0_i_1_n_0 ),
        .I3(bin[1]),
        .O(\^bcd [1]));
  LUT4 #(
    .INIT(16'h998C)) 
    \bcd[2]_INST_0 
       (.I0(bin[1]),
        .I1(\bcd[4]_INST_0_i_1_n_0 ),
        .I2(\bcd[4]_INST_0_i_2_n_0 ),
        .I3(\bcd[4]_INST_0_i_3_n_0 ),
        .O(\^bcd [2]));
  LUT4 #(
    .INIT(16'h1E10)) 
    \bcd[3]_INST_0 
       (.I0(bin[1]),
        .I1(\bcd[4]_INST_0_i_1_n_0 ),
        .I2(\bcd[4]_INST_0_i_2_n_0 ),
        .I3(\bcd[4]_INST_0_i_3_n_0 ),
        .O(\^bcd [3]));
  LUT4 #(
    .INIT(16'h1FE0)) 
    \bcd[4]_INST_0 
       (.I0(bin[1]),
        .I1(\bcd[4]_INST_0_i_1_n_0 ),
        .I2(\bcd[4]_INST_0_i_2_n_0 ),
        .I3(\bcd[4]_INST_0_i_3_n_0 ),
        .O(\^bcd [4]));
  LUT6 #(
    .INIT(64'h8A65A651518A18A6)) 
    \bcd[4]_INST_0_i_1 
       (.I0(bin[6]),
        .I1(bin[5]),
        .I2(bin[7]),
        .I3(bin[4]),
        .I4(bin[3]),
        .I5(bin[2]),
        .O(\bcd[4]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC61831C68C31638C)) 
    \bcd[4]_INST_0_i_2 
       (.I0(bin[2]),
        .I1(bin[3]),
        .I2(bin[4]),
        .I3(bin[7]),
        .I4(bin[5]),
        .I5(bin[6]),
        .O(\bcd[4]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0821420810428410)) 
    \bcd[4]_INST_0_i_3 
       (.I0(bin[2]),
        .I1(bin[3]),
        .I2(bin[4]),
        .I3(bin[7]),
        .I4(bin[5]),
        .I5(bin[6]),
        .O(\bcd[4]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h2DC201D609D240D6)) 
    \bcd[5]_INST_0 
       (.I0(bin[6]),
        .I1(bin[5]),
        .I2(bin[7]),
        .I3(bin[4]),
        .I4(bin[3]),
        .I5(bin[2]),
        .O(\^bcd [5]));
  LUT6 #(
    .INIT(64'hF000000F1FFCF800)) 
    \bcd[6]_INST_0 
       (.I0(bin[2]),
        .I1(bin[3]),
        .I2(bin[4]),
        .I3(bin[7]),
        .I4(bin[5]),
        .I5(bin[6]),
        .O(\^bcd [6]));
  LUT6 #(
    .INIT(64'h000103F0E0000000)) 
    \bcd[7]_INST_0 
       (.I0(bin[2]),
        .I1(bin[3]),
        .I2(bin[4]),
        .I3(bin[7]),
        .I4(bin[5]),
        .I5(bin[6]),
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
