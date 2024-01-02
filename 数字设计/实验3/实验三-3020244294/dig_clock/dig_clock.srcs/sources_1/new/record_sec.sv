`timescale 1ns / 1ps


module record_sec(
    input state,
    input sys_clk,
    input sys_rst_n,
    output [7:0]sec
    );
    int counter;
    logic [7:0]binsec;
    always_ff @(posedge sys_clk)begin
        if(!sys_rst_n)begin 
            counter = 0;
            binsec = 0;
        end
        else if(!state)begin
            if(counter==24999999)begin
                counter <= 0;
                if(binsec == 59) binsec <= 0;
                else binsec = binsec + 1;
            end
            else counter = counter + 1;
        end
    end
    
    bin2bcd_0 bcdsec(binsec,sec);
    
endmodule