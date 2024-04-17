module adder_df(sum, a, b);
    input [63:0]a;
    input [64:0]b;
    output [64:0]sum;
    assign sum = {1'd0,a} + b;
endmodule
