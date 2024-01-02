`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 12:35:12
// Design Name: 
// Module Name: xian4
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


module xian4(
    input sys_clk,
    input rs,
    output integer m
    );
    always_ff@(posedge sys_clk)begin
       if(rs)m<=0;
       else begin
           if(m==24999)m<=0;
           else m<=m+1;
       end
    end
endmodule
