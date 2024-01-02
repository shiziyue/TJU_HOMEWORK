`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 11:22:35
// Design Name: 
// Module Name: sec_tb
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


module sec_tb(

    );
    logic sys_clk;
logic sys_rst_n;
logic state;
logic [7:0] sec;
recordsec sec_tb(sys_clk,sys_rst_n,state,sec);
always #20 sys_clk=~sys_clk;
     initial begin
    sys_clk=1;
    sys_rst_n=0;
    state=0;
    #2;
    sys_rst_n=1;
    #38;
    state=1;
    end
endmodule
