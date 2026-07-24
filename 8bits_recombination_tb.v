`timescale 100ns/1ps
module _8bits_recombination(
    input wire [7:0] data_in,
    output wire [3:0] MSB,
    output wire [3:0] LSB,
    output wire [7:0] swapped
);
assign MSB = data_in[7:4];
assign LSB = data_in[3:0];
assign swapped = {LSB, MSB};
endmodule

module _8bits_recombination_tb;
    reg [7:0] data_in;
    wire [3:0] MSB;
    wire [3:0] LSB;
    wire [7:0] swapped;

    _8bits_recombination dut (
        .data_in(data_in),
        .MSB(MSB),
        .LSB(LSB),
        .swapped(swapped)
    );

initial begin
    data_in = 8'b00000001;
    #10;
    $display("Time = %d, data_in = %b, MSB = %b, LSB = %b, swapped = %b", $time, data_in, MSB, LSB, swapped);
    data_in = 8'b11110000;
    #10;
    #10;
    data_in = 8'b10010000;
    #10;

    $display("Time = %d, data_in = %b, MSB = %b, LSB = %b, swapped = %b", $time, data_in, MSB, LSB, swapped);
    $dumpfile("icarus/8bits_recombination.vcd");
    $dumpvars(0, _8bits_recombination_tb);
    $finish;
end
endmodule 



















