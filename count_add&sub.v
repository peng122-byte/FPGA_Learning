module count_add_sub (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire add_sub, // 1 for add, 0 for sub
    output reg [7:0] count,
    output reg tick
);

always @(posedge clk) begin
    if (reset) begin
        count <= 8'd0;
        tick <= 1'b0;
    end
    else begin
        tick <= 1'b0;
        if(enable) begin
            if(add_sub)
                if(count == 8'hff) begin
                count <= 8'd0;
                tick <= 1'b1;
                end
                else 
                count <= count + 1'b1;
            else
                if(count == 8'h00) begin
                count <= 8'hff;
                tick <= 1'b1;
                end
                else
                count <= count - 1'b1;
        end
    end
end
endmodule





