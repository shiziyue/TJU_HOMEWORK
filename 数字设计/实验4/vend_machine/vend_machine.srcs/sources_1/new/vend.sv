`timescale 1ns / 1ps

module vend(
    input sys_clk, sys_rst_n,
    input coin5, coin10,
    output [3 : 0] an,
    output [7 : 0] a_to_g,
    output open
    );
    logic [7:0]change,price;
    Stater Machine(sys_clk,sys_rst_n,coin5,coin10,change,price,open);
    x7seg Light(sys_clk,sys_rst_n,change,price,an,a_to_g);
    
endmodule