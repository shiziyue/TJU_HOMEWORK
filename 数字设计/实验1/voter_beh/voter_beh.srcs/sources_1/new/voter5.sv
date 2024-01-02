`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/14 15:09:32
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


module voter5(input logic[4:0]i,
output logic led
    );
    assign led=(i[4]&&i[3]&&i[2])||(i[4]&&i[3]&&i[1])||(i[4]&&i[3]&&i[0])||(i[4]&&i[2]&&i[1])||(i[4]&&i[2]&&i[0])||(i[4]&&i[1]&&i[0])||(i[3]&&i[2]&&i[1])||(i[3]&&i[2]&&i[0])||(i[3]&&i[1]&&i[0])||(i[2]&&i[1]&&i[0]);
endmodule
