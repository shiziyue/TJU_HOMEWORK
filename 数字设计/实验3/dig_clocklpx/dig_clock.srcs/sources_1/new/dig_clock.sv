`timescale 1ns / 1ps

module dig_clock(
    input                   sys_clk,
    input                   sys_rst_n,
    input                   i_start,
    output logic [3 : 0]    an,
    output logic [7 : 0]    a_to_g
    );
    logic [7:0]bcd,m,s;
    jishi ji(sys_clk,sys_rst_n,i_start,m,s);
    xianshi x(sys_clk,sys_rst_n,s,m,an,a_to_g);
 
    
endmodule