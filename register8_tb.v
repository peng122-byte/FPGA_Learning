`timescale 1ns/1ps

module register8_tb;

reg        clk;
reg        reset;
reg        enable;
reg  [7:0] d;
wire [7:0] q;

integer errors;

register8 dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .d(d),
    .q(q)
);

initial clk = 1'b0;
always #5 clk = ~clk;

task check_q;
    input [7:0] expected;
    begin
        #1;
        if (q !== expected) begin
            $display("ERROR: expected q=%h, got q=%h", expected, q);
            errors = errors + 1;
        end
    end
endtask

initial begin
    errors = 0;
    reset = 1'b1;
    enable = 1'b0;
    d = 8'h00;

    @(posedge clk);
    check_q(8'h00);

    @(negedge clk);
    reset = 1'b0;
    enable = 1'b1;
    d = 8'hA5;
    @(posedge clk);
    check_q(8'hA5);

    @(negedge clk);
    enable = 1'b0;
    d = 8'h3C;
    @(posedge clk);
    check_q(8'hA5);

    @(negedge clk);
    reset = 1'b1;
    enable = 1'b1;
    @(posedge clk);
    check_q(8'h00);

    if (errors == 0)
        $display("PASS: register8 tests passed");
    else
        $display("FAIL: %0d register8 error(s)", errors);

    $finish;
end

endmodule