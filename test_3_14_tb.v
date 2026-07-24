`timescale 10ns/1ps
module three_bits_choose(
    input wire a,
    input wire b,
    input wire c,
    output wire y
);
assign y = ((~a & b & c)|(a & ~b & c)|(a & b & ~c)|(a & b & c));
endmodule

module three_bits_choose_tb;
reg a,b,c;
wire y;

three_bits_choose dut(
    .a(a),
    .b(b),
    .c(c),
    .y(y)
);

initial begin
    a = 0; b = 0; c = 0; 
    if (y !== 1'b0) $display("Test case 1 failed: y = %b", y);
    #10;
    a = 0; b = 0; c = 1; 
    if (y !== 1'b0) $display("Test case 2 failed: y = %b", y);
    #10;

    a = 0; b = 1; c = 0; 
    if (y !== 1'b0) $display("Test case 3 failed: y = %b", y);
    #10;

    a = 0; b = 1; c = 1; 
    if (y !== 1'b1) $display("Test case 4 failed: y = %b", y);
    #10;

    a = 1; b = 0; c = 0; 
    if (y !== 1'b0) $display("Test case 5 failed: y = %b", y);
    #10;

    a = 1; b = 0; c = 1; 
    if (y !== 1'b1) $display("Test case 6 failed: y = %b", y);
    #10;

    a = 1; b = 1; c = 0; 
    if (y !== 1'b1) $display("Test case 7 failed: y = %b", y);
    #10;

    a = 1; b = 1; c = 1; 
    if (y !== 1'b1) $display("Test case 8 failed: y = %b", y);
    #10;

    $display("All test cases completed.");
    $finish;
end

initial begin
    $monitor ("At time %t: a = %b, b = %b, c = %b, y = %b", $time, a, b, c, y);
    $dumpfile("icarus/three_bits_choose_tb.vcd");
    $dumpvars(0, three_bits_choose_tb);
    #2000
    $finish;
end

endmodule












