module three_to_eight(
    input wire [2:0] in,
    input wire enable,
    output reg [7:0] out  
);
always @(*) begin
    if (enable) begin
        out = 8'b0;
        out[in] = 1'b1;
    end 
    else out = 8'b0;
    
end
endmodule





