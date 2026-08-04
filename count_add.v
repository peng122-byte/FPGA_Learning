module count_add (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output reg  [7:0] count,
    output reg        tick
);

always @(posedge clk) begin
    if (reset) begin
        count <= 8'd0;
        tick <= 1'b0;
    end
    else begin
        tick <= 1'b0;
        if(enable) begin
            if(count == 8'hff) begin
                count <= 8'd0;
                tick <= 1'b1;
            end
            else begin
                count <= count + 1'b1;
            end
        end
    end
end
endmodule