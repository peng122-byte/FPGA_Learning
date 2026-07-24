`timescale 100ns/1ps

module logic_gates(
    input wire a,
    input wire b,
    output wire y_and,
    output wire y_or,
    output wire y_not,
    output wire y_xor
);
assign y_and = a & b;
assign y_or = a | b;
assign y_not = ~a;
assign y_xor = a ^ b;    

endmodule

module logic_gates_tb;
reg  a, b;//Input signals用reg类型定义输入信号
wire y_and, y_or, y_not, y_xor;//Output信号用wire类型定义

logic_gates dut(
    .a(a),
    .b(b),
    .y_and(y_and),
    .y_or(y_or),
    .y_not(y_not),
    .y_xor(y_xor)
);
initial begin
    a = 1'b0;
    b = 1'b0;
    #10;

    a = 1'b0;
    b = 1'b1;
    #10;

    a = 1'b1;
    b = 1'b0;
    #10;

    a = 1'b1;
    b = 1'b1;
    #10;

    $finish;
end

integer errors;

initial begin
    errors = 0;

    a = 0; b = 0; #10;
    if ({y_and, y_or, y_xor, y_not} !== 4'b1001)
        errors = errors + 1;

    a = 0; b = 1; #10;
    if ({y_and, y_or, y_xor, y_not} !== 4'b0111)
        errors = errors + 1;

    a = 1; b = 0; #10;
    if ({y_and, y_or, y_xor, y_not} !== 4'b0110)
        errors = errors + 1;

    a = 1; b = 1; #10;
    if ({y_and, y_or, y_xor, y_not} !== 4'b1100)
        errors = errors + 1;

    if (errors == 0)
        $display("PASS: all test cases passed");
    else
        $display("FAIL: %0d test case(s) failed", errors);

    $finish;
end

initial begin
    $monitor("time=%0t a=%b b=%b y_and=%b y_or=%b y_not=%b y_xor=%b", $time, a, b, y_and, y_or, y_not, y_xor);
end

initial begin
    $dumpfile("icarus/logic_gates.vcd");        
    $dumpvars(0, logic_gates_tb);
    #2000 $finish();
end
endmodule