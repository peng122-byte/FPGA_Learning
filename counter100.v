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


module counter100 (
    input wire clk,
    input wire reset,
    input wire enable,
    output wire [3:0] ones,
    output wire [3:0] tens,
    output wire tick
);
wire tick0,ten_enable;
assign ten_enable = (ones == 4'd9) & enable;

counter_mod10 counter0 (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .count(ones),
    .tick(tick0)
);

counter_mod10 counter1 (
    .clk(clk),
    .reset(reset),
    .enable(ten_enable),
    .count(tens),
    .tick(tick)
);

endmodule







