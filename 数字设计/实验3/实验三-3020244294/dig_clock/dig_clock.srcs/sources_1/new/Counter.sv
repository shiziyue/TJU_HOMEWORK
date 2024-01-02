`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 14:09:44
// Design Name: 
// Module Name: Counter
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


module Counter(
    input en,
    input sys_clk,
    input sys_rst_n,
    output [7:0]m
    );
    logic [7:0]m;
    always_ff @(posedge sys_clk)begin
        if(sys_rst_n) m <= 0;
        else if(en) begin
            if(m==59) m<=0;
            else m <= m + 1; 
        end
    end
    
    
    
endmodule
