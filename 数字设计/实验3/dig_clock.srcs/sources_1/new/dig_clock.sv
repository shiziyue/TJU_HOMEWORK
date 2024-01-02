`timescale 1ns / 1ps

module dig_clock(
    input                   sys_clk,
    input                   sys_rst_n,
    input                   i_start,
    output logic [3 : 0]    an,
    output logic [7 : 0]    a_to_g
    );
    logic keyposedge;
    logic state;
    logic [7:0] min_bcd;
    logic [7:0] sec_bcd;
    logic onems;
    edgecheck ec0(i_start,sys_clk,keyposedge);
    statecontroller sc0(sys_clk,sys_rst_n,keyposedge,state);
    recordmin rm0(sys_clk,sys_rst_n,state,min_bcd);
    recordsec rs0(sys_clk,sys_rst_n,state,sec_bcd);
   
    enableClockGeneration ecg0(sys_clk,sys_rst_n,state,onems);
    x7seg x70(sys_clk,sec_bcd,min_bcd,sys_rst_n,onems,a_to_g,an);
    
endmodule