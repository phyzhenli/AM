// terms: 24
// fval:  22934.25

module unsigned_8x8_l6_lamb800_9 (
	input [7:0] x,
	input [7:0] y,
	output [15:0] z
);

wire [9:0] tmp_z = y*x[7:6];

wire [7:0] part1 =  y & {8{x[0]}};
wire [7:0] part2 =  y & {8{x[1]}};
wire [7:0] part3 =  y & {8{x[2]}};
wire [7:0] part4 =  y & {8{x[3]}};
wire [7:0] part5 =  y & {8{x[4]}};
wire [7:0] part6 =  y & {8{x[5]}};

wire [12:0] new_part1;
assign new_part1[0] = 0;
assign new_part1[1] = 0;
assign new_part1[2] = 0;
assign new_part1[3] = 0;
assign new_part1[4] = 0;
assign new_part1[5] = 0;
assign new_part1[6] = 0;
assign new_part1[7] = part1[6] | part2[5];
assign new_part1[8] = part1[7] & part2[6];
assign new_part1[9] = part3[6] & part4[5];
assign new_part1[10] = part4[7];
assign new_part1[11] = part5[6] & part6[5];
assign new_part1[12] = part6[7];

wire [11:0] new_part2;
assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = 0;
assign new_part2[3] = 0;
assign new_part2[4] = 0;
assign new_part2[5] = 0;
assign new_part2[6] = 0;
assign new_part2[7] = part1[7] ^ part2[6];
assign new_part2[8] = part2[7];
assign new_part2[9] = part3[7] & part4[6];
assign new_part2[10] = part5[6] ^ part6[5];
assign new_part2[11] = part5[7] & part6[6];

wire [11:0] new_part3;
assign new_part3[0] = 0;
assign new_part3[1] = 0;
assign new_part3[2] = 0;
assign new_part3[3] = 0;
assign new_part3[4] = 0;
assign new_part3[5] = 0;
assign new_part3[6] = 0;
assign new_part3[7] = part3[4] | part4[3];
assign new_part3[8] = part3[5] & part4[4];
assign new_part3[9] = part3[7] | part4[6];
assign new_part3[10] = 0;
assign new_part3[11] = part5[7] | part6[6];

wire [9:0] new_part4;
assign new_part4[0] = 0;
assign new_part4[1] = 0;
assign new_part4[2] = 0;
assign new_part4[3] = 0;
assign new_part4[4] = 0;
assign new_part4[5] = 0;
assign new_part4[6] = 0;
assign new_part4[7] = part3[5] ^ part4[4];
assign new_part4[8] = part3[6] ^ part4[5];
assign new_part4[9] = part5[5] & part6[4];

wire [9:0] new_part5;
assign new_part5[0] = 0;
assign new_part5[1] = 0;
assign new_part5[2] = 0;
assign new_part5[3] = 0;
assign new_part5[4] = 0;
assign new_part5[5] = 0;
assign new_part5[6] = 0;
assign new_part5[7] = part5[2] | part6[1];
assign new_part5[8] = part5[4] & part6[3];
assign new_part5[9] = part5[5] | part6[4];

wire [8:0] new_part6;
assign new_part6[0] = 0;
assign new_part6[1] = 0;
assign new_part6[2] = 0;
assign new_part6[3] = 0;
assign new_part6[4] = 0;
assign new_part6[5] = 0;
assign new_part6[6] = 0;
assign new_part6[7] = part5[3] & part6[2];
assign new_part6[8] = part5[4] | part6[3];

wire [7:0] new_part7;
assign new_part7[0] = 0;
assign new_part7[1] = 0;
assign new_part7[2] = 0;
assign new_part7[3] = 0;
assign new_part7[4] = 0;
assign new_part7[5] = 0;
assign new_part7[6] = 0;
assign new_part7[7] = part5[3] | part6[2];

assign z = {tmp_z, 6'd 0} + new_part1 + new_part2 + new_part3 + new_part4 + new_part5 + new_part6 + new_part7;
endmodule
