module LeNet_XWYF_66 (
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

wire [12:0] new_part1;
wire [12:0] new_part2;
wire [12:0] new_part3;
wire [12:0] new_part4;
wire [12:0] new_part5;
wire [12:0] new_part6;
wire [12:0] new_part7;

assign new_part1[0] = 0;
assign new_part1[1] = 0;
assign new_part1[2] = 0;
assign new_part1[3] = part3[1]^part4[0];
assign new_part1[4] = part3[1]&part4[0];
assign new_part1[5] = part1[4]&part2[3];
assign new_part1[6] = part1[5]&part2[4];
assign new_part1[7] = part3[5]&part4[4];
assign new_part1[8] = part1[7]^part2[6];
assign new_part1[9] = part3[7]|part4[6];
assign new_part1[10] = part4[7];
assign new_part1[11] = part5[6]&part6[5];
assign new_part1[12] = part5[7]&part6[6];

assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = 0;
assign new_part2[3] = 0;
assign new_part2[4] = 0;
assign new_part2[5] = part3[3]|part4[2];
assign new_part2[6] = part1[5]^part2[4];
assign new_part2[7] = 0;
assign new_part2[8] = part2[7];
assign new_part2[9] = part5[4]&part6[3];
assign new_part2[10] = part5[5]&part6[4];
assign new_part2[11] = part5[7]^part6[6];
assign new_part2[12] = part6[7];

assign new_part3[0] = 0;
assign new_part3[1] = 0;
assign new_part3[2] = 0;
assign new_part3[3] = 0;
assign new_part3[4] = 0;
assign new_part3[5] = 0;
assign new_part3[6] = part3[3]&part4[2];
assign new_part3[7] = 0;
assign new_part3[8] = part3[5]^part4[4];
assign new_part3[9] = part5[5]^part6[4];
assign new_part3[10] = part5[6]^part6[5];
assign new_part3[11] = 0;
assign new_part3[12] = 0;

assign new_part4[0] = 0;
assign new_part4[1] = 0;
assign new_part4[2] = 0;
assign new_part4[3] = 0;
assign new_part4[4] = 0;
assign new_part4[5] = 0;
assign new_part4[6] = 0;
assign new_part4[7] = 0;
assign new_part4[8] = part3[6]|part4[5];
assign new_part4[9] = 0;
assign new_part4[10] = 0;
assign new_part4[11] = 0;
assign new_part4[12] = 0;

assign new_part5[0] = 0;
assign new_part5[1] = 0;
assign new_part5[2] = 0;
assign new_part5[3] = 0;
assign new_part5[4] = 0;
assign new_part5[5] = 0;
assign new_part5[6] = 0;
assign new_part5[7] = 0;
assign new_part5[8] = part5[3]&part6[2];
assign new_part5[9] = 0;
assign new_part5[10] = 0;
assign new_part5[11] = 0;
assign new_part5[12] = 0;

assign new_part6[0] = 0;
assign new_part6[1] = 0;
assign new_part6[2] = 0;
assign new_part6[3] = 0;
assign new_part6[4] = 0;
assign new_part6[5] = 0;
assign new_part6[6] = 0;
assign new_part6[7] = 0;
assign new_part6[8] = part5[3]^part6[2];
assign new_part6[9] = 0;
assign new_part6[10] = 0;
assign new_part6[11] = 0;
assign new_part6[12] = 0;

assign new_part7[0] = 0;
assign new_part7[1] = 0;
assign new_part7[2] = 0;
assign new_part7[3] = 0;
assign new_part7[4] = 0;
assign new_part7[5] = 0;
assign new_part7[6] = 0;
assign new_part7[7] = 0;
assign new_part7[8] = part5[4]^part6[3];
assign new_part7[9] = 0;
assign new_part7[10] = 0;
assign new_part7[11] = 0;
assign new_part7[12] = 0;

assign z = {part7, 6'b0} + {part8, 7'b0} + new_part1 + new_part2 + new_part3 + new_part4 + new_part5 + new_part6 + new_part7;

endmodule