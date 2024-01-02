`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/03 10:14:59
// Design Name: 
// Module Name: vend_tb
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


module vend_tb(
);
    logic clk, rs,coin5, coin10,open;
    logic [3 : 0] an;
    logic [7 : 0] a_to_g;
    always #0.001 clk = ~clk;
    vend v(clk,rs,coin5,coin10,an,a_to_g,open);
    logic [7:0]change,price;
    //Stater s(clk,rs,coin5,coin10,change,price,open);
    initial begin
        rs=0;clk=1;coin5=0;coin10=0;
        #4;rs=1;
        #6;coin5=1;
        #4;coin5=0;
        #4;coin10=1;
        #4;coin10=0;
    end

endmodule
