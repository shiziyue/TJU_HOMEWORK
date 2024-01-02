`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 10:02:01
// Design Name: 
// Module Name: sc_tb
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


module sc_tb(

    );
    logic sys_clk;
logic sys_rst_n;
logic edgecheckoutput;
logic state;
statecontroller sc_tb(sys_clk,sys_rst_n,edgecheckoutput,state);
   always #20 sys_clk=~sys_clk;
     initial begin
    sys_clk=1;
    sys_rst_n=0;
    edgecheckoutput=0;
    #2;
    sys_rst_n=1;
    #38;
    edgecheckoutput=1;
    #40
    edgecheckoutput=0;
    #80
    edgecheckoutput=1;
   #40
     edgecheckoutput=0;
    end
endmodule
