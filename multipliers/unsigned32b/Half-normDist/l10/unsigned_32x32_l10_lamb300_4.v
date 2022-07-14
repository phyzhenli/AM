// terms: 5
// fval:  7835603.4951

module unsigned_32x32_l10_lamb300_4 (
	input [31:0] x,
	input [31:0] y,
	output [63:0] z
);

wire [31:0] part1 =  y & {32{x[0]}};
wire [31:0] part2 =  y & {32{x[1]}};
wire [31:0] part3 =  y & {32{x[2]}};
wire [31:0] part4 =  y & {32{x[3]}};
wire [31:0] part5 =  y & {32{x[4]}};
wire [31:0] part6 =  y & {32{x[5]}};
wire [31:0] part7 =  y & {32{x[6]}};
wire [31:0] part8 =  y & {32{x[7]}};
wire [31:0] part9 =  y & {32{x[8]}};
wire [31:0] part10 =  y & {32{x[9]}};
wire [31:0] part11 =  y & {32{x[10]}};
wire [31:0] part12 =  y & {32{x[11]}};
wire [31:0] part13 =  y & {32{x[12]}};
wire [31:0] part14 =  y & {32{x[13]}};
wire [31:0] part15 =  y & {32{x[14]}};
wire [31:0] part16 =  y & {32{x[15]}};
wire [31:0] part17 =  y & {32{x[16]}};
wire [31:0] part18 =  y & {32{x[17]}};
wire [31:0] part19 =  y & {32{x[18]}};
wire [31:0] part20 =  y & {32{x[19]}};
wire [31:0] part21 =  y & {32{x[20]}};
wire [31:0] part22 =  y & {32{x[21]}};
wire [31:0] part23 =  y & {32{x[22]}};
wire [31:0] part24 =  y & {32{x[23]}};
wire [31:0] part25 =  y & {32{x[24]}};
wire [31:0] part26 =  y & {32{x[25]}};
wire [31:0] part27 =  y & {32{x[26]}};
wire [31:0] part28 =  y & {32{x[27]}};
wire [31:0] part29 =  y & {32{x[28]}};
wire [31:0] part30 =  y & {32{x[29]}};
wire [31:0] part31 =  y & {32{x[30]}};
wire [31:0] part32 =  y & {32{x[31]}};

wire [37:0] new_part1;
assign new_part1[0] = 0;
assign new_part1[1] = 0;
assign new_part1[2] = 0;
assign new_part1[3] = 0;
assign new_part1[4] = 0;
assign new_part1[5] = 0;
assign new_part1[6] = 0;
assign new_part1[7] = 0;
assign new_part1[8] = 0;
assign new_part1[9] = 0;
assign new_part1[10] = 0;
assign new_part1[11] = 0;
assign new_part1[12] = part1[12] & part2[11];
assign new_part1[13] = 0;
assign new_part1[14] = 0;
assign new_part1[15] = 0;
assign new_part1[16] = 0;
assign new_part1[17] = 0;
assign new_part1[18] = 0;
assign new_part1[19] = 0;
assign new_part1[20] = 0;
assign new_part1[21] = 0;
assign new_part1[22] = 0;
assign new_part1[23] = 0;
assign new_part1[24] = 0;
assign new_part1[25] = 0;
assign new_part1[26] = part5[22] | part6[21];
assign new_part1[27] = 0;
assign new_part1[28] = 0;
assign new_part1[29] = part7[23] & part8[22];
assign new_part1[30] = 0;
assign new_part1[31] = part9[22] & part10[21];
assign new_part1[32] = 0;
assign new_part1[33] = 0;
assign new_part1[34] = 0;
assign new_part1[35] = 0;
assign new_part1[36] = 0;
assign new_part1[37] = part7[30] | part8[29];

wire [53:0] tmp_z = y*x[31:10];

assign z = {tmp_z, 10'd 0} + new_part1;

endmodule
