// terms: 40
// fval:  7835303.5043

module unsigned_32x32_l10_lamb30_1 (
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
assign new_part1[4] = part1[3] & part2[2];
assign new_part1[5] = 0;
assign new_part1[6] = 0;
assign new_part1[7] = part7[1] | part8[0];
assign new_part1[8] = part1[8] | part2[7];
assign new_part1[9] = part7[2] | part8[1];
assign new_part1[10] = part1[9] ^ part2[8];
assign new_part1[11] = part1[11] | part2[10];
assign new_part1[12] = part1[12] ^ part2[11];
assign new_part1[13] = part9[5] & part10[4];
assign new_part1[14] = part9[6] & part10[5];
assign new_part1[15] = part9[7] & part10[6];
assign new_part1[16] = part3[13] & part4[12];
assign new_part1[17] = 0;
assign new_part1[18] = part5[14] | part6[13];
assign new_part1[19] = part5[15] | part6[14];
assign new_part1[20] = 0;
assign new_part1[21] = part1[21] & part2[20];
assign new_part1[22] = part3[20] | part4[19];
assign new_part1[23] = part7[16] | part8[15];
assign new_part1[24] = part1[23] & part2[22];
assign new_part1[25] = part5[20] ^ part6[19];
assign new_part1[26] = part5[22] ^ part6[21];
assign new_part1[27] = part1[26] | part2[25];
assign new_part1[28] = 0;
assign new_part1[29] = part9[21] ^ part10[20];
assign new_part1[30] = part5[25] | part6[24];
assign new_part1[31] = part9[22] | part10[21];
assign new_part1[32] = part3[30] & part4[29];
assign new_part1[33] = 0;
assign new_part1[34] = 0;
assign new_part1[35] = 0;
assign new_part1[36] = 0;
assign new_part1[37] = part7[31] & part8[30];

wire [32:0] new_part2;
assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = 0;
assign new_part2[3] = 0;
assign new_part2[4] = 0;
assign new_part2[5] = 0;
assign new_part2[6] = 0;
assign new_part2[7] = 0;
assign new_part2[8] = 0;
assign new_part2[9] = part9[1] & part10[0];
assign new_part2[10] = part5[5] | part6[4];
assign new_part2[11] = part5[7] ^ part6[6];
assign new_part2[12] = part5[8] ^ part6[7];
assign new_part2[13] = 0;
assign new_part2[14] = 0;
assign new_part2[15] = 0;
assign new_part2[16] = 0;
assign new_part2[17] = 0;
assign new_part2[18] = 0;
assign new_part2[19] = part5[15] ^ part6[14];
assign new_part2[20] = 0;
assign new_part2[21] = part3[19] | part4[18];
assign new_part2[22] = part7[16] | part8[15];
assign new_part2[23] = 0;
assign new_part2[24] = part5[20] ^ part6[19];
assign new_part2[25] = 0;
assign new_part2[26] = part7[19] | part8[18];
assign new_part2[27] = part9[18] | part10[17];
assign new_part2[28] = 0;
assign new_part2[29] = 0;
assign new_part2[30] = 0;
assign new_part2[31] = 0;
assign new_part2[32] = part3[30] ^ part4[29];

wire [24:0] new_part3;
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
assign new_part3[12] = part9[3] & part10[2];
assign new_part3[13] = 0;
assign new_part3[14] = 0;
assign new_part3[15] = 0;
assign new_part3[16] = 0;
assign new_part3[17] = 0;
assign new_part3[18] = 0;
assign new_part3[19] = 0;
assign new_part3[20] = 0;
assign new_part3[21] = 0;
assign new_part3[22] = part9[13] | part10[12];
assign new_part3[23] = 0;
assign new_part3[24] = part7[17] | part8[16];

wire [12:0] new_part4;
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
assign new_part4[12] = part9[3] ^ part10[2];

wire [53:0] tmp_z = y*x[31:10];

assign z = {tmp_z, 10'd 0} + new_part1 + new_part2 + new_part3 + new_part4;

endmodule
