module sbit16_designware(input signed [15:0] x,y, output signed [31:0] z
    );

	assign z = x*y;

endmodule
