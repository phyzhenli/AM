module halfadder(
input x,
input y,
output sum,
output cout
);
//     xor u8(sum, x, y);
	assign sum = x ^ y;
//     and u9(cout, x, y);
	assign cout = x & y;
endmodule


module fulladder(
input x,
input y,
input ci,
output sum,
output cout
);

wire a, b, c, e, f, g;
//     xor u1(a, x, y);
	assign a = x ^ y;
//     xor u2(sum, a, ci);
	assign sum = a ^ ci;
//     and u3( c, x, y );
	assign c = x & y;
//     and u4( e, y , ci );
	assign e = y & ci;
//     and u5 ( f, x, ci);
	assign f = x & ci;
//     or u6 ( g ,c, e );
	assign g = c | e;
//     or u7 ( cout, g , f );
	assign cout = g | f;
endmodule


module SDLC (
    input  [7:0]  x,
    input  [7:0]  y,
    output [15:0] z
);


wire [7:0] part1 =  y & {8{x[0]}};
wire [7:0] part2 = (y & {8{x[1]}});
wire [7:0] part3 = (y & {8{x[2]}});
wire [7:0] part4 = (y & {8{x[3]}});

wire [7:0] part5 = (y & {8{x[4]}});
wire [7:0] part6 = (y & {8{x[5]}});
wire [7:0] part7 = (y & {8{x[6]}});
wire [7:0] part8 = (y & {8{x[7]}});

wire [8:0] new_part1;
assign new_part1[0] = part1[0];
assign new_part1[1] = (part1[1]|part2[0]);
assign new_part1[2] = (part1[2]|part2[1]);
assign new_part1[3] = (part1[3]|part2[2]);
assign new_part1[4] = (part1[4]|part2[3]);
assign new_part1[5] = (part1[5]|part2[4]);
assign new_part1[6] = (part1[6]|part2[5]);
assign new_part1[7] = (part1[7]|part2[6]);
assign new_part1[8] = part2[7];

wire [9:0] new_part2;
assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = part3[0];
assign new_part2[3] = (part3[1]|part4[0]);
assign new_part2[4] = (part3[2]|part4[1]);
assign new_part2[5] = (part3[3]|part4[2]);
assign new_part2[6] = (part3[4]|part4[3]);
assign new_part2[7] = (part3[5]|part4[4]);
assign new_part2[8] = (part3[6]|part4[5]);
assign new_part2[9] = part4[6];


wire [10:0] new_part3;
assign new_part3[0] = 0;
assign new_part3[1] = 0;
assign new_part3[2] = 0;
assign new_part3[3] = 0;
assign new_part3[4] = part5[0];
assign new_part3[5] = (part5[1]|part6[0]);
assign new_part3[6] = (part5[2]|part6[1]);
assign new_part3[7] = (part5[3]|part6[2]);
assign new_part3[8] = (part5[4]|part6[3]);
assign new_part3[9] = (part5[5]|part6[4]);
assign new_part3[10] = part6[5];

wire [11:0] new_part4;
assign new_part4[0] = 0;
assign new_part4[1] = 0;
assign new_part4[2] = 0;
assign new_part4[3] = 0;
assign new_part4[4] = 0;
assign new_part4[5] = 0;
assign new_part4[6] = part7[0];
assign new_part4[7] = (part7[1]|part8[0]);
assign new_part4[8] = (part7[2]|part8[1]);
assign new_part4[9] = (part7[3]|part8[2]);
assign new_part4[10] = (part7[4]|part8[3]);
assign new_part4[11] = part8[4];

wire [14:0] result1 = {part8[7], part7[7], part6[7], part5[7], part4[7], part3[7], new_part1};
wire [13:0] result2 = {part8[6], part7[6], part6[6], part5[6], new_part2};
wire [12:0] result3 = {part8[5], part7[5], new_part3};
wire [11:0] result4 = new_part4;

assign z = result1 + result2 + result3 + result4;

endmodule