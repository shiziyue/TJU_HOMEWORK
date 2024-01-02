`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 20:19:00
// Design Name: 
// Module Name: recordmin
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


module recordmin
#(parameter N=1500000000)
(
input sys_clk,
input sys_rst_n,
input state,
output [7:0] min
    );
      int cnt;
logic [7:0] result;
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
   if(result==59)
   result<=0;
   else
   result<=result+1;
    end
    else begin
    cnt<=cnt+1;
    end
    end
    end
    bin2bcd_0 b0(result,min);
endmodule
