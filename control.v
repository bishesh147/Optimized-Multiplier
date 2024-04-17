module control(clk, reset, start, data_in, ready, wr, initial_wr, sh_right);
    input clk, reset, start;
    input data_in;
    output wr;
    output initial_wr;
    output sh_right;
    output ready;
    
    wire wr_check;
    wire initial_wr_check;
    wire sh_right_check;
    wire ready_check;
    
    reg [1:0] state;
    reg [9:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'd0;
            counter <= 10'd0;
        end
        else begin
            case (state)
                2'b00: begin //Idle state
                    if (start == 1) state <= 2'b01;
                end

                2'b01: begin //Load state
                    counter <= 0;
                    state <= 2'b10;
                end

                2'b10: begin //Operation state
                    if (counter == 63) state <= 2'b00;
                    counter <= counter+1;
                end
            endcase
        end
    end
    assign wr_check = (state == 2'b10) && data_in;
    assign wr = wr_check?1:0;
    
    assign initial_wr_check = (state == 2'b01);
    assign initial_wr = initial_wr_check?1:0;
    
    assign sh_right_check = (state == 2'b10);
    assign sh_right = sh_right_check?1:0;
    
    assign ready_check = (state == 2'b00);
    assign ready = ready_check?1:0;
endmodule
