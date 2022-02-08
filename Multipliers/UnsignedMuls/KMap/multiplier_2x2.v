module multiplier_2x2(
    input  wire [1:0] a,
    input  wire [1:0] b,
    output wire [2:0] out
);

assign out[0] = a[0] & b[0];
assign out[1] = (a[0] & b[1] ) | (a[1] & b[0]);
assign out[2] = (a[1] & b[1]);

endmodule