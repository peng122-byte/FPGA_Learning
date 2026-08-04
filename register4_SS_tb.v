`timescale 1ns/1ps

module register4_SS_tb;

reg  clk;
reg  reset;
reg  serial_in;
wire serial_out;

integer errors;
integer cycle;

register4_SS dut (
    .clk(clk),
    .reset(reset),
    .serial_in(serial_in),
    .serial_out(serial_out)
);

initial clk = 1'b0;
always #5 clk = ~clk;

task shift_and_check;
    input input_bit;
    input expected_out;
    begin
        @(negedge clk);
        serial_in = input_bit;
        @(posedge clk);
        #1;
        cycle = cycle + 1;

        if (serial_out !== expected_out) begin
            $display(
                "ERROR: cycle %0d, serial_in=%b, expected serial_out=%b, got %b",
                cycle, input_bit, expected_out, serial_out
            );
            errors = errors + 1;
        end
    end
endtask

initial begin
    errors    = 0;
    cycle     = 0;
    reset     = 1'b1;
    serial_in = 1'b0;

    // Apply synchronous reset at a rising edge.
    @(posedge clk);
    #1;
    if (serial_out !== 1'b0) begin
        $display("ERROR: reset did not clear serial_out");
        errors = errors + 1;
    end

    @(negedge clk);
    reset = 1'b0;

    // Insert one '1' bit, then follow it with zeros.
    // It must appear at serial_out immediately after the fourth rising edge.
    shift_and_check(1'b1, 1'b0); // clock 1: bit enters stage 0
    shift_and_check(1'b0, 1'b0); // clock 2: bit reaches stage 1
    shift_and_check(1'b0, 1'b0); // clock 3: bit reaches stage 2
    shift_and_check(1'b0, 1'b1); // clock 4: bit reaches stage 3/output
    shift_and_check(1'b0, 1'b0); // clock 5: bit has shifted out

    if (errors == 0)
        $display("PASS: input bit appeared at serial_out after 4 clocks");
    else
        $display("FAIL: %0d register4_SS error(s)", errors);

    $finish;
end

endmodule
