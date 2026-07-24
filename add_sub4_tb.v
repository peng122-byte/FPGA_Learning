`timescale 1ns/1ps
module add_sub4 (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire subtract,
    output wire [3:0] result,
    output wire carry_out,
    output wire zero
);

wire [4:0] full_result;
wire [3:0] b_selected;

assign b_selected = {4{subtract}} ^ b; // If subtract is 1, invert b for subtraction
assign full_result = {1'b0, a} + {1'b0, b_selected} + subtract; // Add a and b_selected with carry-in as subtract
assign result = full_result[3:0];
assign carry_out = full_result[4];
assign zero = (result == 4'b0000);
endmodule






module add_sub4_tb;

reg  [3:0] a;
reg  [3:0] b;
reg        subtract;
wire [3:0] result;
wire       carry_out;
wire       zero;

integer errors;

add_sub4 dut (
    .a(a),
    .b(b),
    .subtract(subtract),
    .result(result),
    .carry_out(carry_out),
    .zero(zero)
);

task check;
    input [3:0] test_a;
    input [3:0] test_b;
    input       test_subtract;
    input [4:0] expected_full;
    begin
        a        = test_a;
        b        = test_b;
        subtract = test_subtract;
        #10;

        if ({carry_out, result} !== expected_full) begin
            $display(
                "ERROR: a=%h b=%h sub=%b expected=%b_%h got=%b_%h",
                a, b, subtract,
                expected_full[4], expected_full[3:0],
                carry_out, result
            );
            errors = errors + 1;
        end

        if (zero !== (expected_full[3:0] == 4'b0000)) begin
            $display("ERROR: incorrect zero flag");
            errors = errors + 1;
        end
    end
endtask

initial begin
    errors = 0;

    check(4'd3,  4'd5,  1'b0, 5'b0_1000); // 3 + 5 = 8
    check(4'd15, 4'd1,  1'b0, 5'b1_0000); // 15 + 1 = 16
    check(4'd9,  4'd4,  1'b1, 5'b1_0101); // 9 - 4 = 5, no borrow
    check(4'd4,  4'd9,  1'b1, 5'b0_1011); // 4 - 9 = -5, low 4 bits B
    check(4'd7,  4'd7,  1'b1, 5'b1_0000); // 7 - 7 = 0

    if (errors == 0)
        $display("PASS: all add_sub4 test cases passed");
    else
        $display("FAIL: %0d add_sub4 error(s)", errors);
    #10;

    $finish;
end

endmodule