module multiplier_8x8(
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [15:0] out
);

wire [7:0] part1;
wire [7:0] part2;
// wire [11:0] part2_shift;
wire [7:0] part3;
// wire [11:0] part3_shift;
wire [7:0] part4;
// wire [15:0] part4_shift;

multiplier_4x4 multiplier_4x4_1(
    .a(a[3:0]),
    .b(b[3:0]),
    .out(part1)
);

multiplier_4x4 multiplier_4x4_2(
    .a(a[7:4]),
    .b(b[3:0]),
    .out(part2[7:0])
);

multiplier_4x4 multiplier_4x4_3(
    .a(a[3:0]),
    .b(b[7:4]),
    .out(part3[7:0])
);

multiplier_4x4 multiplier_4x4_4(
    .a(a[7:4]),
    .b(b[7:4]),
    .out(part4[7:0])
);

// assign part2_shift = part2 << 4;
// assign part3_shift = part3 << 4;
// assign part4_shift = part4 << 8;
assign out = part1 + (part2 << 4) + (part3 << 4) + (part4 << 8);
// assign out = part1 + part2_shift + part3_shift + part4_shift;

endmodule