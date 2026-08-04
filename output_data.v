module counter_mod10 (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output reg  [3:0] count,
    output reg        tick
);

always @(posedge clk) begin
    if (reset) begin
        count <= 4'd0;
        tick  <= 1'b0;
    end else begin
        tick <= 1'b0;
        if (enable) begin
            if (count == 4'd9) begin
                count <= 4'd0;
                tick  <= 1'b1;
            end else begin
                count <= count + 1'b1;
            end
        end
    end
end

endmodule