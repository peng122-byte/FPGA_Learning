module mux2 #(
    parameter WIDTH = 4
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             select,
    output wire [WIDTH-1:0] y
);

assign y = select ? a : b;

endmodule