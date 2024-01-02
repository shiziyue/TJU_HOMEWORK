`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 09:33:12
// Design Name: 
// Module Name: dig_clock_tb
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


module dig_clock_tb(

    );
        logic                 sys_clk;
    logic          sys_rst_n;
  logic             i_start;
    logic [3 : 0]    an;
    logic [7 : 0]    a_to_g;
    dig_clock d0(sys_clk,sys_rst_n,i_start,an,a_to_g);
    always #20 sys_clk=~sys_clk;
    initial begin
    sys_clk=1;
    sys_rst_n=0;
    i_start=0;
;
    #40;
    i_start=1;
    #2
    i_start=0;
    sys_rst_n=1;
    end
endmodule
