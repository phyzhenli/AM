module XSYW_18(
    input [15:0] x, y,
    output [31:0] z
    );

wire [16:0] part1;
wire [15:0] part2;
wire [15:0] part3;
wire [15:0] part4;
wire [15:0] part5;
wire [15:0] part6;
wire [15:0] part7;
wire [15:0] part8;
wire [15:0] part9;
wire [15:0] part10;
wire [15:0] part11;
wire [15:0] part12;
wire [15:0] part13;
wire [15:0] part14;
wire [15:0] part15;
wire [16:0] part16;

assign part1[14:0] = y[14:0] & {15{x[0]}};
assign part1[15] = ~(y[15] & x[0]);
assign part1[16] = 1'b1;

assign part16[14:0] = ~(y[14:0] & {15{x[15]}});
assign part16[15] = y[15] & x[15];
assign part16[16] = 1'b1;

assign part2[14:0]  = y[14:0] & {15{x[1]}};  assign part2[15]  = ~(y[15] & x[1]);
assign part3[14:0]  = y[14:0] & {15{x[2]}};  assign part3[15]  = ~(y[15] & x[2]);
assign part4[14:0]  = y[14:0] & {15{x[3]}};  assign part4[15]  = ~(y[15] & x[3]);
assign part5[14:0]  = y[14:0] & {15{x[4]}};  assign part5[15]  = ~(y[15] & x[4]);
assign part6[14:0]  = y[14:0] & {15{x[5]}};  assign part6[15]  = ~(y[15] & x[5]);
assign part7[14:0]  = y[14:0] & {15{x[6]}};  assign part7[15]  = ~(y[15] & x[6]);
assign part8[14:0]  = y[14:0] & {15{x[7]}};  assign part8[15]  = ~(y[15] & x[7]);
assign part9[14:0]  = y[14:0] & {15{x[8]}};  assign part9[15]  = ~(y[15] & x[8]);
assign part10[14:0] = y[14:0] & {15{x[9]}};  assign part10[15] = ~(y[15] & x[9]);
assign part11[14:0] = y[14:0] & {15{x[10]}}; assign part11[15] = ~(y[15] & x[10]);
assign part12[14:0] = y[14:0] & {15{x[11]}}; assign part12[15] = ~(y[15] & x[11]);
assign part13[14:0] = y[14:0] & {15{x[12]}}; assign part13[15] = ~(y[15] & x[12]);
assign part14[14:0] = y[14:0] & {15{x[13]}}; assign part14[15] = ~(y[15] & x[13]);
assign part15[14:0] = y[14:0] & {15{x[14]}}; assign part15[15] = ~(y[15] & x[14]);

wire [20:0] new_part1;
wire [20:0] new_part2;
wire [20:0] new_part3;
wire [20:0] new_part4;
wire [20:0] new_part5;

assign new_part1[0] = 0;
assign new_part1[1] = part1[1]^part2[0];
assign new_part1[2] = 0;
assign new_part1[3] = 0;
assign new_part1[4] = 0;
assign new_part1[5] = part1[4]&part2[3];
assign new_part1[6] = part5[1]&part6[0];
assign new_part1[7] = part1[7]^part2[6];
assign new_part1[8] = part5[4]^part6[3];
assign new_part1[9] = 0;
assign new_part1[10] = part3[8]^part4[7];
assign new_part1[11] = 0;
assign new_part1[12] = part1[12]^part2[11];
assign new_part1[13] = part1[12]&part2[11];
assign new_part1[14] = 0;
assign new_part1[15] = part5[10]&part6[9];
assign new_part1[16] = part3[14]^part4[13];
assign new_part1[17] = part2[15]^(1'b1);
assign new_part1[18] = part3[15]&part4[14];
assign new_part1[19] = part5[14]&part6[13];
assign new_part1[20] = part5[15]&part6[14];

assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = 0;
assign new_part2[3] = 0;
assign new_part2[4] = 0;
assign new_part2[5] = part1[5]^part2[4];
assign new_part2[6] = 0;
assign new_part2[7] = part5[2]&part6[1];
assign new_part2[8] = 0;
assign new_part2[9] = 0;
assign new_part2[10] = 0;
assign new_part2[11] = 0;
assign new_part2[12] = part5[8]^part6[7];
assign new_part2[13] = 0;
assign new_part2[14] = 0;
assign new_part2[15] = part5[11]^part6[10];
assign new_part2[16] = 0;
assign new_part2[17] = part3[14]&part4[13];
assign new_part2[18] = part3[15]^part4[14];
assign new_part2[19] = part5[15]^part6[14];
assign new_part2[20] = part6[15];

assign new_part3[0] = 0;
assign new_part3[1] = 0;
assign new_part3[2] = 0;
assign new_part3[3] = 0;
assign new_part3[4] = 0;
assign new_part3[5] = part5[1]^part6[0];
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
assign new_part3[17] = part5[13]^part6[12];
assign new_part3[18] = part4[15];
assign new_part3[19] = 0;
assign new_part3[20] = 0;

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
assign new_part4[18] = part5[13]&part6[12];
assign new_part4[19] = 0;
assign new_part4[20] = 0;

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
assign new_part5[18] = part5[14]^part6[13];
assign new_part5[19] = 0;
assign new_part5[20] = 0;

assign z = {part7, 6'b0} + {part8, 7'b0} + {part9, 8'b0} + {part10, 9'b0} + {part11, 10'b0} + {part12, 11'b0} + {part13, 12'b0} + {part14, 13'b0} + {part15, 14'b0} + {part16, 15'b0} + new_part1 + new_part2 + new_part3 + new_part4 + new_part5;

endmodule