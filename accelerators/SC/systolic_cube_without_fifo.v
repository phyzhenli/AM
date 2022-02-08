module systolic_cube_without_fifo #(
    parameter ARRAY_NUM = 3,
    parameter BLOCK_NUM = 3,
    parameter CUBE_NUM  = 3, // dont change CUBE_NUM
    parameter RAM_DEPTH = 2048
) (
    input  wire                         iClk,
    input  wire                         iRst,
    input  wire                         iStart,
    output wire                         oReady,
    output wire [$clog2(RAM_DEPTH)-1:0] oAddrForDataWeightRam,
    input  wire [31:0]                  iDataFromDataRam,
    input  wire [31:0]                  iWeightFromWeightRam,
    output wire                         oWrEnForResultRam,
    output wire [$clog2(RAM_DEPTH)-1:0] oAddrForResultRam,
    output wire [31:0]                  oDataToResultRam
);

wire                                      clear_acc;
wire [ARRAY_NUM-2:0]                      pass_data_left;
wire [3*ARRAY_NUM-1:0]                    input_pattern;
wire [8*ARRAY_NUM*BLOCK_NUM*CUBE_NUM-1:0] result;
wire [ARRAY_NUM*BLOCK_NUM*CUBE_NUM-1:0]   result_valid;

wire                                    data_from_ram_valid;
wire [ARRAY_NUM*BLOCK_NUM*CUBE_NUM-1:0] result_fifo_empty;
wire [ARRAY_NUM*BLOCK_NUM*CUBE_NUM-1:0] result_fifo_rd_en;
wire [7:0] result_from_fifo [0:ARRAY_NUM*BLOCK_NUM*CUBE_NUM-1];
wire [2:0] result_fifo_sel;

assign oDataToResultRam = (result_fifo_sel == 'd0) ? {result_from_fifo[3], result_from_fifo[2], result_from_fifo[1], result_from_fifo[0]} :
                          (result_fifo_sel == 'd1) ? {result_from_fifo[7], result_from_fifo[6], result_from_fifo[5], result_from_fifo[4]} :
                          (result_fifo_sel == 'd2) ? {result_from_fifo[11], result_from_fifo[10], result_from_fifo[9], result_from_fifo[8]} :
                          (result_fifo_sel == 'd3) ? {result_from_fifo[15], result_from_fifo[14], result_from_fifo[13], result_from_fifo[12]} :
                          (result_fifo_sel == 'd4) ? {result_from_fifo[19], result_from_fifo[18], result_from_fifo[17], result_from_fifo[16]} :
                          (result_fifo_sel == 'd5) ? {result_from_fifo[23], result_from_fifo[22], result_from_fifo[21], result_from_fifo[20]} :
                          (result_fifo_sel == 'd6) ? {7'd0, result_from_fifo[26], result_from_fifo[25], result_from_fifo[24]} : 'd0;

generate
    genvar i;
    for (i = 0; i < ARRAY_NUM*BLOCK_NUM*CUBE_NUM; i = i + 1) begin :unname100
        FIFO result_fifo_i (
            .clock(iClk),
            .reset(iRst),
            .io_din(result[8*(i+1)-1:8*i]),
            .io_wr_en(result_valid[i]),
            .io_rd_en(result_fifo_rd_en[i]),
            .io_dout(result_from_fifo[i]),
            .io_empty(result_fifo_empty[i])
        );
    end
endgenerate

micro_controller #(
    .ARRAY_NUM(ARRAY_NUM),
    .BLOCK_NUM(BLOCK_NUM),
    .CUBE_NUM(CUBE_NUM),
    .RAM_DEPTH(RAM_DEPTH)
) micro_controller_i (
    .iClk(iClk),
    .iRst(iRst),
    .iStart(iStart),
    .oReady(oReady),
    .oClearAcc(clear_acc),
    .oInputPattern(input_pattern),
    .oPassDataLeft(pass_data_left),
    .oDataRdValid(data_from_ram_valid),
    .oAddrRd(oAddrForDataWeightRam),
    .iAllResultFifoHasData(~(|result_fifo_empty)),
    .oResultRdEn(result_fifo_rd_en),
    .oWriteEn(oWrEnForResultRam),
    .oAddrWr(oAddrForResultRam),
    .oResultFifoSel(result_fifo_sel)
);

pe_cube #(
    .ARRAY_NUM(ARRAY_NUM),
    .BLOCK_NUM(BLOCK_NUM),
    .CUBE_NUM(CUBE_NUM)
) pe_cube_i (
    .iClk(iClk),
    .iRst(iRst),
    .iClearAcc(clear_acc),
    .iWeight(data_from_ram_valid ? iWeightFromWeightRam[23:0] : 24'd0),
    .iData1(data_from_ram_valid ? iDataFromDataRam[23:0] : 24'd0),
    .iData2(data_from_ram_valid ? iDataFromDataRam[31:24] : 8'd0),
    .iCfsInputPattern(input_pattern),
    .iCfsPassDataLeft(pass_data_left),
    .iCfsOutputLeftShift(data_from_ram_valid ? iWeightFromWeightRam[28:24] : 5'd0),
    .oResult(result),
    .oResultValid(result_valid)
);

endmodule