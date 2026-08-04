`timescale 1ns/1ps

module running_led_tb;

reg        clk;
reg        reset;
reg        enable;
reg        direction;
wire [7:0] led;

integer errors;

running_led dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .direction(direction),
    .led(led)
);

initial clk = 1'b0;
always #5 clk = ~clk;

task step_and_check;
    input [7:0] expected;
    begin
        @(posedge clk);
        #1;
        if (led !== expected) begin
            $display("ERROR: expected led=%b, got led=%b", expected, led);
            errors = errors + 1;
        end
    end
endtask

initial begin
    errors = 0;
    reset = 1'b1;
    enable = 1'b0;
    direction = 1'b1;
    step_and_check(8'b0000_0001);

    @(negedge clk);
    reset = 1'b0;
    enable = 1'b1;
    step_and_check(8'b0000_0010);
    step_and_check(8'b0000_0100);

    @(negedge clk);
    enable = 1'b0;
    step_and_check(8'b0000_0100);

    @(negedge clk);
    enable = 1'b1;
    direction = 1'b0;
    step_and_check(8'b0000_0010);
    step_and_check(8'b0000_0001);
    step_and_check(8'b1000_0000);

    if (errors == 0)
        $display("PASS: running_led tests passed");
    else
        $display("FAIL: %0d running_led error(s)", errors);

    $finish;
end

endmodule