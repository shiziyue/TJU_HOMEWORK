`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 10:32:18
// Design Name: 
// Module Name: jishi
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


module jishi(
    input sys_clk,
    input sys_rst_n,
    input i_start,
    output [7:0]min,
    output [7:0]sec
    );
    integer d;
    logic[1:0]en;
    logic E,e;
    bianyan b(sys_clk,i_start,E);
    always_comb begin
        if(e==1||e==0)e=e^E;
        else e=0;
    end
    always_ff@(posedge sys_clk)begin
        en={d==24999999,sec==59&&d==24999999};
    end
    jisec jimi(e,sys_clk,sys_rst_n,d);
    D8 jifen(e,en[0],sys_clk,sys_rst_n,min);
    D8 jimiao(e,en[1],sys_clk,sys_rst_n,sec);
endmodule
