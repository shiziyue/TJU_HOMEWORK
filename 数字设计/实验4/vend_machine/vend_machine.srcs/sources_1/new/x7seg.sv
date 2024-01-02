`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/03 09:26:59
// Design Name: 
// Module Name: x7seg
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


module x7seg(
    input sys_clk,
    input sys_rst_n,
    input [7:0]change,
    input [7:0]price,
    output [3:0]an,
    output [7:0]an_to_g
    );
    logic [1:0]clock;
    logic [3:0]temp_an;
    logic [3:0]temp;
    logic [7:0]temp_to_g;
    integer m;
    Enableclock enclock(sys_clk,sys_rst_n,clock);

    always_comb begin
        case(clock)
            2'b00:  begin temp_an=4'b0001; temp=price[3:0];end
            2'b01:  begin temp_an=4'b0010; temp=price[7:4];end
            2'b11:  begin temp_an=4'b1000; temp=change[7:4];end
            2'b10:  begin temp_an=4'b0100; temp=change[3:0];end
        endcase
    end
    always_comb begin
        case(temp)
            4'd0:temp_to_g=8'b01000000;
            4'd1:temp_to_g=8'b01111001;
            4'd2:temp_to_g=8'b00100100;
            4'd3:temp_to_g=8'b00110000;
            4'd4:temp_to_g=8'b00011001;
            4'd5:temp_to_g=8'b00010010;
            4'd6:temp_to_g=8'b00000010;
            4'd7:temp_to_g=8'b01111000;
            4'd8:temp_to_g=8'b00000000;
            4'd9:temp_to_g=8'b00011000;
            default:temp_to_g=8'b00000000;
         endcase  
     end
     assign an=temp_an;
     assign an_to_g=temp_to_g;
endmodule
