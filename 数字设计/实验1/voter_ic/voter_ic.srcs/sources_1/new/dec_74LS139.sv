`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 22:12:25
// Design Name: 
// Module Name: dec_74LS139
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


module dec_74LS139(input logic [1:0]d2,
output logic [3:0]y2    );
    always_comb begin
            case(d2)
                2'b00:y2=4'b1110;
                2'b01:y2=4'b1101;
                2'b10:y2=4'b1011;
                2'b11:y2=4'b0111;
            endcase
    end
endmodule
