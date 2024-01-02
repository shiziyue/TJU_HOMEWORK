`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 11:19:35
// Design Name: 
// Module Name: D8
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


module D8(
input e,
    input en,
    input sys_clk,
    input rs,
    output [7:0]m
    );
    logic[7:0]m;
    always_ff@(posedge sys_clk)begin
    if(e)begin
       if(rs)m<=0;
       else if(en)begin 
           if(m==59)m<=0;
           else m<=m+1;
       end
    end
    end
endmodule
