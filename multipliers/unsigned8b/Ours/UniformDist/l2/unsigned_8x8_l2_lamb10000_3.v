// terms: 2
// fval:  33571.25

module unsigned_8x8_l2_lamb10000_3 (
	input [7:0] x,
	input [7:0] y,
	output [15:0] z
);

wire [13:0] tmp_z = y*x[7:2];

wire [7:0] part1 =  y & {8{x[0]}};
wire [7:0] part2 =  y & {8{x[1]}};

wire [8:0] new_part1;
assign new_part1[0] = 0;
assign new_part1[1] = 0;
assign new_part1[2] = 0;
assign new_part1[3] = 0;
assign new_part1[4] = 0;
assign new_part1[5] = 0;
assign new_part1[6] = 0;
assign new_part1[7] = part1[6] | part2[5];
assign new_part1[8] = part2[7];

assign z = {tmp_z, 2'd 0} + new_part1;
endmodule
