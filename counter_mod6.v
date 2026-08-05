module counter_mod6 (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [2:0] count,
    output reg tick
);

always @(posedge clk) begin
    if(reset)begin
        count <= 3'b0;
        tick <= 1'b0;
    end
    else begin
        tick <= 1'b0; 
        if(enable) begin
            if(count == 3'd5) begin
                count <= 3'b0;
                tick <= 1'b1;
                end
            else begin
                tick <= 1'b0;
                count <= count + 1;
            end
        end
    end
end
endmodule































