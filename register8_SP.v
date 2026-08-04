module register8_SP(
    input wire clk,
    input wire reset,
    input wire serial_in,
    output wire [7:0] P_Out
);

reg [7:0] temp;
always @(posedge clk) begin
    if(reset)
        temp <= 8'b00000000;
    else
    temp <= {temp[6:0], serial_in};
end
assign P_Out = temp;
endmodule