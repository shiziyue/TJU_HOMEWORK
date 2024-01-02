`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 08:14:54
// Design Name: 
// Module Name: rca
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


module rca(
    input [3:0]A,
    input [3:0]B,
    input Cin,
    output logic [3:0]S,
    output logic Cout
    );
    logic Cin2;
    logic Cin3;
    logic Cin4;
    fulladder add1(A[0],B[0],Cin,Cin2,S[0]);
    fulladder add2(A[1],B[1],Cin2,Cin3,S[1]);
    fulladder add3(A[2],B[2],Cin3,Cin4,S[2]);
    fulladder add4(A[3],B[3],Cin4,Cout,S[3]);    
endmodule
