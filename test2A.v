`timescale 1ns/1ps
module mux4to1_8bits(
    input wire [7:0] d0,
    input wire [7:0] d1,
    input wire [7:0] d2,
    input wire [7:0] d3,
    input wire [2:0] select,
    output reg [7:0] out,
    output reg valid
);

always @(*) begin
    case (select)
        3'b000: out = d0;
        3'b001: out = d1;
        3'b010: out = d2;
        3'b011: out = d3;
        3'b100: out = 8'b0;
        3'b101: out = 8'b0;
        3'b110: out = 8'b0;
        3'b111: out = 8'b0;
        default: out = 8'b0; // Default case for invalid select values
    endcase
    if(select <= 3'b011) valid = 1'b1; // Set valid signal to high when output is updated
    else valid = 1'b0; // Set valid signal to low for invalid select values
end

endmodule


module mux4to1_8bits_tb;
    reg  [7:0] d0, d1, d2, d3;
    reg  [2:0] select;
    wire [7:0] out;
    wire       valid;

    mux4to1_8bits dut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .select(select),
        .out(out),
        .valid(valid)
    );

    initial begin
        // Initialize inputs
        d0 = 8'b00000001;
        d1 = 8'b00000010;
        d2 = 8'b00000100;
        d3 = 8'b00001000;

        // Test each select value
        for (select = 3'b000; select <= 3'b011; select = select + 1) begin
            #10; // Wait for output to stabilize
            $display("Select: %b, Output: %b, Valid: %b", select, out, valid);
        end

        // Test invalid select values
        select = 3'b100; #10;
        $display("Select: %b, Output: %b, Valid: %b", select, out, valid);
        
        select = 3'b101; #10;
        $display("Select: %b, Output: %b, Valid: %b", select, out, valid);
        
        select = 3'b110; #10;
        $display("Select: %b, Output: %b, Valid: %b", select, out, valid);
        
        select = 3'b111; #10;
        $display("Select: %b, Output: %b, Valid: %b", select, out, valid);

        $finish; // End simulation
    end
endmodule

