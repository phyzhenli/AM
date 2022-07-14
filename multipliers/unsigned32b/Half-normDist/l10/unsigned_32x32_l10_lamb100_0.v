// terms: 5
// fval:  7834603.4964

module unsigned_32x32_l10_lamb100_0 (
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

wire [31:0] new_part1;
assign new_part1[0] = 0;
assign new_part1[1] = 0;
assign new_part1[2] = 0;
assign new_part1[3] = 0;
assign new_part1[4] = 0;
assign new_part1[5] = 0;
assign new_part1[6] = 0;
assign new_part1[7] = 0;
assign new_part1[8] = part3[6] | part4[5];
assign new_part1[9] = 0;
assign new_part1[10] = 0;
assign new_part1[11] = 0;
assign new_part1[12] = 0;
assign new_part1[13] = 0;
assign new_part1[14] = part5[9] ^ part6[8];
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
assign new_part1[26] = 0;
assign new_part1[27] = part3[25] & part4[24];
assign new_part1[28] = 0;
assign new_part1[29] = part5[24] & part6[23];
assign new_part1[30] = 0;
assign new_part1[31] = part7[24] & part8[23];

wire [53:0] tmp_z = y*x[31:10];

assign z = {tmp_z, 10'd 0} + new_part1;

endmodule
