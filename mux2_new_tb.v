`timescale 1ns/1ps
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
module mux4_tb;
reg [7:0] a1,a2,b1,b2;
reg s0,s1;
wire [7:0] y0,y1,y;
mux2 #(
    .WIDTH(8)
)mux4_s0(
    .a(a1),
    .b(b1),
    .select(s0),
    .y(y0)
);


mux2 #(
    .WIDTH(8)
)mux4_s1(
    .a(a2),
    .b(b2),
    .select(s0),
    .y(y1)
);

mux2 #(
    .WIDTH(8)
)mux4_y(
    .a(y0),
    .b(y1),
    .select(s1),
    .y(y)
);

initial begin
    $monitor("y=%8b",y);
    a1 = 8'b00000000; b1 = 8'b00000001; a2 = 8'b00000010; b2 = 8'b00000011; 

    s0 = 1'b0; s1 = 1'b0; 
    #10;
    

    s0 = 1'b1; s1 = 1'b0; 
    #10;
    

    s0 = 1'b0; s1 = 1'b1; 
    #10;
    

    s0 = 1'b1; s1 = 1'b1; 
    #10;
    


    $finish;
end



endmodule







