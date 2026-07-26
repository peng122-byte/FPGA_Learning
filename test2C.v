`timescale 1ns/1ps
module ALU_8bits(
    input wire [7:0] a, b,
    input wire [2:0] op,
    output reg [7:0] result,
    output reg zero, carry_out 
);

always @(*) begin
    carry_out = 0;
    zero = 0;
    case(op)
        3'b000: {carry_out, result} = a + b; // Addition
        3'b001: {carry_out, result} = a - b; // Subtraction
        3'b010: result = a & b;               // AND
        3'b011: result = a | b;               // OR
        3'b100: result = a ^ b;               // XOR
        3'b101: result = (a < b);             //compare
        3'b110: result = a << 1;              // Shift left
        3'b111: result = a >> 1;              // Shift right
        default: result = 8'b00000000;
    endcase
    if (result == 8'b00000000) begin
        zero = 1;
    end else begin
        zero = 0;
    end
end

endmodule

module test_ALU_8bits;
reg [7:0] a, b;
reg [2:0] op;
wire [7:0] result;
wire zero, carry_out;
ALU_8bits dut (
    .a(a),
    .b(b),
    .op(op),
    .result(result),
    .zero(zero),
    .carry_out(carry_out)
);

integer errors;
task check;
    input reg[7:0] expected_result;
    input reg zero_expected;
    input reg carry_out_expected;
begin
    if (result != expected_result) begin
        $display("Test failed for operation %b: expected %b, got %b", op, expected_result, result);
        errors = errors + 1;
    end
    if (zero != zero_expected) begin
        $display("Test failed for operation %b: expected zero=%b, got zero=%b", op, zero_expected, zero);
        errors = errors + 1;
    end
    if (carry_out != carry_out_expected) begin
        $display("Test failed for operation %b: expected carry_out=%b, got carry_out=%b", op, carry_out_expected, carry_out);
        errors = errors + 1;
    end
end    
endtask
    initial begin
        errors = 0;
        a = 8'b00001111; b = 8'b00000001; op = 3'b000; #10; check(8'b00010000, 0, 0); // Addition
        
        a = 8'b11111111; b = 8'b00000001; op = 3'b000; #10; check(8'b00000000, 1, 1); // Addition with carry
        a = 8'b00001111; b = 8'b00000001; op = 3'b001; #10; check(8'b00001110, 0, 0); // Subtraction
        a = 8'b01010101; b = 8'b01010101; op = 3'b001; #10; check(8'b00000000, 1, 0); // Equal subtraction
        a = 8'b00000000; b = 8'b00000001; op = 3'b001; #10; check(8'b11111111, 0, 1); // Subtraction with borrow
        a = 8'b00001111; b = 8'b00000001; op = 3'b010; #10; check(8'b00000001, 0, 0); // AND
        a = 8'b11110000; b = 8'b00001111; op = 3'b010; #10; check(8'b00000000, 1, 0); // AND producing zero
        a = 8'b00001111; b = 8'b00000001; op = 3'b011; #10; check(8'b00001111, 0, 0); // OR
        a = 8'b00000000; b = 8'b00000000; op = 3'b011; #10; check(8'b00000000, 1, 0); // OR producing zero
        a = 8'b00001111; b = 8'b00000001; op = 3'b100; #10; check(8'b00001110, 0, 0); // XOR
        a = 8'b10101010; b = 8'b10101010; op = 3'b100; #10; check(8'b00000000, 1, 0); // XOR producing zero
        a = 8'b00001111; b = 8'b00000001; op = 3'b101; #10; check(8'b00000000, 1, 0); // compare
        a = 8'b00000000; b = 8'b11111111; op = 3'b101; #10; check(8'b00000001, 0, 0); // Compare minimum and maximum
        a = 8'b11111111; b = 8'b11111111; op = 3'b101; #10; check(8'b00000000, 1, 0); // Compare equal values
        a = 8'b00001111; b = 8'b00000001; op = 3'b110; #10; check(8'b00011110, 0, 0); // Shift left
        a = 8'b10000000; b = 8'b00000000; op = 3'b110; #10; check(8'b00000000, 1, 0); // Shift left producing zero
        a = 8'b00001111; b = 8'b00000001; op = 3'b111; #10; check(8'b00000111, 0, 0); // Shift right
        a = 8'b00000001; b = 8'b00000000; op = 3'b111; #10; check(8'b00000000, 1, 0); // Shift right producing zero
        if(errors == 0) begin
            $display("All tests passed!");
        end else begin
            $display("%d tests failed.", errors);
        end 
    $finish;

end
endmodule





















