`timescale 1ns/1ps

module mux4_tb;

reg  [7:0] d0, d1, d2, d3;
reg  [1:0] select;
wire [7:0] y;

mux4 #(
    .WIDTH(8)
) dut (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .select(select),
    .y(y)
);

initial begin
    $monitor(
        "time=%0t select=%2b y=%8b",
        $time, select, y
    );

    d0 = 8'd0;
    d1 = 8'd1;
    d2 = 8'd2;
    d3 = 8'd3;

    select = 2'b00; #10;
    select = 2'b01; #10;
    select = 2'b10; #10;
    select = 2'b11; #10;

    $finish;
end

endmodule