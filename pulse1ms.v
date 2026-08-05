module pulse1ms (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg pulse,
    output reg [13:0] count
);


always @(posedge clk) begin
    if(reset) begin
        count <= 14'b0;
        pulse <= 1'b0;

    end
    else begin
        pulse <= 1'b0;
            if(enable) begin
                if(count == 14'd9999) begin
                    count <= 14'b0;
                    pulse <= 1'b1;
                end
                else begin
                    count <= count + 1'b1;
                end
            end
        end
end

endmodule