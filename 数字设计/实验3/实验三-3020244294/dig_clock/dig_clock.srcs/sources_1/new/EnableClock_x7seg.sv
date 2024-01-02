`timescale 1ns / 1ps


module EnableClock_x7seg(
    input state,
    input sys_clk,
    input sys_rst_n,
    output [1:0]enableclock
    );
     int counter;
     int res;
     always_ff @(posedge sys_clk)begin
        if(!sys_rst_n)begin 
            counter <= 0;
            res <= 0;
        end
        else if(!state)begin
            if(counter==24999)begin
                 counter <= 0;
                 if(res == 3) res <= 0;
                 else res <= res +1;
            end
            else begin
               counter <= counter + 1;
            end
        end
      end 
      assign enableclock = res;
endmodule
