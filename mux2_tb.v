`timescale 1ns/1ps
module mux2 #(
    parameter WIDTH = 4
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             select,
    output wire [WIDTH-1:0] y
);

assign y = select ? a : b;

endmodule

module mux2_tb;

reg  [3:0] a;
reg  [3:0] b;
reg        select;
wire [3:0] y;

integer errors;

mux2 #(
    .WIDTH(4)
) dut (
    .a(a),
    .b(b),
    .select(select),
    .y(y)
);

initial begin
    errors = 0;

    a = 4'h3; b = 4'hC; select = 1'b0; #10;
    if (y !== 4'hC) begin
        $display("ERROR: select=0, expected C, got %h", y);
        errors = errors + 1;
    end

    select = 1'b1; #10;
    if (y !== 4'h3) begin
        $display("ERROR: select=1, expected 3, got %h", y);
        errors = errors + 1;
    end

    a = 4'hA; b = 4'h5; select = 1'b0; #10;
    if (y !== 4'h5) begin
        $display("ERROR: select=0, expected 5, got %h", y);
        errors = errors + 1;
    end

    select = 1'b1; #10;
    if (y !== 4'hA) begin
        $display("ERROR: select=1, expected A, got %h", y);
        errors = errors + 1;
    end

    if (errors == 0)
        $display("PASS: all mux2 test cases passed");
    else
        $display("FAIL: %0d mux2 test case(s) failed", errors);

    $finish;
end
initial begin
    $dumpfile("icarus/mux2_tb.vcd");
    $dumpvars(0, mux2_tb);
end
endmodule