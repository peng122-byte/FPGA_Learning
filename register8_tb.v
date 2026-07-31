`timescale 1ns/1ps

module register8_tb;

reg        clk;
reg        reset;
reg        load;
reg        enable;
reg  [7:0] load_data;
reg  [7:0] d;
wire [7:0] q;

integer errors;

register8 dut (
    .clk(clk),
    .reset(reset),
    .load(load),
    .enable(enable),
    .load_data(load_data),
    .d(d),
    .q(q)
);

initial clk = 1'b0;
always #5 clk = ~clk;

task check_q;
    input [7:0] expected;
    input [8*48-1:0] test_name;
    begin
        #1;
        if (q !== expected) begin
            $display("ERROR: %0s, expected q=%h, got q=%h", test_name, expected, q);
            errors = errors + 1;
        end
    end
endtask

initial begin
    errors = 0;
    reset = 1'b1;
    load = 1'b1;
    enable = 1'b1;
    load_data = 8'h3C;
    d = 8'hA5;

    @(posedge clk);
    check_q(8'h00, "reset priority over load and enable");

    // load is synchronous: q must not change before the next rising edge.
    @(negedge clk);
    reset = 1'b0;
    load = 1'b1;
    enable = 1'b1;
    load_data = 8'h3C;
    d = 8'hA5;
    #2;
    if (q !== 8'h00) begin
        $display("ERROR: synchronous load changed q before a clock edge");
        errors = errors + 1;
    end
    @(posedge clk);
    check_q(8'h3C, "load priority over enable");

    // With load low, enable loads d normally.
    @(negedge clk);
    load = 1'b0;
    enable = 1'b1;
    d = 8'hA5;
    @(posedge clk);
    check_q(8'hA5, "enable loads d");

    // With load and enable both low, q holds its previous value.
    @(negedge clk);
    load = 1'b0;
    enable = 1'b0;
    load_data = 8'hC3;
    d = 8'h5A;
    @(posedge clk);
    check_q(8'hA5, "hold when load and enable are low");

    // Check reset priority again after a nonzero value has been stored.
    @(negedge clk);
    reset = 1'b1;
    load = 1'b1;
    enable = 1'b1;
    load_data = 8'hFF;
    d = 8'hFF;
    @(posedge clk);
    check_q(8'h00, "reset clears stored value");

    if (errors == 0)
        $display("PASS: register8 tests passed");
    else
        $display("FAIL: %0d register8 error(s)", errors);

    $finish;
end

endmodule
