`timescale 1ns/1ps

module onebit_D_tb;

reg  clk;
reg  reset;
reg  reset_n;
reg  enable;
reg  d;
wire q;

integer errors;

onebit_D dut (
    .clk(clk),
    .reset(reset),
    .reset_n(reset_n),
    .enable(enable),
    .d(d),
    .q(q)
);

initial clk = 1'b0;
always #5 clk = ~clk;

task check_q;
    input expected;
    input [8*48-1:0] test_name;
    begin
        #1;
        if (q !== expected) begin
            $display("ERROR: %0s, expected q=%b, got q=%b", test_name, expected, q);
            errors = errors + 1;
        end
    end
endtask

initial begin
    errors  = 0;
    reset   = 1'b0;
    reset_n = 1'b1;
    enable  = 1'b0;
    d       = 1'b0;

    // reset_n is asynchronous and active low.
    #2;
    reset_n = 1'b0;
    check_q(1'b0, "asynchronous reset_n assertion");
    reset_n = 1'b1;

    // Capture 1 when enable is high.
    @(negedge clk);
    enable = 1'b1;
    d = 1'b1;
    @(posedge clk);
    check_q(1'b1, "capture 1 with enable high");

    // Hold the previous value when enable is low.
    @(negedge clk);
    enable = 1'b0;
    d = 1'b0;
    @(posedge clk);
    check_q(1'b1, "hold value with enable low");

    // Capture 0 to check both possible data values.
    @(negedge clk);
    enable = 1'b1;
    d = 1'b0;
    @(posedge clk);
    check_q(1'b0, "capture 0 with enable high");

    // Store 1 again before checking the synchronous reset.
    @(negedge clk);
    d = 1'b1;
    @(posedge clk);
    check_q(1'b1, "store 1 before synchronous reset");

    // reset is synchronous, so q must not change before a clock edge.
    @(negedge clk);
    reset = 1'b1;
    #2;
    if (q !== 1'b1) begin
        $display("ERROR: synchronous reset changed q before a clock edge");
        errors = errors + 1;
    end
    @(posedge clk);
    check_q(1'b0, "synchronous reset at rising edge");

    // reset has priority over enable and d.
    @(negedge clk);
    enable = 1'b1;
    d = 1'b1;
    @(posedge clk);
    check_q(1'b0, "reset priority over enable");

    // Release the synchronous reset and capture data again.
    @(negedge clk);
    reset = 1'b0;
    @(posedge clk);
    check_q(1'b1, "capture after synchronous reset release");

    // Assert reset_n between clock edges; q must clear immediately.
    #2;
    reset_n = 1'b0;
    check_q(1'b0, "asynchronous reset between clock edges");

    // Releasing reset_n alone must not load d until the next clock edge.
    reset_n = 1'b1;
    check_q(1'b0, "hold after asynchronous reset release");
    @(posedge clk);
    check_q(1'b1, "capture after asynchronous reset release");

    if (errors == 0)
        $display("PASS: all onebit_D tests passed");
    else
        $display("FAIL: %0d onebit_D error(s)", errors);


    $finish;
end

endmodule
