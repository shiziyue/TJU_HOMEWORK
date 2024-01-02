`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 16:41:38
// Design Name: 
// Module Name: Show4
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


module Show4(
//    input en,
//    input sys_clk,
//    input sys_rst_n,
//    output clk_f
//    );
//    logic clk_f;
//    integer counter = 0;
//    always_ff @(posedge sys_clk)begin
//        if(sys_rst_n) clk_f = 0;
//        else if(en) counter = counter+1;
//    end
    
//    always @(*)begin
//        if(counter==24999)begin 
//            clk_f <= 1;
//            counter = 24999;
//        end
//        else clk_f <= 0;
//    end
    input sys_clk,
    input rs,
    output integer m
    );
    always_ff@(posedge sys_clk)begin
       if(rs)m<=0;
       else begin
           if(m==24999)m<=0;
           else m<=m+1;
       end
    end
endmodule
