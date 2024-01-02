`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/14 11:26:31
// Design Name: 
// Module Name: voter5
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


module voter5(input logic [4:0]i,
output logic led
    );
    logic [7:0]h;
    logic [3:0]l;
    dec_74LS138 a(i[4:2],h);
    dec_74LS139 b(i[1:0],l);
    assign led=(~h[7])||(~h[6]&&l[0])||(~h[5]&&l[0])||(~h[4]&&~l[3])||(~h[3]&&l[0])||(~h[2]&&~l[3])||(~h[1]&&~l[3]);
endmodule
