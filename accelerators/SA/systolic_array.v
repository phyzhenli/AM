
module systolic_array
#(parameter HEIGHT = 16, WIDTH=16) // Ensure that HEIGHT == WIDTH !!!
(
    input clk, 
    input rst_n, 
    input en, 
    input [8*HEIGHT-1:0] varsX, 
    input [8*WIDTH-1 :0] varsY, 
    output okay, 
    output [32*HEIGHT*WIDTH-1:0] accums, 
    output [32*HEIGHT*WIDTH-1:0] mid_results, 
    output [32*HEIGHT*WIDTH-1:0] results
); 

wire [7:0] inputsX [HEIGHT:0] [WIDTH:0]; 
wire [7:0] inputsY [HEIGHT:0] [WIDTH:0]; 
wire [31:0] accums_internal [HEIGHT-1:0] [WIDTH-1:0]; 
wire [31:0] mid_results_internal [HEIGHT-1:0] [WIDTH-1:0]; 
wire [31:0] results_internal [HEIGHT-1:0] [WIDTH-1:0]; 

// Add delays for inputs

genvar x, xi; 

generate
    for (x = 0; x < HEIGHT; x=x+1) begin : genXs
        wire [7:0] delays [x+1:0]; 
        assign delays[0] = varsX[8*(x+1)-1:8*x]; 
        for (xi = 0; xi < x; xi=xi+1) begin : genXis
            delay_1clk tmp_delay(clk, rst_n, delays[xi], delays[xi+1]); 
        end
        assign inputsX[x][0] = delays[x]; 
    end
endgenerate

genvar y, yi; 

generate
    for (y = 0; y < HEIGHT; y=y+1) begin : genYs
        wire [7:0] delays [y+1:0]; 
        assign delays[0] = varsY[8*(y+1)-1:8*y]; 
        for (yi = 0; yi < y; yi=yi+1) begin : genYis
            delay_1clk tmp_delay(clk, rst_n, delays[yi], delays[yi+1]); 
        end
        assign inputsY[0][y] = delays[y]; 
    end
endgenerate

// Timing for okay

localparam PERIOD = 3 * HEIGHT - 3; 

reg preokay; 
reg [$clog2(PERIOD):0] counter_preokay; 

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        preokay <= 0; 
        counter_preokay <= 0; 
    end else if (counter_preokay == HEIGHT-1) begin
        preokay <= 1; 
        counter_preokay <= 0; 
    end else if (en) begin
        preokay <= 0; 
        counter_preokay <= counter_preokay + 1; 
    end else begin
        preokay <= 0; 
        counter_preokay <= 0; 
    end
end

// Add delays for okay signals 

wire okaysX [HEIGHT:0] [WIDTH:0]; 
wire okaysY [HEIGHT:0] [WIDTH:0]; 

genvar dx, dxi; 

generate
    for (dx = 0; dx < HEIGHT; dx=dx+1) begin : genDXs
        wire delays [dx+2:0]; 
        assign delays[0] = preokay; 
        for (dxi = 0; dxi < dx+1; dxi=dxi+1) begin : genDXis
            delay_1clk #(.WIDTH(1)) tmp_delay(clk, rst_n, delays[dxi], delays[dxi+1]); 
        end
        assign okaysX[dx][0] = delays[dx+1]; 
    end
endgenerate

genvar dy, dyi; 

generate
    for (dy = 0; dy < HEIGHT; dy=dy+1) begin : genDYs
        wire delays [dy+2:0]; 
        assign delays[0] = preokay; 
        for (dyi = 0; dyi < dy+1; dyi=dyi+1) begin : genDYis
            delay_1clk #(.WIDTH(1)) tmp_delay(clk, rst_n, delays[dyi], delays[dyi+1]); 
        end
        assign okaysY[0][dy] = delays[dy+1]; 
    end
endgenerate


wire okayGlobal; 
assign okayGlobal = okaysX[HEIGHT-1][WIDTH-1] & okaysY[HEIGHT-1][WIDTH-1]; 
assign okay = okayGlobal; 

// Construct the systolic array

genvar idx, jdx; 

generate
    for (idx = 0; idx < HEIGHT; idx=idx+1) begin : genRows
        for (jdx = 0; jdx < WIDTH; jdx=jdx+1) begin : genCols
            
            if (idx + jdx < 2) begin: unname102
                multiplier #(.BUFFERSIZE(2)) mul_ij(.clk(clk), .rst_n(rst_n), 
                                                      .okayX(okaysX[idx][jdx]), .okayY(okaysY[idx][jdx]), 
                                                      .okayGlobal(okayGlobal), 
                                                      .varX(inputsX[idx][jdx]), .varY(inputsY[idx][jdx]), 
                                                      .okayNextX(okaysX[idx][jdx+1]), .okayNextY(okaysY[idx+1][jdx]), 
                                                      .nextX(inputsX[idx][jdx+1]), .nextY(inputsY[idx+1][jdx]), 
                                                      .accum(accums_internal[idx][jdx]), 
                                                      .mid_result(mid_results_internal[idx][jdx]), 
                                                      .result(results_internal[idx][jdx])); 
            end else if (idx + jdx < 2 * HEIGHT - 2) begin: uname101
                multiplier #(.BUFFERSIZE(1)) mul_ij(.clk(clk), .rst_n(rst_n), 
                                                      .okayX(okaysX[idx][jdx]), .okayY(okaysY[idx][jdx]), 
                                                      .okayGlobal(okayGlobal), 
                                                      .varX(inputsX[idx][jdx]), .varY(inputsY[idx][jdx]), 
                                                      .okayNextX(okaysX[idx][jdx+1]), .okayNextY(okaysY[idx+1][jdx]), 
                                                      .nextX(inputsX[idx][jdx+1]), .nextY(inputsY[idx+1][jdx]), 
                                                      .accum(accums_internal[idx][jdx]), 
                                                      .mid_result(mid_results_internal[idx][jdx]), 
                                                      .result(results_internal[idx][jdx])); 
            end else begin
                multiplier #(.BUFFERSIZE(0)) mul_ij(.clk(clk), .rst_n(rst_n), 
                                                      .okayX(okaysX[idx][jdx]), .okayY(okaysY[idx][jdx]), 
                                                      .okayGlobal(okayGlobal), 
                                                      .varX(inputsX[idx][jdx]), .varY(inputsY[idx][jdx]), 
                                                      .okayNextX(okaysX[idx][jdx+1]), .okayNextY(okaysY[idx+1][jdx]), 
                                                      .nextX(inputsX[idx][jdx+1]), .nextY(inputsY[idx+1][jdx]), 
                                                      .accum(accums_internal[idx][jdx]), 
                                                      .mid_result(mid_results_internal[idx][jdx]), 
                                                      .result(results_internal[idx][jdx])); 
            end
            
            
            assign accums[32*(idx*WIDTH+jdx+1)-1:32*(idx*WIDTH+jdx)] = accums_internal[idx][jdx]; 
            assign mid_results[32*(idx*WIDTH+jdx+1)-1:32*(idx*WIDTH+jdx)] = mid_results_internal[idx][jdx]; 
            assign results[32*(idx*WIDTH+jdx+1)-1:32*(idx*WIDTH+jdx)] = results_internal[idx][jdx]; 
        end
    end
endgenerate



endmodule
