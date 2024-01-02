`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 11:12:10
// Design Name: 
// Module Name: bianyan
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


module bianyan(
    input sys_clk,
    input i_btn,
    output pos_edge
    );
    logic Q1,Q2;
    D d1(sys_clk,i_btn,Q1);
    D d2(sys_clk,Q1,Q2);
    assign pos_edge=Q1&~Q2;
endmodule
