`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 21:56:15
// Design Name: 
// Module Name: Stater
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


module Stater(
    input sys_clk,
    input sys_rst_n,
    input coin5,coin10,
    output [7:0]change,price,
    output open
    );
    logic C5,C10;
    Edge_Test Coin5(sys_clk,coin5,C5);
    Edge_Test Coin10(sys_clk,coin10,C10);
    logic [2:0]cstate,nstate;
    integer m;
    Countdown Se10(sys_clk,sys_rst_n,open,m);
    always_ff @(posedge sys_clk)begin
        if(~sys_rst_n||m==250000000)cstate <= 0;
        else cstate <= nstate;
    end
    always_comb begin
        case(cstate)
            3'd0:begin
                if(C5)  nstate = 3'd1;
                else if(C10)    nstate = 3'd2;
                else nstate=cstate;end
            3'd1:begin
                if(C5)  nstate = 3'd5;
                else if(C10)    nstate = 3'd3;
                else nstate=cstate;end
            3'd2:begin
                if(C5)  nstate = 3'd3;
                else if(C10) nstate = 3'd4;
                else nstate=cstate;end
            3'd5:begin
                if(C5)  nstate = 3'd3;
                else nstate=cstate;end
            default:
                nstate=cstate;
         endcase
end    
    logic [7:0]binchange,binprice;
    logic open;
always_ff@(posedge sys_clk)begin
    case(nstate)
        3'd0:begin binchange<=8'd0;binprice<=8'd0;open<=0;end
        3'd1:begin binchange<=8'd0;binprice<=8'd5;open<=0;end
        3'd2:begin binchange<=8'd0;binprice<=8'd10;open<=0;end
        3'd3:begin binchange<=8'd0;binprice<=8'd15;open<=1;end
        3'd4:begin binchange<=8'd5;binprice<=8'd20;open<=1;end
        3'd5:begin binchange<=8'd0;binprice<=8'd10;open<=0;end
     endcase
end
    bin2bcd_0 bcdchange(binchange,change);
    bin2bcd_0 bcdprice(binprice,price);
endmodule
