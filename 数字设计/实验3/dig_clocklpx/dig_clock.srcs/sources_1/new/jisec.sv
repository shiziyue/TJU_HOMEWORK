`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 11:25:48
// Design Name: 
// Module Name: jisec
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


module jisec(
    input en,
    input sys_clk,
    input rs,
    output integer m
    );
    always_ff@(posedge sys_clk)begin
    if(en)begin
       if(rs)m<=0;
       else begin
           if(m==24999999)m<=0;
           else m<=m+1;
       end
    end
    end
endmodule
