`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 20:07:34
// Design Name: 
// Module Name: statecontroller
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


module statecontroller(
input sys_clk,
input sys_rst_n,
input edgecheckoutput,
output state
    );
    logic result;
    always_ff @(posedge sys_clk)begin
    if(!sys_rst_n)
    result<=0;
    else begin
    if(edgecheckoutput==1)
    result=~result;
    end
    end
    assign state=result;
endmodule
