`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 08:45:51
// Design Name: 
// Module Name: light
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


module light(
input [3:0]num,
output [7:0] light
    );
    logic [7:0]lightvalue;
    always_comb begin
    case(num)
    4'b0000:lightvalue=8'b01000000;
    4'b0001:lightvalue=8'b01111001;
    4'b0010:lightvalue=8'b00100100;
    4'b0011:lightvalue=8'b00110000;
    4'b0100:lightvalue=8'b00011001;
     4'b0101:lightvalue=8'b00010010;
     4'b0110:lightvalue=8'b00000010;
   4'b0111:lightvalue=8'b01111000;
     4'b1000:lightvalue=8'b00000000;
      4'b1001:lightvalue=8'b00011000;
      default:lightvalue=8'b01000000;
    endcase
    end
    assign light=lightvalue;
endmodule
