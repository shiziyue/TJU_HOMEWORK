`timescale 1ns / 1ps


module record_min(
    input state,
    input sys_clk,
    input sys_rst_n,
    output [7:0]min
    );
    int counter;
    logic [7:0]binmin;
    always_ff @(posedge sys_clk)begin
        if(!sys_rst_n)begin 
            counter = 0;
            binmin = 0;
        end
        else if(!state)begin
            if(counter==1499999999)begin
                counter <= 0;
                if(binmin == 59) binmin <= 0;
                else binmin = binmin + 1;
            end
            else counter = counter + 1;
        end
    end
    
    bin2bcd_0 bcdmin(binmin,min);
    
endmodule