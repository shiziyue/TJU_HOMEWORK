`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 14:09:44
// Design Name: 
// Module Name: Timer
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


module Timer(
    input en,
    input sys_clk,
    input sys_rst_n,
    output clk_flag
    );
    logic clk_flag;
    integer counter = 0;
    always_ff @(posedge sys_clk)begin
        if(sys_rst_n) clk_flag <= 0;
        else if(en) counter <= counter+1;
    end
    
    always_comb begin
        if(counter==24999999)begin 
            clk_flag <= 1;
            counter = 24999999;
        end
        else clk_flag <= 0;
    end
    
endmodule
