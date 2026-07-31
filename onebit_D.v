
module onebit_D (
    input  wire clk,
    input  wire reset,
    input  wire reset_n,
    input wire enable,
    input  wire d,
    output reg  q
);

always @(posedge clk or negedge reset_n) begin
    if ((!reset_n) || (reset))
        q <= 1'b0;
    else if(enable)
        q <= d;
end

endmodule












