module product_register(clk, reset, data_in, wr, initial_data_in, initial_wr, sh_right, data_out);
    input [64:0] data_in;
    input [63:0] initial_data_in;
    input clk, reset, wr, initial_wr, sh_right;
    output [128:0] data_out;

    reg [128:0] prod_reg;

    always @(posedge clk) begin
        if (reset) prod_reg <= 129'd0;
        else begin
            if (initial_wr == 1) prod_reg <= {65'd0, initial_data_in};
            else begin
                if (wr == 1) prod_reg <= {1'd0, data_in, data_out[63:1]};         
                else if (sh_right == 1) prod_reg <= {1'd0, data_out[128:1]};
            end
        end
    end

    assign data_out = prod_reg;
endmodule

        