module pe_block #(
  parameter ARRAY_NUM = 3,
  parameter BLOCK_NUM = 3
)(
  input  wire                    iClk,
  input  wire                    iRst,
  input  wire                    iClearAcc,
  input  wire [8*ARRAY_NUM*BLOCK_NUM-1:0] iData,
  input  wire [7:0]              iWeight,
  input  wire [ARRAY_NUM-2:0]    iCfsPassDataLeft,
  input  wire [4:0]              iCfsOutputLeftShift,
  output wire [8*ARRAY_NUM*BLOCK_NUM-1:0] oResult,
  output wire [ARRAY_NUM*BLOCK_NUM-1:0] oResultValid
);

wire [7:0] weight_to_pe_block   [0:BLOCK_NUM-1];
wire [7:0] weight_from_pe_block [0:BLOCK_NUM-1];
reg  [ARRAY_NUM-2:0]   cfs_pass_data_left_dly [0:BLOCK_NUM-2];

wire       clear_acc_to_pe_block   [0:BLOCK_NUM-1];
wire       clear_acc_from_pe_block [0:BLOCK_NUM-1];

assign weight_to_pe_block[0] = iWeight;
assign clear_acc_to_pe_block[0] = iClearAcc;

always @(posedge iClk) begin
  if (iRst) begin
    cfs_pass_data_left_dly[0] <= 'd0;
  end else begin
    cfs_pass_data_left_dly[0] <= iCfsPassDataLeft;
  end
end

pe_array #(
  .ARRAY_NUM(ARRAY_NUM)
) pe_array_first (
  .iClk(iClk),
  .iRst(iRst),
  .iClearAcc(clear_acc_to_pe_block[0]),
  .iCfsPassDataLeft(iCfsPassDataLeft),
  .iData(iData[8*ARRAY_NUM-1:0]),
  .iWeight(weight_to_pe_block[0]),
  .iCfsOutputLeftShift(iCfsOutputLeftShift),
  .oWeight(weight_from_pe_block[0]),
  .oResult(oResult[8*ARRAY_NUM-1:0]),
  .oClearAcc(clear_acc_from_pe_block[0]),
  .oResultValid(oResultValid[ARRAY_NUM-1:0])
);

generate
  genvar i;

  for (i = 1; i < BLOCK_NUM-1; i = i + 1) begin :unname11
    always @(posedge iClk) begin
      if (iRst) begin
        cfs_pass_data_left_dly[i] <= 'd0;
      end else begin
        cfs_pass_data_left_dly[i] <= cfs_pass_data_left_dly[i-1];
      end
    end
  end

  for (i = 1; i < BLOCK_NUM; i = i + 1) begin :unname12
    assign weight_to_pe_block[i] = weight_from_pe_block[i-1];
    assign clear_acc_to_pe_block[i] = clear_acc_from_pe_block[i-1];
  end

  for (i = 1; i < BLOCK_NUM; i = i + 1) begin :unname13
    pe_array #(
      .ARRAY_NUM(ARRAY_NUM)
    ) pe_array_i (
      .iClk(iClk),
      .iRst(iRst),
      .iClearAcc(clear_acc_to_pe_block[i]),
      .iCfsPassDataLeft(cfs_pass_data_left_dly[i-1]),
      .iData(iData[8*ARRAY_NUM*(i+1)-1:8*ARRAY_NUM*i]),
      .iWeight(weight_to_pe_block[i]),
      .iCfsOutputLeftShift(iCfsOutputLeftShift),
      .oWeight(weight_from_pe_block[i]),
      .oResult(oResult[8*ARRAY_NUM*(i+1)-1:8*ARRAY_NUM*i]),
      .oClearAcc(clear_acc_from_pe_block[i]),
      .oResultValid(oResultValid[ARRAY_NUM*(i+1)-1:ARRAY_NUM*i])
    );
  end
endgenerate

endmodule