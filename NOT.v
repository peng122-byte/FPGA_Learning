`timescale 10ns/1ps
module not_gate (
    input  wire a,
    output wire y
);
assign y = ~a;
endmodule

module not_gate_tb;
reg  a;//Input signals用reg类型定义输入信号
wire y;//Output信号用wire类型定义
not_gate dut(
    .a(a),
    .y(y)
);


initial begin
    a = 1'b0;
    #10;

    a = 1'b1;
    #10;

    $finish;
end
initial begin
    $monitor("time=%0t a=%b y=%b", $time, a, y);
    $dumpfile("icarus/not_gate.vcd");        
    $dumpvars(0, not_gate_tb);
    #2000 $finish();
end
endmodule