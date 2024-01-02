`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 08:14:54
// Design Name: 
// Module Name: alu
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


module alu(
    input [3 : 0] A,
    input [3 : 0] B,
    input [3 : 0] aluop,
    output logic [7 : 0] alures,
    output logic ZF,
    output logic OF
    );
    logic Coutadd,Coutsub;
    logic [3:0] Sadd;
    logic [3:0] Ssub;
    rca addResult(A,B,0,Sadd,Coutadd);
    rca subResult(A,~B,1,Ssub,Coutsub);
    always_comb begin
        OF = 0;
        alures[7:4] = 4'b0000;

        case(aluop)
            4'b0000:    alures[3:0] = A&B;
            4'b0001:    alures[3:0] = A|B;
            4'b0010:    alures[3:0] = A^B;
            4'b0011:    alures[3:0] = ~(A&B);
            4'b0100:    alures[3:0] = ~A;
            4'b0101:    alures[3:0] = A<<B[2:0];
            4'b0110:    alures[3:0] = A>>B[2:0];
            4'b0111:    alures[3:0] = $signed(A)>>>B[2:0];
            4'b1000:    alures = A*B;
            4'b1001:    alures= {{4{A[3]}},A}*{{4{B[3]}},B};
            4'b1010:    begin
                            alures[3:0] = Sadd;
                            if(A[3]==B[3] && Sadd[3]!=A[3])  OF = 1;
                            else OF = 0;
                         end
            4'b1011:     alures[3:0] = Sadd;
            4'b1100:    begin
                                alures[3:0] = Ssub;
                                if(A[3]!=B[3] && Ssub[3]!=A[3])  OF = 1;
                                else OF = 0;
                         end
            4'b1101:    alures[3:0] = Ssub;
            4'b1110:    alures[3:0]=$signed(A)<$signed(B)?1:0;
            4'b1111:    alures[3:0] = A<B?1:0;
        endcase
    end
        assign ZF = (alures==0) ?   1   :   0;
endmodule
