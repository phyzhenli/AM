`timescale 1ns/1ps

module optimal1(
    input  [7:0]  x,
    input  [7:0]  y,
    output [15:0] z
);

wire [15:0] x0 = x << 7;
wire [15:0] y0 = y << 7;
wire signed [16:0] z0 = $signed(x0) + $signed(y0) - 16384;

wire [16:0] x_wire = x;
wire [16:0] y_wire = y;

wire signed [16:0] detz1 = (x>=0 && x<128 && y>=0 && y<128)? ($signed(x_wire))*(64-128)+($signed(y_wire))*(64-128)+128*128-64*64
: (x>=0 && x<128 && y>=128 && y<256)? ($signed(x_wire))*(192-128)+($signed(y_wire))*(64-128)+128*128-64*192
: (x>=128 && x<256 && y>=0 && y<128)? ($signed(x_wire))*(64-128)+($signed(y_wire))*(192-128)+128*128-192*64
: (x>=128 && x<256 && y>=128 && y<256)? ($signed(x_wire))*(192-128)+($signed(y_wire))*(192-128)+128*128-192*192
: 0;

wire signed [16:0] z_sign = z0 + detz1;

assign z = (z_sign < 0)? 0 : z_sign[15:0];

endmodule
