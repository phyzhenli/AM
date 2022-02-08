`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2021 06:20:50 PM
// Design Name: 
// Module Name: top
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


module top(
    input  [7:0]  a, 
    input  [7:0]  b, 
    input  clk, 
    input  rst, 
    output reg [15:0] o 
    );
    
    reg  [15:0] a_inner; 
    reg  [15:0] b_inner; 
    wire [15:0] o_inner; 
//    mul_top_normal mul(.a(a_inner), .b(b_inner), .o(o_inner)); 
//    mul_top_wierd_ref mul(.a(a_inner), .b(b_inner), .o(o_inner)); 
    mul_top_wierd mul(.a(a_inner), .b(b_inner), .o(o_inner)); 
//    mul_top_wierd_ref_nocode mul(.a(a_inner), .b(b_inner), .o(o_inner)); 
//    mul_top_wierd_nocode mul(.a(a_inner), .b(b_inner), .o(o_inner)); 
    
    always @(posedge clk) begin
        if(rst) begin
            a_inner <= 0; 
            b_inner <= 0; 
            o <= 0; 
        end else begin
            a_inner <= a; 
            b_inner <= b; 
            o <= o_inner; 
        end
    end
    
endmodule
