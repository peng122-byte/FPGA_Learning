module register8 (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    input  wire [7:0] d,
    output reg  [7:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 8'b0000_0000;
    else if (enable)
        q <= d;
end

endmodule