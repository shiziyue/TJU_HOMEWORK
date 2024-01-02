`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/03 09:32:36
// Design Name: 
// Module Name: Enableclock
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


module Enableclock(
    input sys_clk,
    input sys_rst_n,
    output [1:0]enableclock
    );
     int counter;
     int res;
     always_ff @(posedge sys_clk)begin
         if(!sys_rst_n)begin 
             counter <= 0;
             res <= 0;
         end
         else if(counter==24999)begin
             counter <= 0;
             if(res == 3) res <= 0;
             else res <= res +1;
         end
         else begin
             counter <= counter + 1;
         end
     end
     assign enableclock = res;
endmodule
