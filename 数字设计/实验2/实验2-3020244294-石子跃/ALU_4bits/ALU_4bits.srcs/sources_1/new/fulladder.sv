`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 08:14:54
// Design Name: 
// Module Name: fulladder
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


module fulladder(
    input A,
    input B,
    input Cin,
    output logic Cout,
    output logic S
    );
    assign Cout= (A&Cin)|(A&B)|(B&Cin);
    assign S=((~A)&(~B)&(Cin))|(A&(~B)&(~Cin))|((~A)&(B)&(~Cin))|(A&B&Cin);
endmodule
