`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 16:45:06
// Design Name: 
// Module Name: x7_tb
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


module x7_tb(

    );
   logic sys_clk;
 logic [7:0]sec;
 logic [7:0]min;
 logic sys_rst_n;
 logic enable;
 logic [7:0]a_to_g;
 logic [7:0]an;
 
 logic state;
 
 enableClockGeneration ecg0(sys_clk,sys_rst_n,state,enable);
 recordsec sec_tb(sys_clk,sys_rst_n,state,sec);
  recordmin min_tb(sys_clk,sys_rst_n,state,min);
 x7seg x7_tb(sys_clk,sec,min,sys_rst_n,enable,a_to_g,an);
 always #20 sys_clk=~sys_clk;
     initial begin
    sys_clk=1;
    sys_rst_n=0;
    state=0;
    #2;
    sys_rst_n=1;
    #38;
    state=1;
    end
endmodule
