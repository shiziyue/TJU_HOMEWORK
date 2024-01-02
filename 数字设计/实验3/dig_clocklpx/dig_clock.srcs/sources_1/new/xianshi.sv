`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 12:30:35
// Design Name: 
// Module Name: xianshi
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


module xianshi(
    input sys_clk,
    input rs,
    input[7:0]s,
    input[7:0]m,
    output [3:0]a,
    output[7:0]b
    );
    logic[3:0]a;
    logic[7:0]b;
    integer c,e;
    logic[1:0] d;
    xian4 x(sys_clk,rs,c);
    always_ff@(posedge sys_clk)begin
        if(rs) d<=0;
        else if(c==24999)begin
            if(d==3)d<=0;
            else d<=d+1;
        end
    end
    always_comb begin
        case(d)
            2'b00:begin a=4'b0001;e=s-(s/10)*10;end
            2'b01:begin a=4'b0010;e=s/10;end
            2'b10:begin a=4'b0100;e=m-(m/10)*10;end
            2'b11:begin a=4'b1000;e=m/10;end
        endcase
    end
    always_comb begin
        case(e)
            32'd0:b=8'b01000000;
            32'd1:b=8'b01111001;
            32'd2:b=8'b00100100;
            32'd3:b=8'b00110000;
            32'd4:b=8'b00011001;
            32'd5:b=8'b00010010;
            32'd6:b=8'b00000010;
            32'd7:b=8'b01111000;
            32'd8:b=8'b00000000;
            32'd9:b=8'b00011000;
            default:b=8'b00000000;
        endcase
    end
endmodule
