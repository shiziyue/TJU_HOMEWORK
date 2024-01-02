`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 17:59:49
// Design Name: 
// Module Name: state_change
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


module state_change(
    input sys_clk,
    input sys_rst_n,
    input pos_edge,
    output state
    );
    
    logic now;
    always_ff @(posedge sys_clk)begin
        if(!sys_rst_n) now <= 1;
        else begin
            if(pos_edge == 1) now = ~now;
        end 
    end
    
    assign state = now;
    
endmodule
