`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 13:52:28
// Design Name: 
// Module Name: dig_clock_tb
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


module dig_clock_tb();
    logic clk,b,rs;
    logic [3 : 0]    an;
    logic [7 : 0]    a_to_g;
//    logic [7 : 0]    m,s;
//    logic[1:0]en;
    always #0.001 clk = ~clk;
    dig_clock d(clk,rs,b,an,a_to_g);
    initial begin rs=1;clk=1;b=0;#2;b=~b;#2;rs=0;#6;b=~b;end
endmodule
