`timescale 1ns/1ps;
module digital10(
    input wire [3:0] digit,
    output reg [9:0] one_hot,
    output reg valid
);
always @(*) begin
    case (digit)
        4'd0: begin
            one_hot = 10'b0000000001;
            valid = 1'b1;
        end
        4'd1: begin
            one_hot = 10'b0000000010;
            valid = 1'b1;
        end
        4'd2: begin
            one_hot = 10'b0000000100;
            valid = 1'b1;
        end
        4'd3: begin
            one_hot = 10'b0000001000;
            valid = 1'b1;
        end
        4'd4: begin
            one_hot = 10'b0000010000;
            valid = 1'b1;
        end
        4'd5: begin
            one_hot = 10'b0000100000;
            valid = 1'b1;
        end
        4'd6: begin
            one_hot = 10'b0001000000;
            valid = 1'b1;
        end
        4'd7: begin
            one_hot = 10'b0010000000;
            valid = 1'b1;
        end
        4'd8: begin
            one_hot = 10'b0100000000;
            valid = 1'b1;
        end
        4'd9: begin
            one_hot = 10'b1000000000;
            valid = 1'b1;
        end
        default: begin
            one_hot = 10'b0000000000; // Invalid input, set to unknown state
            valid = 1'b0; // Indicate invalid input
        end
    endcase    
end
endmodule

module difital10_tb;
reg [3:0] digit;
wire [9:0] one_hot;
wire valid;
reg [9:0] expected_one_hot;
reg expected_valid;
integer errors;

task check;
    begin
        if (one_hot !== expected_one_hot || valid !== expected_valid) begin
            $display("Test failed for digit %d: Expected one_hot = %b, valid = %b; Got one_hot = %b, valid = %b", 
                      digit, expected_one_hot, expected_valid, one_hot, valid);
            errors = errors + 1;
        end else begin
            $display("Test passed for digit %d: one_hot = %b, valid = %b", 
                      digit, one_hot, valid);
        end
    end
endtask

initial begin
    errors = 0;
    for (digit = 0; digit < 10; digit = digit + 1) begin
        expected_one_hot = 10'b0000000001 << digit; // Shift left to get the correct one-hot encoding
        expected_valid = 1'b1;
        #10; // Wait for the outputs to settle
        check();
    end

    // Test invalid input
    digit = 4'd10; // Invalid input
    expected_one_hot = 10'b0000000000; // Invalid input, set to unknown state
    expected_valid = 1'b0; // Indicate invalid input
    #10; // Wait for the outputs to settle
    check();

    if (errors == 0) begin
        $display("All tests passed!");
    end else begin
        $display("%d tests failed.", errors);
    end

    $finish;

end
endmodule
