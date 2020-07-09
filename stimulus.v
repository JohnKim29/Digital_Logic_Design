`timescale 1ns / 1ps

module test_bench(
    output reg clk,
    output reg reset
    );
    initial
    begin
        clk<=0;
        reset<=0;
        #1
        reset<=1;
     end
     
     always
        #1 clk <= ~clk;
endmodule
