`timescale 10ns/1ps

module nand_gate (
    input  wire a,
    input  wire b,
    output wire y
);
assign y = ~(a & b);
endmodule

module nand_gate_tb;
reg  a, b;//Input signals用reg类型定义输入信号
wire y;//Output信号用wire类型定义
nand_gate dut(
    .a(a),
    .b(b),
    .y(y)
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

initial begin
    $monitor("time=%0t a=%b b=%b y=%b", $time, a, b, y);
    $dumpfile("icarus/nand_gate.vcd");        
    $dumpvars(0, nand_gate_tb);
    #2000 $finish();

end

endmodule