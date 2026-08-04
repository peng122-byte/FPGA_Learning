module running_led (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    input  wire       direction,
    input wire        P_Flag,
    input wire  [7:0] P_in,
    output reg  [7:0] led
);

always @(posedge clk) begin
    if (reset)
        led <= 8'b0000_0001;
    else if (P_Flag)
        led <= P_in;
    else if (enable) begin
        
        if (direction)
            led <= {led[6:0], led[7]};
        else
            led <= {led[0], led[7:1]};
    end
end

endmodule