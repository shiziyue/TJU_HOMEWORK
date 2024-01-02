`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/03 10:02:25
// Design Name: 
// Module Name: Countdown
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


module Countdown(
    input sys_clk,
    input sys_rst_n,
    input ifopen,
    output integer m
    );
    always_ff @(posedge sys_clk)begin
        if(!sys_rst_n||!ifopen) m<=0;
        else if(ifopen)begin
            if(m==250000000)m<=0;
            else m <= m+1;
        end    
    end
endmodule
