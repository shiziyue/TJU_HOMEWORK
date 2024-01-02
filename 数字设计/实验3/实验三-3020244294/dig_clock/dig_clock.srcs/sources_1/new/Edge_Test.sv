`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 14:09:44
// Design Name: 
// Module Name: Edge_Test
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


module Edge_Test(
    input sys_clk,
    input i_btn,
    output pos_edge
    );
    logic dff1_Q;
    logic dff0_Q; 
    
    always_ff @(posedge sys_clk)begin
            dff0_Q <= i_btn;
            dff1_Q <= dff0_Q;
    end
    
    assign pos_edge = dff0_Q&&~dff1_Q;
    
endmodule
