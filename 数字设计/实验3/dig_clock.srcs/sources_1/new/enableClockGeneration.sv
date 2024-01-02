`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 11:14:09
// Design Name: 
// Module Name: enableClockGeneration
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


module enableClockGeneration 
#(parameter N=25000)
(
input sys_clk,
input state,
input sys_rst_n,
output enableclock
    );
   logic result;
    int cnt;
    always_ff @(posedge sys_clk) begin
    if(!state)begin
    if(!sys_rst_n)begin
    cnt<=0;
    result<=0;
    end
    end
    else begin
    if(cnt==N-1)begin
    cnt<=0;
    result<=1;
    end
    else begin
    cnt<=cnt+1;
    result=0;
    end
    end
    end
    assign enableclock=result;
endmodule
