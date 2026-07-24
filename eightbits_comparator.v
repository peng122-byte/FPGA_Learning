module eightbits_comparator(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire sign,
    output reg equal,
    output reg greater,
    output reg less
);
reg [7:0] a_signed, b_signed;
always @(*) begin
    if (sign) begin
        a_signed = ~a;
        b_signed = ~b;
    end
    else begin
        a_signed = a;
        b_signed = b;
    end
end
always @(*) begin
    if (a_signed == b_signed) begin
        equal = 1'b1;
        greater = 1'b0;
        less = 1'b0;
    end
    else if (a_signed > b_signed) begin
        equal = 1'b0;
        greater = 1'b1;
        less = 1'b0;
    end
    else begin
        equal = 1'b0;
        greater = 1'b0;
        less = 1'b1;
    end
end
endmodule