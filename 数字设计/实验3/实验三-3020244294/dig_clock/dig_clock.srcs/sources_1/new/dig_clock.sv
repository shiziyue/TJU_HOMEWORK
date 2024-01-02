`timescale 1ns / 1ps

module dig_clock(
    input                   sys_clk,
    input                   sys_rst_n,
    input                   i_start,
    output logic [3 : 0]    an,
    output logic [7 : 0]    a_to_g
    );
    logic pos_edge,state;
    logic [1:0]enableclock;
    logic [7:0]min,sec;
    btn_change btn(sys_clk,i_start,pos_edge);
    state_change sta(sys_clk,sys_rst_n,pos_edge,state);
    record_min minute(state,sys_clk,sys_rst_n,min);
    record_sec second(state,sys_clk,sys_rst_n,sec);
    EnableClock_x7seg clock(state,sys_clk,sys_rst_n,enableclock);
    x7seg x7(sys_clk,sys_rst_n,min,sec,enableclock,an,a_to_g);
endmodule