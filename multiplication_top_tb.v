`timescale 1ps/1ps

module multiplication_top_tb;
    reg [63:0] a_in, b_in;
    reg clk, reset, start;
    wire ready;
    wire [128:0]result;
    
    integer i;

    multiplication_top mlt1(a_in, b_in, result, clk, reset, start, ready);

    always #1 clk = ~clk;

    initial begin
        reset = 1; clk = 1; a_in = 64'd0; b_in = 64'd0; start = 0;
        #2;
        reset = 0;
        a_in = 17;
        b_in = 27;
        start = 1;
        #4;
        for (i = 0; i < 100; i = i + 1) begin
            while (ready == 0) begin
                #2; 
            end
            $display("%d. \t time = %d \t a_in = %d \t b_in = %d \t result = %d", i+1, $time, a_in, b_in, result);
            start = 1;
            a_in = (a_in+b_in)*3;
            b_in = a_in - 137*i;
            #2;
        end 
        #10 $finish;
    end
endmodule