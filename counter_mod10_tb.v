`timescale 1ns/1ps
module counter_mod10 (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output reg  [3:0] count,
    output reg        tick
);

always @(posedge clk) begin
    if (reset) begin
        count <= 4'd0;
        tick  <= 1'b0;
    end else begin
        tick <= 1'b0;
        if (enable) begin
            if (count == 4'd9) begin
                count <= 4'd0;
                tick  <= 1'b1;
            end else begin
                count <= count + 1'b1;
            end
        end
    end
end

endmodule

module counter_mod10_tb;

reg        clk;
reg        reset;
reg        enable;
wire [3:0] count;
wire       tick;

integer cycle;
integer errors;
reg [3:0] expected_count;

counter_mod10 dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .count(count),
    .tick(tick)
);

initial clk = 1'b0;
always #5 clk = ~clk;

initial begin
    errors = 0;
    reset = 1'b1;
    enable = 1'b0;
    expected_count = 4'd0;

    @(posedge clk);
    #1;
    if (count !== 4'd0 || tick !== 1'b0)
        errors = errors + 1;

    @(negedge clk);
    reset = 1'b0;
    enable = 1'b1;

    for (cycle = 1; cycle <= 20; cycle = cycle + 1) begin
        @(posedge clk);
        #1;
        expected_count = cycle % 10;

        if (count !== expected_count) begin
            $display("ERROR: cycle=%0d expected count=%0d got=%0d", cycle, expected_count, count);
            errors = errors + 1;
        end

        if (tick !== ((cycle % 10) == 0)) begin
            $display("ERROR: cycle=%0d incorrect tick=%b", cycle, tick);
            errors = errors + 1;
        end
    end

    @(negedge clk);
    enable = 1'b0;
    repeat (2) begin
        @(posedge clk);
        #1;
        if (count !== 4'd0 || tick !== 1'b0)
            errors = errors + 1;
    end

    if (errors == 0)
        $display("PASS: counter_mod10 tests passed");
    else
        $display("FAIL: %0d counter_mod10 error(s)", errors);

    $finish;
end

endmodule