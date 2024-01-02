`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 22:12:25
// Design Name: 
// Module Name: dec_74LS138
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


module dec_74LS138(input logic [2:0]d1,
    output logic [7:0]y1
    );
    always_comb begin
        case(d1)
            3'b000:y1=8'b11111110;
            3'b001:y1=8'b11111101;
            3'b010:y1=8'b11111011;
            3'b011:y1=8'b11110111;
            3'b100:y1=8'b11101111;
            3'b101:y1=8'b11011111;
            3'b110:y1=8'b10111111;
            3'b111:y1=8'b01111111;
           endcase
    end
endmodule
