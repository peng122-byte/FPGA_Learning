module mux2 #(
    parameter WIDTH = 4
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire             select,
    output wire [WIDTH-1:0] y
);
assign y = (select)?b:a;  
endmodule

module mux4 #(
    parameter WIDTH = 8
) (
    input  wire [WIDTH-1:0] d0,
    input  wire [WIDTH-1:0] d1,
    input  wire [WIDTH-1:0] d2,
    input  wire [WIDTH-1:0] d3,
    input  wire [1:0]       select,
    output wire [WIDTH-1:0] y
);

wire [WIDTH-1:0] y_low;
wire [WIDTH-1:0] y_high;

// 第一层：select[0] 选择每组中的数据
mux2 #(
    .WIDTH(WIDTH)
) mux_low (
    .a(d0),
    .b(d1),
    .select(select[0]),
    .y(y_low)
);

mux2 #(
    .WIDTH(WIDTH)
) mux_high (
    .a(d2),
    .b(d3),
    .select(select[0]),
    .y(y_high)
);

// 第二层：select[1] 选择数据组
mux2 #(
    .WIDTH(WIDTH)
) mux_final (
    .a(y_low),
    .b(y_high),
    .select(select[1]),
    .y(y)
);

endmodule