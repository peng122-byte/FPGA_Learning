module register8_PS(
    input wire clk,
    input wire reset,
    input wire load,
    input wire [7:0] P_in,
    output wire S_out

);
reg [7:0] temp;
always @(posedge clk) begin
    if(reset)
        temp <= 8'b00000000;
    else if(load)
        temp <= P_in;
    else
        temp <= {1'b0, temp[7:1]};

end
assign S_out = temp[0];
endmodule









