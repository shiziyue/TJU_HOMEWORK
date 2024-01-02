`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/14 11:51:59
// Design Name: 
// Module Name: vector5_tb
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


module vector5_tb();
    logic [4:0]i;
    logic led;
    int j;
    voter5 DUT(.i(i),.led(led));
    initial begin
        for(j=0;j<32;j++)begin
            i=j;
            #20;
        end
    end
endmodule
