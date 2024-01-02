`timescale 1ns / 1ps


module x7seg(
    input sys_clk,
    input sys_rst_n,
    input [7:0] min,
    input [7:0] sec,
    input [1:0]enableclock,
    output [3 : 0] an,
    output [7 : 0] a_to_g
    );

    logic [3:0] num;
    logic [3:0]an;
    logic [7:0]a_to_g;
    always_comb begin
        case(enableclock)
            2'b00:begin an = 4'b0001; num = sec[3:0]; end
            2'b01:begin an = 4'b0010; num = sec[7:4]; end
            2'b10:begin an = 4'b0100; num = min[3:0]; end
            2'b11:begin an = 4'b1000; num = min[7:4]; end
        endcase
    end
    
    always_comb begin
        case(num)
            4'b0000:a_to_g=8'b01000000;
            4'b0001:a_to_g=8'b01111001;
            4'b0010:a_to_g=8'b00100100;
            4'b0011:a_to_g=8'b00110000;
            4'b0100:a_to_g=8'b00011001;
            4'b0101:a_to_g=8'b00010010;
            4'b0110:a_to_g=8'b00000010;
            4'b0111:a_to_g=8'b01111000;
            4'b1000:a_to_g=8'b00000000;
            4'b1001:a_to_g=8'b00011000;
            default:a_to_g=8'b01000000;
        endcase
    end
endmodule