`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 10:38:32
// Design Name: 
// Module Name: ALU_4bits_tb
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


module ALU_4bits_tb(
    );
    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] aluop;
    logic [7:0] alures;
    logic ZF,OF;    
    logic [7:0] alures_y;
    logic ZF_y,OF_y;
    logic[21:0]  data[3855:0];
    int i;
    alu DUT(A,B,aluop,alures,ZF,OF);
    initial begin
        $readmemb("test.txt",data);
        for(i=0;i<3856;i++) begin
            {A,B,aluop,alures_y,ZF_y,OF_y}=data[i];
        #0.1;
             if(alures==alures_y&&ZF==ZF_y&&OF==OF_y)
                $display($time,"test pass");
            else
                $display($time,"Error:inputs = %b, result = %b, expect result = %b",{A,B,aluop},{alures,ZF,OF},{alures_y,ZF_y,OF_y});
        end
    end
endmodule
