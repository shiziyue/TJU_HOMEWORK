`timescale 1ns / 1ps


module btn_change(
    input sys_clk,
    input i_start,
    output pos_edge
    );
    logic dff0_Q,dff1_Q;
    always_ff @(posedge sys_clk)begin
        dff0_Q <= i_start;
        dff1_Q <= dff0_Q;
    end
    assign pos_edge = dff0_Q&~dff1_Q;
    
endmodule