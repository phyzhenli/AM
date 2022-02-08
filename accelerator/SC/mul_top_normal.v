`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2021 03:42:36 PM
// Design Name: 
// Module Name: mul_top_normal
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define MUL2X2 mul_2x2
`define MUL2X2_KMAP mul_2x2_kmap

module mul_top_normal(
    input  [7:0]  a, 
    input  [7:0]  b, 
    output [15:0] o 
    );
    
    wire [3:0] part_a0b0; 
    wire [3:0] part_a2b0; 
    wire [3:0] part_a4b0; 
    wire [3:0] part_a6b0; 
    wire [3:0] part_a0b2; 
    wire [3:0] part_a2b2; 
    wire [3:0] part_a4b2; 
    wire [3:0] part_a6b2; 
    wire [3:0] part_a0b4; 
    wire [3:0] part_a2b4; 
    wire [3:0] part_a4b4; 
    wire [3:0] part_a6b4; 
    wire [3:0] part_a0b6; 
    wire [3:0] part_a2b6; 
    wire [3:0] part_a4b6; 
    wire [3:0] part_a6b6; 
    
     `MUL2X2 mul_a0b0(.a(a[1:0]), .b(b[1:0]), .o(part_a0b0)); 
     `MUL2X2 mul_a2b0(.a(a[3:2]), .b(b[1:0]), .o(part_a2b0)); 
     `MUL2X2 mul_a4b0(.a(a[5:4]), .b(b[1:0]), .o(part_a4b0)); 
     `MUL2X2 mul_a6b0(.a(a[7:6]), .b(b[1:0]), .o(part_a6b0)); 
     `MUL2X2 mul_a0b2(.a(a[1:0]), .b(b[3:2]), .o(part_a0b2)); 
     `MUL2X2 mul_a2b2(.a(a[3:2]), .b(b[3:2]), .o(part_a2b2)); 
     `MUL2X2 mul_a4b2(.a(a[5:4]), .b(b[3:2]), .o(part_a4b2)); 
     `MUL2X2 mul_a6b2(.a(a[7:6]), .b(b[3:2]), .o(part_a6b2)); 
     `MUL2X2 mul_a0b4(.a(a[1:0]), .b(b[5:4]), .o(part_a0b4)); 
     `MUL2X2 mul_a2b4(.a(a[3:2]), .b(b[5:4]), .o(part_a2b4)); 
     `MUL2X2 mul_a4b4(.a(a[5:4]), .b(b[5:4]), .o(part_a4b4)); 
     `MUL2X2 mul_a6b4(.a(a[7:6]), .b(b[5:4]), .o(part_a6b4)); 
     `MUL2X2 mul_a0b6(.a(a[1:0]), .b(b[7:6]), .o(part_a0b6)); 
     `MUL2X2 mul_a2b6(.a(a[3:2]), .b(b[7:6]), .o(part_a2b6)); 
     `MUL2X2 mul_a4b6(.a(a[5:4]), .b(b[7:6]), .o(part_a4b6)); 
     `MUL2X2 mul_a6b6(.a(a[7:6]), .b(b[7:6]), .o(part_a6b6)); 
    
    wire [15:0] partial_0 = {part_a6b6, part_a6b2, part_a4b0, part_a0b0}; 
    wire [11:0] partial_1 = {part_a6b4, part_a6b0, part_a2b0}; 
    wire [11:0] partial_2 = {part_a4b6, part_a4b2, part_a0b2}; 
    wire [7:0]  partial_3 = {part_a4b4, part_a2b2}; 
    wire [7:0]  partial_4 = {part_a2b6, part_a0b4}; 
    wire [3:0]  partial_5 = {part_a2b4}; 
    wire [3:0]  partial_6 = {part_a0b6}; 
    
    wire [12:0] added_12 = {1'b0, partial_1} + {1'b0, partial_2}; 
    wire [8:0]  added_34 = {1'b0, partial_3} + {1'b0, partial_4}; 
    wire [4:0]  added_56 = {1'b0, partial_5} + {1'b0, partial_6}; 
    
    wire [15:0] toadd_0 = partial_0 + {5'b00000, added_56, 6'o00}; 
    wire [12:0] toadd_1 = added_12 + {2'b00, added_34, 2'b00}; 
    
    assign o = toadd_0 + {toadd_1, 2'b00}; 
    
endmodule
