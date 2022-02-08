`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 07:34:19 PM
// Design Name: 
// Module Name: mine_test0
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
`define MUL2X3 mul_2x3
`define MUL3X2 mul_3x2
`define MUL3X3 mul_3x3

module mine_test0(
    input  [7:0]  a, 
    input  [7:0]  b, 
    output [15:0] o 
    );
    
    wire [7:0]  _a; 
    wire [7:0]  _b; 
    wire [15:0] _o; 
    
    assign _a = a[7] == 1 ? (a & 8'b01111111) : (~a + 1); 
    assign _b = b; 
    assign o  = _a[7] == 1 ? (({7'h00, _b} << 7) + _o) : (({7'h00, _b} << 7) - _o); 
    
    wire [5:0] part_a0b0; 
    wire [4:0] part_a3b0; 
    wire [4:0] part_a5b0; 
    wire [4:0] part_a0b3; 
    wire [3:0] part_a3b3; 
    wire [3:0] part_a5b3; 
    wire [4:0] part_a0b5; 
    wire [3:0] part_a3b5; 
    wire [3:0] part_a5b5; 
    wire [7:0] part_a0b7; 
    
    `MUL3X3 mul_a0b0(.a(_a[2:0]), .b(_b[2:0]), .o(part_a0b0)); 
    `MUL2X3 mul_a3b0(.a(_a[4:3]), .b(_b[2:0]), .o(part_a3b0)); 
    `MUL2X3 mul_a5b0(.a(_a[6:5]), .b(_b[2:0]), .o(part_a5b0)); 
    `MUL3X2 mul_a0b3(.a(_a[2:0]), .b(_b[4:3]), .o(part_a0b3)); 
    `MUL2X2 mul_a3b3(.a(_a[4:3]), .b(_b[4:3]), .o(part_a3b3)); 
    `MUL2X2 mul_a5b3(.a(_a[6:5]), .b(_b[4:3]), .o(part_a5b3)); 
    `MUL3X2 mul_a0b5(.a(_a[2:0]), .b(_b[6:5]), .o(part_a0b5)); 
    `MUL2X2 mul_a3b5(.a(_a[4:3]), .b(_b[6:5]), .o(part_a3b5)); 
    `MUL2X2 mul_a5b5(.a(_a[6:5]), .b(_b[6:5]), .o(part_a5b5)); 
    assign part_a0b7 = _b[7] == 1 ? _a : 0; 
    
    wire [13:0] partial_0 = {part_a5b5, part_a3b3, part_a0b0}; 
    wire [8:0]  partial_1 = {part_a5b3, part_a3b0}; 
    wire [8:0]  partial_2 = {part_a3b5, part_a0b3}; 
    wire [4:0]  partial_3 = part_a5b0; 
    wire [4:0]  partial_4 = part_a0b5; 
    wire [7:0]  partial_5 = part_a0b7; 
    
    wire [9:0]  toadd_0 = {1'b0, partial_1} + {1'b0, partial_2}; 
    wire [14:0] toadd_1 = {1'b0, partial_0} + {5'b00000, (b[7] == 0 ? part_a5b0 : part_a0b5), 5'b00000}; 
    wire [14:0] added   = toadd_1 + {2'b00, toadd_0, 3'b000}; 
    
    assign _o = {1'b0, added}; 
    
endmodule

module mine_test1(
    input  [7:0]  a, 
    input  [7:0]  b, 
    output [15:0] o 
    );
    
    wire [7:0]  _a; 
    wire [7:0]  _b; 
    wire [15:0] _o; 
    
    assign _a = a[7] == 1 ? (a & 8'b01111111) : (~a + 1); 
    assign _b = b; 
    assign o  = _a[7] == 1 ? (({7'h00, _b} << 7) + _o) : (({7'h00, _b} << 7) - _o); 
    
    wire [5:0] part_a0b0; 
    wire [4:0] part_a3b0; 
    wire [4:0] part_a5b0; 
    wire [4:0] part_a0b3; 
    wire [3:0] part_a3b3; 
    wire [3:0] part_a5b3; 
    wire [4:0] part_a0b5; 
    wire [3:0] part_a3b5; 
    wire [3:0] part_a5b5; 
    wire [7:0] part_a0b7; 
    wire [7:0] part_a7b0; 
    
    `MUL3X3 mul_a0b0(.a(_a[2:0]), .b(_b[2:0]), .o(part_a0b0)); 
    `MUL2X3 mul_a3b0(.a(_a[4:3]), .b(_b[2:0]), .o(part_a3b0)); 
    `MUL2X3 mul_a5b0(.a(_a[6:5]), .b(_b[2:0]), .o(part_a5b0)); 
    `MUL3X2 mul_a0b3(.a(_a[2:0]), .b(_b[4:3]), .o(part_a0b3)); 
    `MUL2X2 mul_a3b3(.a(_a[4:3]), .b(_b[4:3]), .o(part_a3b3)); 
    `MUL2X2 mul_a5b3(.a(_a[6:5]), .b(_b[4:3]), .o(part_a5b3)); 
    `MUL3X2 mul_a0b5(.a(_a[2:0]), .b(_b[6:5]), .o(part_a0b5)); 
    `MUL2X2 mul_a3b5(.a(_a[4:3]), .b(_b[6:5]), .o(part_a3b5)); 
    `MUL2X2 mul_a5b5(.a(_a[6:5]), .b(_b[6:5]), .o(part_a5b5)); 
    assign part_a0b7 = _b[7] == 1 ? _a : 0; 
    assign part_a7b0 = _a[7] == 1 ? _b : 0; 
    
    wire [13:0] partial_0 = {part_a5b5, part_a3b3, part_a0b0}; 
    wire [8:0]  partial_1 = {part_a5b3, part_a3b0}; 
    wire [8:0]  partial_2 = {part_a3b5, part_a0b3}; 
    wire [4:0]  partial_3 = part_a5b0; 
    wire [4:0]  partial_4 = part_a0b5; 
    wire [7:0]  partial_5 = part_a0b7; 
    wire [7:0]  partial_6 = part_a7b0; 
    
    wire [13:0] beforemod_0 = partial_0; 
    wire [11:0] beforemod_1 = {partial_1, 3'b000}; 
    wire [11:0] beforemod_2 = {partial_2, 3'b000}; 
    wire [9:0]  beforemod_3 = {(b[7] == 0 ? partial_3 : partial_4), 5'b00000}; 
    wire [14:0] beforemod_4 = {_b, 7'b0000000}; 
    
    wire [9:0]  toadd_0 = {1'b0, partial_1} + {1'b0, partial_2}; 
    wire [14:0] toadd_1 = partial_0 + {2'b00, partial_6[4:3], (b[7] == 0 ? partial_3 : partial_4), 5'b00000}; 
    wire [14:0] added   = toadd_1 + {toadd_0, 3'b000}; 
    
    assign _o = {1'b0, added}; 
    
endmodule
