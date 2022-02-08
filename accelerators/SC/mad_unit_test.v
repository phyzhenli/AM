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
    input iClk,  
    input iRst, 
    input [7 : 0] iData1, 
    input [7 : 0] iData2, 
    output reg [19 : 0] oResult
    );
    
    wire [15 : 0] o;
    
    ubit8_designware mul(.a1(iData1), .b1(iData2), .result(o));
    // wallacetreev mul(.a1(iData1), .b1(iData2), .result(o));
    // multiplier_8x8 mul(.a(iData1), .b(iData2), .out(o));
    // SiEi6 mul(.x(iData1), .y(iData2), .z(o));
    // SiEi7 mul(.x(iData1), .y(iData2), .z(o));
    // Appro_multi mul(.a(iData1), .b(iData2), .result(o));
    // RoBA mul(.A(iData1), .B(iData2), .R(o));
    // date_2017 mul(.x(iData1), .y(iData2), .z(o));
    // optimal1 mul(.x(iData1), .y(iData2), .z(o));
    // optimal3 mul(.x(iData1), .y(iData2), .z(o));

    
    always @(posedge iClk) begin
        if(iRst) begin
            oResult <= 0; 
        end else begin
            oResult <= {4'b0, o}; 
        end
    end
    
endmodule
