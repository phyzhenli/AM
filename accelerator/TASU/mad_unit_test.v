`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2021 02:42:10 PM
// Design Name: 
// Module Name: mad_unit_test
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


module mad_unit_test(
    input CLK,  
    input [0 : 0] SEL, // 0: A*B; 1: A*B+P, do not use C
    input [7 : 0] A, 
    input [7 : 0] B, 
    input [23 : 0] C, 
    output reg [47 : 0] P
    );
    
    wire [15:0] O;

    // wallacetreev mul(.a1(A), .b1(B), .result(O));
    // multiplier_8x8 mul(.a(A), .b(B), .out(O));
    // SiEi6 mul(.x(A), .y(B), .z(O));
    // SiEi7 mul(.x(A), .y(B), .z(O));
    // Appro_multi mul(.a(A), .b(B), .result(O));
    // RoBA mul(.A(A), .B(B), .R(O));
    // date_2017 mul(.x(A), .y(B), .z(O));
    // optimal1 mul(.x(A), .y(B), .z(O));
    // optimal3 mul(.x(A), .y(B), .z(O));
    ubit8_designware mul(.a1(A), .b1(B), .result(O));
    
    always @(posedge CLK) begin
        if(SEL == 0) begin
            P <= O; 
        end else begin
            P <= P + O; 
        end
    end
    
endmodule
