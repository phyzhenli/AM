// terms: 40
// fval:  7835303.5015

module unsigned_32x32_l10_lamb30_0 (
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
assign new_part1[3] = 0;
assign new_part1[4] = part1[4] | part2[3];
assign new_part1[5] = part1[4] | part2[3];
assign new_part1[6] = part5[2] & part6[1];
assign new_part1[7] = 0;
assign new_part1[8] = part9[0];
assign new_part1[9] = part1[9] | part2[8];
assign new_part1[10] = part3[8] & part4[7];
assign new_part1[11] = part1[11] & part2[10];
assign new_part1[12] = part9[3] | part10[2];
assign new_part1[13] = part7[6] & part8[5];
assign new_part1[14] = part9[5] | part10[4];
assign new_part1[15] = part3[12] & part4[11];
assign new_part1[16] = 0;
assign new_part1[17] = part1[16] | part2[15];
assign new_part1[18] = 0;
assign new_part1[19] = part7[13] ^ part8[12];
assign new_part1[20] = part9[12] | part10[11];
assign new_part1[21] = part5[17] ^ part6[16];
assign new_part1[22] = part3[19] ^ part4[18];
assign new_part1[23] = part1[23] & part2[22];
assign new_part1[24] = 0;
assign new_part1[25] = 0;
assign new_part1[26] = part1[25] & part2[24];
assign new_part1[27] = 0;
assign new_part1[28] = part7[21] | part8[20];
assign new_part1[29] = part3[26] ^ part4[25];
assign new_part1[30] = part1[29] | part2[28];
assign new_part1[31] = part1[30] ^ part2[29];
assign new_part1[32] = part3[30] ^ part4[29];
assign new_part1[33] = part3[31] & part4[30];
assign new_part1[34] = part7[27] | part8[26];
assign new_part1[35] = 0;
assign new_part1[36] = part5[31] ^ part6[30];

wire [36:0] new_part2;
assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = 0;
assign new_part2[3] = 0;
assign new_part2[4] = part3[1] & part4[0];
assign new_part2[5] = part3[2] | part4[1];
assign new_part2[6] = 0;
assign new_part2[7] = 0;
assign new_part2[8] = 0;
assign new_part2[9] = 0;
assign new_part2[10] = 0;
assign new_part2[11] = 0;
assign new_part2[12] = 0;
assign new_part2[13] = 0;
assign new_part2[14] = 0;
assign new_part2[15] = 0;
assign new_part2[16] = 0;
assign new_part2[17] = part7[11] & part8[10];
assign new_part2[18] = 0;
assign new_part2[19] = 0;
assign new_part2[20] = 0;
assign new_part2[21] = 0;
assign new_part2[22] = part7[15] | part8[14];
assign new_part2[23] = 0;
assign new_part2[24] = 0;
assign new_part2[25] = 0;
assign new_part2[26] = part5[22] ^ part6[21];
assign new_part2[27] = 0;
assign new_part2[28] = part7[22] | part8[21];
assign new_part2[29] = 0;
assign new_part2[30] = part5[26] ^ part6[25];
assign new_part2[31] = part3[29] & part4[28];
assign new_part2[32] = part5[27] & part6[26];
assign new_part2[33] = 0;
assign new_part2[34] = part9[25] & part10[24];
assign new_part2[35] = 0;
assign new_part2[36] = part7[30] & part8[29];

wire [32:0] new_part3;
assign new_part3[0] = 0;
assign new_part3[1] = 0;
assign new_part3[2] = 0;
assign new_part3[3] = 0;
assign new_part3[4] = 0;
assign new_part3[5] = 0;
assign new_part3[6] = 0;
assign new_part3[7] = 0;
assign new_part3[8] = 0;
assign new_part3[9] = 0;
assign new_part3[10] = 0;
assign new_part3[11] = 0;
assign new_part3[12] = 0;
assign new_part3[13] = 0;
assign new_part3[14] = 0;
assign new_part3[15] = 0;
assign new_part3[16] = 0;
assign new_part3[17] = 0;
assign new_part3[18] = 0;
assign new_part3[19] = 0;
assign new_part3[20] = 0;
assign new_part3[21] = 0;
assign new_part3[22] = 0;
assign new_part3[23] = 0;
assign new_part3[24] = 0;
assign new_part3[25] = 0;
assign new_part3[26] = 0;
assign new_part3[27] = 0;
assign new_part3[28] = 0;
assign new_part3[29] = 0;
assign new_part3[30] = 0;
assign new_part3[31] = 0;
assign new_part3[32] = part5[27] ^ part6[26];

wire [32:0] new_part4;
assign new_part4[0] = 0;
assign new_part4[1] = 0;
assign new_part4[2] = 0;
assign new_part4[3] = 0;
assign new_part4[4] = 0;
assign new_part4[5] = 0;
assign new_part4[6] = 0;
assign new_part4[7] = 0;
assign new_part4[8] = 0;
assign new_part4[9] = 0;
assign new_part4[10] = 0;
assign new_part4[11] = 0;
assign new_part4[12] = 0;
assign new_part4[13] = 0;
assign new_part4[14] = 0;
assign new_part4[15] = 0;
assign new_part4[16] = 0;
assign new_part4[17] = 0;
assign new_part4[18] = 0;
assign new_part4[19] = 0;
assign new_part4[20] = 0;
assign new_part4[21] = 0;
assign new_part4[22] = 0;
assign new_part4[23] = 0;
assign new_part4[24] = 0;
assign new_part4[25] = 0;
assign new_part4[26] = 0;
assign new_part4[27] = 0;
assign new_part4[28] = 0;
assign new_part4[29] = 0;
assign new_part4[30] = 0;
assign new_part4[31] = 0;
assign new_part4[32] = part7[25] | part8[24];

wire [32:0] new_part5;
assign new_part5[0] = 0;
assign new_part5[1] = 0;
assign new_part5[2] = 0;
assign new_part5[3] = 0;
assign new_part5[4] = 0;
assign new_part5[5] = 0;
assign new_part5[6] = 0;
assign new_part5[7] = 0;
assign new_part5[8] = 0;
assign new_part5[9] = 0;
assign new_part5[10] = 0;
assign new_part5[11] = 0;
assign new_part5[12] = 0;
assign new_part5[13] = 0;
assign new_part5[14] = 0;
assign new_part5[15] = 0;
assign new_part5[16] = 0;
assign new_part5[17] = 0;
assign new_part5[18] = 0;
assign new_part5[19] = 0;
assign new_part5[20] = 0;
assign new_part5[21] = 0;
assign new_part5[22] = 0;
assign new_part5[23] = 0;
assign new_part5[24] = 0;
assign new_part5[25] = 0;
assign new_part5[26] = 0;
assign new_part5[27] = 0;
assign new_part5[28] = 0;
assign new_part5[29] = 0;
assign new_part5[30] = 0;
assign new_part5[31] = 0;
assign new_part5[32] = part7[26] ^ part8[25];

wire [53:0] tmp_z = y*x[31:10];

assign z = {tmp_z, 10'd 0} + new_part1 + new_part2 + new_part3 + new_part4 + new_part5;

endmodule