`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 11:09:17
// Design Name: 
// Module Name: edgedetect_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module edgedetect_tb(

    );
    logic i_btn;
logic sys_clk;
logic pos_edge;
edgecheck ec_tb(i_btn,sys_clk,pos_edge);
 always #20 sys_clk=~sys_clk;
     initial begin
    sys_clk=1;
    i_btn=0;
    #40;
    i_btn=1;
    #2
    i_btn=0;
    end
endmodule
