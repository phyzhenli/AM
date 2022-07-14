// terms: 22
// fval:  7835423.496

module unsigned_32x32_l10_lamb60_4 (
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

wire [36:0] new_part1;
assign new_part1[0] = 0;
assign new_part1[1] = 0;
assign new_part1[2] = 0;
assign new_part1[3] = part3[1] ^ part4[0];
assign new_part1[4] = 0;
assign new_part1[5] = 0;
assign new_part1[6] = part5[1] & part6[0];
assign new_part1[7] = part3[4] ^ part4[3];
assign new_part1[8] = 0;
assign new_part1[9] = 0;
assign new_part1[10] = part9[1] | part10[0];
assign new_part1[11] = 0;
assign new_part1[12] = part9[4] & part10[3];
assign new_part1[13] = part1[12] | part2[11];
assign new_part1[14] = 0;
assign new_part1[15] = part7[9] ^ part8[8];
assign new_part1[16] = 0;
assign new_part1[17] = 0;
assign new_part1[18] = 0;
assign new_part1[19] = part1[18] & part2[17];
assign new_part1[20] = part9[12] ^ part10[11];
assign new_part1[21] = part3[18] | part4[17];
assign new_part1[22] = part1[21] ^ part2[20];
assign new_part1[23] = part1[23] | part2[22];
assign new_part1[24] = 0;
assign new_part1[25] = part9[16] & part10[15];
assign new_part1[26] = 0;
assign new_part1[27] = 0;
assign new_part1[28] = part3[26] & part4[25];
assign new_part1[29] = 0;
assign new_part1[30] = part5[26] ^ part6[25];
assign new_part1[31] = part5[27] ^ part6[26];
assign new_part1[32] = part7[26] ^ part8[25];
assign new_part1[33] = 0;
assign new_part1[34] = 0;
assign new_part1[35] = part7[28] | part8[27];
assign new_part1[36] = part7[30] & part8[29];

wire [31:0] new_part2;
assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = 0;
assign new_part2[3] = 0;
assign new_part2[4] = 0;
assign new_part2[5] = 0;
assign new_part2[6] = 0;
assign new_part2[7] = 0;
assign new_part2[8] = 0;
assign new_part2[9] = 0;
assign new_part2[10] = 0;
assign new_part2[11] = 0;
assign new_part2[12] = 0;
assign new_part2[13] = part9[5] & part10[4];
assign new_part2[14] = 0;
assign new_part2[15] = 0;
assign new_part2[16] = 0;
assign new_part2[17] = 0;
assign new_part2[18] = 0;
assign new_part2[19] = 0;
assign new_part2[20] = 0;
assign new_part2[21] = 0;
assign new_part2[22] = 0;
assign new_part2[23] = 0;
assign new_part2[24] = 0;
assign new_part2[25] = 0;
assign new_part2[26] = 0;
assign new_part2[27] = 0;
assign new_part2[28] = part3[26] | part4[25];
assign new_part2[29] = 0;
assign new_part2[30] = 0;
assign new_part2[31] = part9[23] & part10[22];

wire [53:0] tmp_z = y*x[31:10];

assign z = {tmp_z, 10'd 0} + new_part1 + new_part2;

endmodule
