`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 11:35:24
// Design Name: 
// Module Name: edgecheck
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


module edgecheck(
input i_btn,
input sys_clk,
output pos_edge
    );
    logic Q0;
    logic Q1;
always_ff @(posedge sys_clk) begin
Q0<=i_btn;
Q1<=Q0;
end
assign pos_edge=Q0&(~Q1);
endmodule
