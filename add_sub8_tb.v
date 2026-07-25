`timescale 1ns/1ps
module add_sub8(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire sub,
    output wire [7:0] sum,
    output wire carry_out,
    output wire zero, overflow
);


wire [8:0] full_result;
wire [7:0] b_selected;

assign b_selected = b ^ {8{sub}}; // Invert b for subtraction
assign full_result = {1'b0, a} + {1'b0, b_selected} + sub; // Add a and b with carry-in as sub
assign sum = full_result[7:0];
assign carry_out = full_result[8];
assign zero = (sum == 8'd00000000); // Set zero flag if sum is zero
assign overflow =
    sub
    ? ((a[7] ^ b[7]) & (sum[7] ^ a[7]))
    : (~(a[7] ^ b[7]) & (sum[7] ^ a[7]));
endmodule




module add_sub8_tb;
    reg  [7:0] a;
    reg  [7:0] b;
    reg        sub;
    wire [7:0] sum;
    wire       carry_out;
    wire       zero;
    wire       overflow;

    integer tests;
    integer errors;

    add_sub8 dut (
        .a(a),
        .b(b),
        .sub(sub),
        .sum(sum),
        .carry_out(carry_out),
        .zero(zero),
        .overflow(overflow)
    );

    task check;
        input [7:0] test_a;
        input [7:0] test_b;
        input       test_sub;
        input [8:0] expected_full;
        input       expected_overflow;
        begin
            a   = test_a;
            b   = test_b;
            sub = test_sub;
            #10;

            tests = tests + 1;

            if ({carry_out, sum} !== expected_full ||
                zero !== (expected_full[7:0] == 8'b0) ||
                overflow !== expected_overflow) begin
                errors = errors + 1;
                $display(
                    "ERROR: a=%h b=%h sub=%b expected=%b_%h zero=%b overflow=%b got=%b_%h zero=%b overflow=%b",
                    a, b, sub,
                    expected_full[8], expected_full[7:0],
                    (expected_full[7:0] == 8'b0), expected_overflow,
                    carry_out, sum, zero, overflow
                );
            end
        end
    endtask

    initial begin
        tests  = 0;
        errors = 0;

        check(8'd3,   8'd5,   1'b0, 9'h008, 1'b0); // Normal addition: 3 + 5 = 8
        check(8'd250, 8'd10,  1'b0, 9'h104, 1'b0); // Addition carry: 250 + 10 = 260
        check(8'd20,  8'd5,   1'b1, 9'h10f, 1'b0); // Normal subtraction: 20 - 5 = 15
        check(8'd5,   8'd20,  1'b1, 9'h0f1, 1'b0); // Subtraction borrow: 5 - 20 = -15
        check(8'd42,  8'd42,  1'b1, 9'h100, 1'b0); // Zero result: 42 - 42 = 0

        check(8'h7f, 8'h01,  1'b0, 9'h080, 1'b1); // Signed overflow: 127 + 1
        check(8'h80, 8'hff,  1'b0, 9'h17f, 1'b1); // Signed overflow: -128 + (-1)
        check(8'h7f, 8'hff,  1'b1, 9'h080, 1'b1); // Signed overflow: 127 - (-1)
        check(8'h80, 8'h01,  1'b1, 9'h17f, 1'b1); // Signed overflow: -128 - 1

        if (errors == 0)
            $display("PASS: all %0d add_sub8 test cases passed", tests);
        else
            $display("FAIL: %0d of %0d add_sub8 test cases failed", errors, tests);

        $finish;
    end
endmodule
