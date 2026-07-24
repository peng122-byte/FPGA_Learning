`timescale 1ns/1ps

module simple_alu (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [2:0] op,
    output wire [3:0] y,
    output wire       zero
);

assign y = (op == 2'b000) ? (a + b) :
           (op == 2'b001) ? (a - b) :
           (op == 2'b010) ? (a & b) :
           (op == 2'b100) ? (a | b) :
           (a^b);

assign zero = (y == 4'b0000);

endmodule
module simple_alu_tb;

reg  [3:0] a;
reg  [3:0] b;
reg  [1:0] op;
wire [3:0] y;
wire       zero;

integer errors;

simple_alu dut (
    .a(a),
    .b(b),
    .op(op),
    .y(y),
    .zero(zero)
);

initial begin
    errors = 0;

    a = 4'd3;  b = 4'd5;  op = 2'b00; #10;
    if ((y !== 4'd8) || (zero !== 1'b0)) errors = errors + 1;

    a = 4'd9;  b = 4'd4;  op = 2'b01; #10;
    if ((y !== 4'd5) || (zero !== 1'b0)) errors = errors + 1;

    a = 4'b1100; b = 4'b1010; op = 2'b10; #10;
    if ((y !== 4'b1000) || (zero !== 1'b0)) errors = errors + 1;

    a = 4'b0101; b = 4'b1010; op = 2'b11; #10;
    if ((y !== 4'b1111) || (zero !== 1'b0)) errors = errors + 1;

    a = 4'd5;  b = 4'd5;  op = 2'b01; #10;
    if ((y !== 4'd0) || (zero !== 1'b1)) errors = errors + 1;

    if (errors == 0)
        $display("PASS: all ALU test cases passed");
    else
        $display("FAIL: %0d ALU test case(s) failed", errors);

    $finish;
end

endmodule