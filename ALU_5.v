module alu_5 (
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [3:0] op,
    output wire [7:0] y,
    output wire zero
);

reg [7:0] result;

always @(*) begin
    case (op)
        4'b0000: result = a + b; // Addition
        4'b0001: result = a - b; // Subtraction
        4'b0010: result = a & b; // Bitwise AND
        4'b0011: result = a | b; // Bitwise OR
        4'b0100: result = a ^ b; // Bitwise XOR
        4'b0101: result = ~a;     // Bitwise NOT
        4'b0110: result = a << 1; // Left shift
        4'b0111: result = a >> 1; // Right shift
        default: result = 8'b0;   // Default case
    endcase
end
assign y = result;
assign zero = (result == 8'b0);
endmodule
