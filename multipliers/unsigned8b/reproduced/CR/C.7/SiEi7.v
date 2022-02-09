module stage1_compress(
    input  [7:0]  part_t,
    input  [7:0]  part_b,
    output [8:0]  result,
    output [14:0] Error
);

assign result[0] = part_t[0];
assign result[1] = (part_t[1]^part_b[0]);
assign result[2] = (part_t[2]^part_b[1])|(part_t[1]&part_b[0]);
assign result[3] = (part_t[3]^part_b[2])|(part_t[2]&part_b[1]);
assign result[4] = (part_t[4]^part_b[3])|(part_t[3]&part_b[2]);
assign result[5] = (part_t[5]^part_b[4])|(part_t[4]&part_b[3]);
assign result[6] = (part_t[6]^part_b[5])|(part_t[5]&part_b[4]);
assign result[7] = (part_t[7]^part_b[6])|(part_t[6]&part_b[5]);
assign result[8] = part_b[7]|(part_t[7]&part_b[6]);

assign Error[2] = (part_t[2]^part_b[1])&(part_t[1]&part_b[0]);
assign Error[3] = (part_t[3]^part_b[2])&(part_t[2]&part_b[1]);
assign Error[4] = (part_t[4]^part_b[3])&(part_t[3]&part_b[2]);
assign Error[5] = (part_t[5]^part_b[4])&(part_t[4]&part_b[3]);
assign Error[6] = (part_t[6]^part_b[5])&(part_t[5]&part_b[4]);
assign Error[7] = (part_t[7]^part_b[6])&(part_t[6]&part_b[5]);
assign Error[8] = (part_b[7])&(part_t[7]&part_b[6]);

assign Error[0] = 0;
assign Error[1] = 0;
assign Error[9] = 0;
assign Error[10] = 0;
assign Error[11] = 0;
assign Error[12] = 0;
assign Error[13] = 0;
assign Error[14] = 0;

endmodule

module stage2_compress(
    input  [8:0]  part_t,
    input  [8:0]  part_b,
    output [10:0] result,
    output [14:0] Error
);

assign result[0] = part_t[0];
assign result[1] = part_t[1];
assign result[2] = (part_t[2]^part_b[0]);
assign result[3] = (part_t[3]^part_b[1])|(part_t[2]&part_b[0]);
assign result[4] = (part_t[4]^part_b[2])|(part_t[3]&part_b[1]);
assign result[5] = (part_t[5]^part_b[3])|(part_t[4]&part_b[2]);
assign result[6] = (part_t[6]^part_b[4])|(part_t[5]&part_b[3]);
assign result[7] = (part_t[7]^part_b[5])|(part_t[6]&part_b[4]);
assign result[8] = (part_t[8]^part_b[6])|(part_t[7]&part_b[5]);
assign result[9] = part_b[7]|(part_t[8]&part_b[6]);
assign result[10] = part_b[8];

assign Error[3] = (part_t[3]^part_b[1])&(part_t[2]&part_b[0]);
assign Error[4] = (part_t[4]^part_b[2])&(part_t[3]&part_b[1]);
assign Error[5] = (part_t[5]^part_b[3])&(part_t[4]&part_b[2]);
assign Error[6] = (part_t[6]^part_b[4])&(part_t[5]&part_b[3]);
assign Error[7] = (part_t[7]^part_b[5])&(part_t[6]&part_b[4]);
assign Error[8] = (part_t[8]^part_b[6])&(part_t[7]&part_b[5]);
assign Error[9] = part_b[7]&(part_t[8]&part_b[6]);

assign Error[0] = 0;
assign Error[1] = 0;
assign Error[2] = 0;
assign Error[10] = 0;
assign Error[11] = 0;
assign Error[12] = 0;
assign Error[13] = 0;
assign Error[14] = 0;

endmodule

module stage3_compress (
    input  [10:0]  part_t,
    input  [10:0]  part_b,
    output [14:0] result,
    output [14:0] Error
);

assign result[0] = part_t[0];
assign result[1] = part_t[1];
assign result[2] = part_t[2];
assign result[3] = part_t[3];

assign result[4] = (part_t[4]^part_b[0]);
assign result[5] = (part_t[5]^part_b[1])|(part_t[4]&part_b[0]);
assign result[6] = (part_t[6]^part_b[2])|(part_t[5]&part_b[1]);
assign result[7] = (part_t[7]^part_b[3])|(part_t[6]&part_b[2]);
assign result[8] = (part_t[8]^part_b[4])|(part_t[7]&part_b[3]);
assign result[9] = (part_t[9]^part_b[5])|(part_t[8]&part_b[4]);
assign result[10] = (part_t[10]^part_b[6])|(part_t[9]&part_b[5]);

assign result[11] = part_b[7]|(part_t[10]&part_b[6]);
assign result[12] = part_b[8];
assign result[13] = part_b[9];
assign result[14] = part_b[10];

assign Error[5] = (part_t[5]^part_b[1])&(part_t[4]&part_b[0]);
assign Error[6] = (part_t[6]^part_b[2])&(part_t[5]&part_b[1]);
assign Error[7] = (part_t[7]^part_b[3])&(part_t[6]&part_b[2]);
assign Error[8] = (part_t[8]^part_b[4])&(part_t[7]&part_b[3]);
assign Error[9] = (part_t[9]^part_b[5])&(part_t[8]&part_b[4]);
assign Error[10] = (part_t[10]^part_b[6])&(part_t[9]&part_b[5]);
assign Error[11] = part_b[7]&(part_t[10]&part_b[6]);

assign Error[0] = 0;
assign Error[1] = 0;
assign Error[2] = 0;
assign Error[3] = 0;
assign Error[4] = 0;
assign Error[12] = 0;
assign Error[13] = 0;
assign Error[14] = 0;

endmodule

module SiEi7(
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

wire [8:0] stage2_1;
wire [8:0] stage2_2;
wire [8:0] stage2_3;
wire [8:0] stage2_4;
wire [14:0] A1;
wire [14:0] A2;
wire [14:0] A3;
wire [14:0] A4;

stage1_compress s1(part1, part2, stage2_1, A1);
stage1_compress s2(part3, part4, stage2_2, A2);
stage1_compress s3(part5, part6, stage2_3, A3);
stage1_compress s4(part7, part8, stage2_4, A4);

wire [10:0] stage3_1;
wire [10:0] stage3_2;
wire [14:0] A5;
wire [14:0] A6;

stage2_compress s5(stage2_1, stage2_2, stage3_1, A5);
stage2_compress s6(stage2_3, stage2_4, stage3_2, A6);

wire [14:0] stage4;
wire [14:0] A7;
stage3_compress s7(stage3_1, stage3_2, stage4, A7);

wire [14:0] Recovery;
assign Recovery = A1 | ((A2 << 2) | (A3 << 4) | (A4 << 6) | A5 | (A6 << 4) | A7);

wire [14:0] compens = {Recovery[14:8], 8'b0};


assign z = stage4 + compens;

endmodule