`timescale 1ns / 1ps

module testbench(
    output [7:0]seg_out,
    output [3:0]seg_digit
    );
    wire clk,reset;
    
    digital_clock U0(
        seg_out,
        seg_digit,
        clk,
        reset
    );
    
    stimulus U1(
        clk,
        reset
    );
endmodule
