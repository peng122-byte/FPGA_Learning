module add_sub8(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire sub,
    output wire [7:0] sum,
    output wire carry_out,
    output wire zero
);
wire [8:0] full_result;
wire [7:0] b_selected;
assign b_selected = b ^ {8{sub}}; // Invert b for subtraction
assign full_result = {1'b0, a} + {1'b0, b_selected} + sub; // Add a and b with carry-in as sub
assign sum = full_result[7:0];
assign carry_out = full_result[8];
assign zero = (sum == 8'd0); // Set zero flag if sum is zero
endmodule








