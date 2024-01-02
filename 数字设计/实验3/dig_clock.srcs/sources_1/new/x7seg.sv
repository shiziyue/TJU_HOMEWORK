`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 20:57:54
// Design Name: 
// Module Name: x7seg
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


module x7seg(
input sys_clk,
input [7:0]sec,
input [7:0]min,
input sys_rst_n,
input enable,
output [7:0]a_to_g,
output [7:0]an
    );
    logic [7:0] tmp_an;
    logic [7:0] tmp_atog;
    logic [7:0] tmp_atog_0;
    logic [7:0] tmp_atog_1;
    logic [7:0] tmp_atog_2;
    logic [7:0] tmp_atog_3;
       light test0(sec[3:0],tmp_atog_0);
          light test1(sec[7:4],tmp_atog_1);
            light test2(min[3:0],tmp_atog_2);
       light test3(min[7:4],tmp_atog_3);
    always_ff @(posedge sys_clk)begin
    if(!sys_rst_n)begin
   tmp_an<=8'b00000001;
   tmp_atog<=8'b00000000;
   end
   else begin
   if(enable) begin
   case(tmp_an) 
   8'b00000001:begin
   tmp_an<=8'b00000010;
   tmp_atog<=tmp_atog_1;
   end
   8'b00000010:begin
   tmp_an<=8'b00000100;
    tmp_atog<=tmp_atog_2;
   end
   8'b00000100:begin
   tmp_an<=8'b00001000;
   tmp_atog<=tmp_atog_3;
   end
    8'b00001000:begin
   tmp_an<=8'b00000001;
   tmp_atog<=tmp_atog_0;
   end
   default: tmp_an<=8'b00000001;
   endcase
   end
   end
    end
    assign an=tmp_an;
    assign a_to_g=tmp_atog;
endmodule
