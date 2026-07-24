module simple_alu (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [1:0] op,
    output wire [3:0] y,
    output wire       zero
);

assign y = (op == 2'b00) ? (a + b) :
           (op == 2'b01) ? (a - b) :
           (op == 2'b10) ? (a & b) :
                           (a | b);

assign zero = (y == 4'b0000);

endmodule