
module multiplier
#(parameter BUFFERSIZE=1)
(
    input clk, 
    input rst_n, 
    input okayX, 
    input okayY, 
    input okayGlobal, 
    input [7:0] varX, 
    input [7:0] varY, 
    output reg okayNextX, 
    output reg okayNextY, 
    output reg  [7:0] nextX, 
    output reg  [7:0] nextY, 
    output reg [31:0] accum, 
    output [31:0] mid_result, 
    output reg [31:0] result
); 

wire okay; 
wire [15:0] mul; 
wire [31:0] tmp_result; 

assign mid_result = tmp_result; 


// multiplier_8x8 _mul(.a(varX), .b(varY), .out(mul));
// RoBA _mul(.A(varX), .B(varY), .R(mul));
// SiEi6 _mul(.x(varX), .y(varY), .z(mul));
// SiEi7 _mul(.x(varX), .y(varY), .z(mul));
// Appro_multi _mul(.a(varX), .b(varY), .result(mul));
// optimal1 _mul(.x(varX), .y(varY), .z(mul));
// optimal3 _mul(.x(varX), .y(varY), .z(mul));
// wallacetreev _mul(.a1(varX), .b1(varY), .result(mul));
// SDLC _mul(.x(varX), .y(varY), .z(mul));
ubit8_designware _mul(.a1(varX), .b1(varY), .result(mul));

assign okay = okayX & okayY;

generate

    if (BUFFERSIZE > 0) begin: unname100
        
        delay_Nclk_okay #(.WIDTH(32), .N(BUFFERSIZE)) delay
        (
            .clk(clk), 
            .rst_n(rst_n), 
            .okay(okay), 
            .x(accum), 
            .x_delayed(tmp_result)
        ); 
        
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                okayNextX <= 1'b0; 
                okayNextY <= 1'b0; 
                nextX <= 8'b0; 
                nextY <= 8'b0; 
                accum <= 32'b0; 
                result <= 32'b0; 
            end else if (okay) begin
                okayNextX <= okayX; 
                okayNextY <= okayY; 
                nextX <= varX; 
                nextY <= varY; 
                if (okayGlobal) begin
                    result <= tmp_result; 
                    accum <= {16'b0, mul}; 
                end else begin
                    accum <= {16'b0, mul}; 
                end
            end else begin
                okayNextX <= okayX; 
                okayNextY <= okayY; 
                nextX <= varX; 
                nextY <= varY; 
                accum <= accum + {16'b0, mul}; 
                if (okayGlobal) begin
                    result <= tmp_result; 
                end
            end
        end

    end else begin
        
        delay_Nclk_okay #(.WIDTH(32), .N(1)) delay
        (
            .clk(clk), 
            .rst_n(rst_n), 
            .okay(okay), 
            .x(accum), 
            .x_delayed(tmp_result)
        ); 
        
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                okayNextX <= 1'b0; 
                okayNextY <= 1'b0; 
                nextX <= 8'b0; 
                nextY <= 8'b0; 
                accum <= 32'b0; 
                result <= 32'b0; 
            end else if (okay) begin
                okayNextX <= okayX; 
                okayNextY <= okayY; 
                nextX <= varX; 
                nextY <= varY; 
                result <= accum; 
                accum <= {16'b0, mul}; 
            end else begin
                okayNextX <= okayX; 
                okayNextY <= okayY; 
                nextX <= varX; 
                nextY <= varY; 
                accum <= accum + {16'b0, mul}; 
            end
        end
        
    end

endgenerate


endmodule
