`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 10:02:28 AM
// Design Name: 
// Module Name: mul_top_wierd
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

module mul_top_wierd_ref(
    input  [7:0]  a, 
    input  [7:0]  b, 
    output [15:0] o 
    );
    
    wire [7:0] _a; 
    wire [7:0] _b; 
    wire [15:0] _o; 
    comple2true_8 c2t_a(.a(a),  .o(_a)); 
    comple2true_8 c2t_b(.a(b),  .o(_b)); 
    true2comple_16 t2c_o(.a(_o), .o(o)); 
    
    wire [5:0] part_a0b0; 
    wire [4:0] part_a3b0; 
    wire [4:0] part_a5b0; 
    wire [4:0] part_a0b3; 
    wire [3:0] part_a3b3; 
    wire [3:0] part_a5b3; 
    wire [4:0] part_a0b5; 
    wire [3:0] part_a3b5; 
    wire [3:0] part_a5b5; 
    
    `MUL3X3 mul_a0b0(.a(_a[2:0]), .b(_b[2:0]), .o(part_a0b0)); 
    `MUL2X3 mul_a3b0(.a(_a[4:3]), .b(_b[2:0]), .o(part_a3b0)); 
    `MUL2X3 mul_a5b0(.a(_a[6:5]), .b(_b[2:0]), .o(part_a5b0)); 
    `MUL3X2 mul_a0b3(.a(_a[2:0]), .b(_b[4:3]), .o(part_a0b3)); 
    `MUL2X2 mul_a3b3(.a(_a[4:3]), .b(_b[4:3]), .o(part_a3b3)); 
    `MUL2X2 mul_a5b3(.a(_a[6:5]), .b(_b[4:3]), .o(part_a5b3)); 
    `MUL3X2 mul_a0b5(.a(_a[2:0]), .b(_b[6:5]), .o(part_a0b5)); 
    `MUL2X2 mul_a3b5(.a(_a[4:3]), .b(_b[6:5]), .o(part_a3b5)); 
    `MUL2X2 mul_a5b5(.a(_a[6:5]), .b(_b[6:5]), .o(part_a5b5)); 
    
    wire [13:0] partial_0 = {part_a5b5, part_a3b3, part_a0b0}; 
    wire [8:0]  partial_1 = {part_a5b3, part_a3b0}; 
    wire [8:0]  partial_2 = {part_a3b5, part_a0b3}; 
    wire [4:0]  partial_3 = part_a5b0; 
    wire [4:0]  partial_4 = part_a0b5; 
    
    wire [5:0]  toadd_0 = {1'b0, partial_3} + {1'b0, partial_4}; 
    wire [9:0]  toadd_1 = {1'b0, partial_1} + {1'b0, partial_2}; 
    wire [13:0] toadd_2 = partial_0 + {3'b000, toadd_0, 5'b00000}; 
    wire [13:0] added   = toadd_2 + {1'b0, toadd_1, 3'b000}; 
    
    assign _o = {_a[7]^_b[7], 1'b0, added}; 
    
endmodule

module mul_top_wierd(
    input  [7:0]  a, 
    input  [7:0]  b, 
    output [15:0] o 
    );
    
    wire [7:0] _a; 
    wire [7:0] _b; 
    wire [15:0] _o; 
    comple2true_8 c2t_a(.a(a),  .o(_a)); 
    comple2true_8 c2t_b(.a(b),  .o(_b)); 
    true2comple_16 t2c_o(.a(_o), .o(o)); 
    
    wire [5:0] part_a0b0; 
    wire [4:0] part_a3b0; 
    wire [4:0] part_a5b0; 
    wire [4:0] part_a0b3; 
    wire [3:0] part_a3b3; 
    wire [3:0] part_a5b3; 
    wire [4:0] part_a0b5; 
    wire [3:0] part_a3b5; 
    wire [3:0] part_a5b5; 
    
    `MUL3X3 mul_a0b0(.a(_a[2:0]), .b(_b[2:0]), .o(part_a0b0)); 
    `MUL2X3 mul_a3b0(.a(_a[4:3]), .b(_b[2:0]), .o(part_a3b0)); 
    `MUL2X3 mul_a5b0(.a(_a[6:5]), .b(_b[2:0]), .o(part_a5b0)); 
    `MUL3X2 mul_a0b3(.a(_a[2:0]), .b(_b[4:3]), .o(part_a0b3)); 
    `MUL2X2 mul_a3b3(.a(_a[4:3]), .b(_b[4:3]), .o(part_a3b3)); 
    `MUL2X2 mul_a5b3(.a(_a[6:5]), .b(_b[4:3]), .o(part_a5b3)); 
    `MUL3X2 mul_a0b5(.a(_a[2:0]), .b(_b[6:5]), .o(part_a0b5)); 
    `MUL2X2 mul_a3b5(.a(_a[4:3]), .b(_b[6:5]), .o(part_a3b5)); 
    `MUL2X2 mul_a5b5(.a(_a[6:5]), .b(_b[6:5]), .o(part_a5b5)); 
    
    wire [13:0] partial_0 = {part_a5b5, part_a3b3, part_a0b0}; 
    wire [8:0]  partial_1 = {part_a5b3, part_a3b0}; 
    wire [8:0]  partial_2 = {part_a3b5, part_a0b3}; 
    wire [4:0]  partial_3 = part_a5b0; 
    wire [4:0]  partial_4 = part_a0b5; 
    
    wire [9:0]  toadd_0 = {1'b0, partial_1} + {1'b0, partial_2}; 
    wire [13:0] toadd_1 = partial_0 + {4'b0000, (b[7] == 0 ? part_a5b0 : part_a0b5), 5'b00000}; 
    wire [13:0] added   = toadd_1 + {1'b0, toadd_0, 3'b000}; 
    
    assign _o = {_a[7]^_b[7], 1'b0, added}; 
    
endmodule

module mul_top_wierd_ref_nocode(
    input  [7:0]  a, 
    input  [7:0]  b, 
    output [15:0] o 
    );
    
    wire [5:0] part_a0b0; 
    wire [4:0] part_a3b0; 
    wire [4:0] part_a5b0; 
    wire [4:0] part_a0b3; 
    wire [3:0] part_a3b3; 
    wire [3:0] part_a5b3; 
    wire [4:0] part_a0b5; 
    wire [3:0] part_a3b5; 
    wire [3:0] part_a5b5; 
    
    `MUL3X3 mul_a0b0(.a(a[2:0]), .b(b[2:0]), .o(part_a0b0)); 
    `MUL2X3 mul_a3b0(.a(a[4:3]), .b(b[2:0]), .o(part_a3b0)); 
    `MUL2X3 mul_a5b0(.a(a[6:5]), .b(b[2:0]), .o(part_a5b0)); 
    `MUL3X2 mul_a0b3(.a(a[2:0]), .b(b[4:3]), .o(part_a0b3)); 
    `MUL2X2 mul_a3b3(.a(a[4:3]), .b(b[4:3]), .o(part_a3b3)); 
    `MUL2X2 mul_a5b3(.a(a[6:5]), .b(b[4:3]), .o(part_a5b3)); 
    `MUL3X2 mul_a0b5(.a(a[2:0]), .b(b[6:5]), .o(part_a0b5)); 
    `MUL2X2 mul_a3b5(.a(a[4:3]), .b(b[6:5]), .o(part_a3b5)); 
    `MUL2X2 mul_a5b5(.a(a[6:5]), .b(b[6:5]), .o(part_a5b5)); 
    
    wire [13:0] partial_0 = {part_a5b5, part_a3b3, part_a0b0}; 
    wire [8:0]  partial_1 = {part_a5b3, part_a3b0}; 
    wire [8:0]  partial_2 = {part_a3b5, part_a0b3}; 
    wire [4:0]  partial_3 = part_a5b0; 
    wire [4:0]  partial_4 = part_a0b5; 
    
    wire [5:0]  toadd_0 = {1'b0, partial_3} + {1'b0, partial_4}; 
    wire [9:0]  toadd_1 = {1'b0, partial_1} + {1'b0, partial_2}; 
    wire [13:0] toadd_2 = partial_0 + {3'b000, toadd_0, 5'b00000}; 
    wire [13:0] added   = toadd_2 + {1'b0, toadd_1, 3'b000}; 
    
    assign o = {2'b00, added}; 
    
endmodule

module mul_top_wierd_nocode(
    input  [7:0]  a, 
    input  [7:0]  b, 
    output [15:0] o 
    );
    
    wire [5:0] part_a0b0; 
    wire [4:0] part_a3b0; 
    wire [4:0] part_a5b0; 
    wire [4:0] part_a0b3; 
    wire [3:0] part_a3b3; 
    wire [3:0] part_a5b3; 
    wire [4:0] part_a0b5; 
    wire [3:0] part_a3b5; 
    wire [3:0] part_a5b5; 
    
    `MUL3X3 mul_a0b0(.a(a[2:0]), .b(b[2:0]), .o(part_a0b0)); 
    `MUL2X3 mul_a3b0(.a(a[4:3]), .b(b[2:0]), .o(part_a3b0)); 
    `MUL2X3 mul_a5b0(.a(a[6:5]), .b(b[2:0]), .o(part_a5b0)); 
    `MUL3X2 mul_a0b3(.a(a[2:0]), .b(b[4:3]), .o(part_a0b3)); 
    `MUL2X2 mul_a3b3(.a(a[4:3]), .b(b[4:3]), .o(part_a3b3)); 
    `MUL2X2 mul_a5b3(.a(a[6:5]), .b(b[4:3]), .o(part_a5b3)); 
    `MUL3X2 mul_a0b5(.a(a[2:0]), .b(b[6:5]), .o(part_a0b5)); 
    `MUL2X2 mul_a3b5(.a(a[4:3]), .b(b[6:5]), .o(part_a3b5)); 
    `MUL2X2 mul_a5b5(.a(a[6:5]), .b(b[6:5]), .o(part_a5b5)); 
    
    wire [13:0] partial_0 = {part_a5b5, part_a3b3, part_a0b0}; 
    wire [8:0]  partial_1 = {part_a5b3, part_a3b0}; 
    wire [8:0]  partial_2 = {part_a3b5, part_a0b3}; 
    wire [4:0]  partial_3 = part_a5b0; 
    wire [4:0]  partial_4 = part_a0b5; 
    
    wire [9:0]  toadd_0 = {1'b0, partial_1} + {1'b0, partial_2}; 
    wire [13:0] toadd_1 = partial_0 + {4'b0000, (b[7] == 0 ? part_a5b0 : part_a0b5), 5'b00000}; 
    wire [13:0] added   = toadd_1 + {1'b0, toadd_0, 3'b000}; 
    
    assign o = {2'b00, added}; 
    
endmodule
