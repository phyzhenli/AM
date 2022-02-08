`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2021 11:45:59 AM
// Design Name: 
// Module Name: basic_modules
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


module mul_2x2(
    input  [1:0] a, 
    input  [1:0] b, 
    output [3:0] o 
    );
    
    wire and_a0b0 = a[0] & b[0]; 
    wire and_a0b1 = a[0] & b[1]; 
    wire and_a1b0 = a[1] & b[0]; 
    wire and_a1b1 = a[1] & b[1]; 
    wire and_a0b1a1b0 = and_a0b1 & and_a1b0; 
    
    assign o[0] = and_a0b0; 
    assign o[1] = and_a0b1 ^ and_a1b0; 
    assign o[2] = and_a0b1a1b0 ^ and_a1b1; 
    assign o[3] = and_a0b1a1b0 & and_a1b1; 
    
endmodule


module mul_2x2_kmap(
    input  [1:0] a, 
    input  [1:0] b, 
    output [3:0] o 
    );
    
    wire and_a0b0 = a[0] & b[0]; 
    wire and_a0b1 = a[0] & b[1]; 
    wire and_a1b0 = a[1] & b[0]; 
    wire and_a1b1 = a[1] & b[1]; 
    wire and_a0b1a1b0 = and_a0b1 & and_a1b0; 
    
    assign o[0] = and_a0b0; 
    assign o[1] = and_a0b1 | and_a1b0; 
    assign o[2] = and_a1b1; 
    assign o[3] = 1'b0; 
    
endmodule


module full_adder(
    input  a, 
    input  b, 
    input  cin, 
    output o, 
    output cout
    );
    
    wire xor_ab = a ^ b;  
    assign o = xor_ab ^ cin; 
    assign cout = (a & b) | (xor_ab & cin); 
    
endmodule


module mul_3x3(
    input  [2:0] a, 
    input  [2:0] b, 
    output [5:0] o 
    );
    
    assign o = {3'b000, a} * {3'b000, b}; 
    
endmodule


module mul_2x3(
    input  [1:0] a, 
    input  [2:0] b, 
    output [4:0] o 
    );
    
    assign o = {3'b000, a} * {2'b00, b}; 
    
endmodule


module mul_3x2(
    input  [2:0] a, 
    input  [1:0] b, 
    output [4:0] o 
    );
    
    assign o = {2'b00, a} * {3'b000, b}; 
    
endmodule


module true2comple_8(
    input  [7:0] a, 
    output [7:0] o 
    );
    
    assign o = a[7] == 0 ? a : ({1'b0, (~a[6:0])} + 1); 
    
endmodule


module true2comple_16(
    input  [15:0] a, 
    output [15:0] o 
    );
    
    assign o = a[15] == 0 ? a : ({1'b0, (~a[14:0])} + 1); 
    
endmodule


module comple2true_8(
    input  [7:0] a, 
    output [7:0] o 
    );
    
    wire [7:0] tmp = ~(a - 1); 
    assign o = a[7] == 0 ? a : {1'b1, tmp[6:0]}; 
    
endmodule


module comple2true_16(
    input  [15:0] a, 
    output [15:0] o 
    );
    
    wire [15:0] tmp = ~(a - 1); 
    assign o = a[15] == 0 ? a : {1'b1, tmp[14:0]}; 
    
endmodule

