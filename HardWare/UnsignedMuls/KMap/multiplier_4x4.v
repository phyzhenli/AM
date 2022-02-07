module multiplier_4x4(
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [7:0] out 
);

wire [2:0] part1;
wire [2:0] part2;
// wire [4:0] part2_shift;
wire [2:0] part3;
// wire [4:0] part3_shift;
wire [2:0] part4;
// wire [6:0] part4_shift;



multiplier_2x2 multiplier_2x2_1(
    .a(a[1:0]),
    .b(b[1:0]),
    .out(part1)
);

multiplier_2x2 multiplier_2x2_2(
    .a(a[3:2]),
    .b(b[1:0]),
    .out(part2[2:0])
);

multiplier_2x2 multiplier_2x2_3(
    .a(a[1:0]),
    .b(b[3:2]),
    .out(part3[2:0])
);

multiplier_2x2 multiplier_2x2_4(
    .a(a[3:2]),
    .b(b[3:2]),
    .out(part4[2:0])
);

// assign part2_shift = part2 << 2;
// assign part3_shift = part3 << 2;
// assign part4_shift = part4 << 4;
assign out = part1 + (part2 << 2) + (part3 << 2) + (part4 << 4);
// assign out = part1 + part2_shift + part3_shift + part4_shift;

endmodule