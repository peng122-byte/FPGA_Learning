`timescale 1ns/1ps
module Alu_8bits(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [2:0] op,
    output wire [7:0] y,
    output wire zero

);

assign y = (op == 3'b000) ? (a + b) :
           (op == 3'b001) ? (a - b) :
           (op == 3'b010) ? (a & b) :
           (op == 3'b011) ? (a | b) :
           (op == 3'b100) ? (a ^ b) :
           (op == 3'b101) ? (a << 1) :
           (op == 3'b110) ? (a >> 1) :
           (op == 3'b111) ? (b) :
           8'b00000000;

assign zero = (y == 8'b00000000) ? 1 : 0;
           
endmodule

module Alu_8bits_tb;
reg [7:0] a;
reg [7:0] b;
reg [2:0] op;
wire [7:0] y;
wire zero;
integer i;

Alu_8bits dut (
    .a(a),
    .b(b),
    .op(op),
    .y(y),
    .zero(zero)
);

initial begin
    a = 8'b00000001;b = 8'b00000010;
    
    op = 3'b000;
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);
    op = 3'b001;   
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);
    op = 3'b010;
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);
    op = 3'b011;
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);
    op = 3'b100; 
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);
    
    op = 3'b101;
    
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);

    op = 3'b110;
    
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);
    op = 3'b111;
    #10;
    $display ("op: %b, a: %b, b: %b, y: %b, zero: %b", op, a, b, y, zero);
    $finish;
end





endmodule







