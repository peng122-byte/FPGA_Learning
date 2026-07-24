module half_add(
    input wire a,b,
    output wire sum,carry
);

assign sum = a^b;
assign carry = a&b;

endmodule

module add(
    input wire a,b,carry_in,
    output wire sum,carry_out
);
wire sum1,carry_out1,carry_out2;
half_add add1(
    .a(a),
    .b(b),
    .sum(sum1),
    .carry(carry_out1)
);
half_add add2(
    .a     	(sum1),
    .b     	(carry_in),
    .sum   	(sum),
    .carry 	(carry_out2)
);
assign carry_out = carry_out1 | carry_out1;

endmodule








