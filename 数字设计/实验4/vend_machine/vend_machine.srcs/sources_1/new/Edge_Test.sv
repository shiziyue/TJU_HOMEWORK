`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 20:32:46
// Design Name: 
// Module Name: Edge_Test
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


module Edge_Test(
    input sys_clk,
    input coin_btn,
    output pos_edge
    );
    logic Q1,Q2;
    D d1(sys_clk,coin_btn,Q1);
    D d2(sys_clk,Q1,Q2);
    assign pos_edge = Q1&~Q2;
endmodule
