module move(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire direction,
    input wire logic_mode,
    input wire load,
    input wire [7:0] input_data,
    output reg [7:0] output_data
);

always @(posedge clk) begin
    if (reset)
        output_data <= 8'b00000000;
    else if (load)
        output_data <= input_data;
    else if (enable) begin
        if (logic_mode) begin
            if (direction)
                output_data <= {output_data[6:0],1'b0};
            else
                output_data <= {1'b0,output_data[7:1]};
            end
        else begin
            if (direction)
                output_data <= {output_data[6:0],output_data[7]};
            else
                output_data <= {output_data[0],output_data[7:1]};
            end
    end
end

endmodule