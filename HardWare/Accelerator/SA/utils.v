module delay_1clk
#(parameter WIDTH = 8)
(
    input clk, 
    input rst_n, 
    input [WIDTH-1:0] x, 
    output reg [WIDTH-1:0] x_delayed
); 
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        x_delayed <= 0; 
    end else begin
        x_delayed <= x; 
    end
end
endmodule


module delay_1clk_okay
#(parameter WIDTH = 8)
(
    input clk, 
    input rst_n, 
    input okay, 
    input [WIDTH-1:0] x, 
    output reg [WIDTH-1:0] x_delayed
); 
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        x_delayed <= 0; 
    end else if (okay) begin
        x_delayed <= x; 
    end else begin
        x_delayed <= x_delayed; 
    end 
end
endmodule


module delay_Nclk_okay
#(parameter WIDTH = 8, N = 1)
(
    input clk, 
    input rst_n, 
    input okay, 
    input [WIDTH-1:0] x, 
    output [WIDTH-1:0] x_delayed
); 

wire [WIDTH-1:0] delays [N:0]; 

assign delays[0] = x; 

assign x_delayed = delays[N]; 

genvar idx; 
generate
    for (idx = 0; idx < N; idx=idx+1) begin : genIdx
        delay_1clk_okay #(.WIDTH(WIDTH)) tmp(clk, rst_n, okay, delays[idx], delays[idx+1]); 
    end
endgenerate


endmodule



