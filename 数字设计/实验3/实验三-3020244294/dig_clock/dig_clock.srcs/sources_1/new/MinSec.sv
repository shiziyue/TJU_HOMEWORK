`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 15:13:21
// Design Name: 
// Module Name: MinSec
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


module MinSec(
  input sys_clk,
  input sys_rst_n,
  input i_start,
  output [7:0]min,
  output [7:0]sec
    );
    logic ONOFF;
    logic [2:0]en;
    Edge_Test btn_change(sys_clk,i_start,ONOFF);
    always_comb begin
        if(en[2]==1||en[2]==0)en[2]=en[2]^ONOFF;
        else en[2]=0;
    end
    
    
    logic persec;
    Timer presecond(en[2],sys_clk,sys_rst_n,persec);
    Counter second(en[2],persec,sys_rst_n,sec);
     
    logic min;
    always_ff @(posedge sys_clk)begin
        if(sys_rst_n) min <= 0;
        else if(en[2])begin
            if(min == 59) min <= 0;
            else min <= min + 1; 
        end
    end
    
    
endmodule
