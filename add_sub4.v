module add_sub4 (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire sub,
    output wire [3:0] sum,
    output wire carry_out,
    output wire zero
);

wire [4:0] full_result;
wire [3:0] b_selected;

assign b_selected = {4{sub}} ^ b; // If sub is 1, invert b for subtraction
assign full_result = {1'b0, a} + {1'b0, b_selected} + sub; // Add a and b_selected with carry-in as sub
assign sum = full_result[3:0];
assign carry_out = full_result[4];
assign zero = (sum == 4'b0000);
endmodule


