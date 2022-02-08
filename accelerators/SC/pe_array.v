module pe_array #(
  parameter ARRAY_NUM = 3
)(
  input  wire                    iClk,
  input  wire                    iRst,
  input  wire                    iClearAcc,
  input  wire [ARRAY_NUM-2:0]    iCfsPassDataLeft,
  input  wire [8*ARRAY_NUM-1:0]  iData,
  input  wire [7:0]              iWeight,
  input  wire [4:0]              iCfsOutputLeftShift,
  output wire [7:0]              oWeight,
  output reg  [8*ARRAY_NUM-1:0]  oResult,
  output wire                    oClearAcc,
  output wire [ARRAY_NUM-1:0]    oResultValid
);

reg  [7:0]  data_cache     [0:ARRAY_NUM-1];
reg  [7:0]  data_cache_dly [0:ARRAY_NUM-1];
wire [7:0]  data_to_pe     [0:ARRAY_NUM-1];
wire [7:0]  weight_to_pe   [0:ARRAY_NUM-1];
wire [7:0]  weight_from_pe [0:ARRAY_NUM-1];
wire [19:0] acc            [0:ARRAY_NUM-1];
wire        clear_acc_from_pe [0:ARRAY_NUM-1];
wire        clear_acc_to_pe   [0:ARRAY_NUM-1];

assign weight_to_pe[0] = iWeight;
assign oWeight = weight_from_pe[0];
assign clear_acc_to_pe[0] = iClearAcc;
assign oClearAcc = clear_acc_from_pe[0];
assign oResultValid[0] = clear_acc_from_pe[0];

always @(posedge iClk) begin
  if (iRst) begin
    data_cache[ARRAY_NUM-1] <= 'd0;
  end else begin
    data_cache[ARRAY_NUM-1] <= iData[(ARRAY_NUM)*8-1:(ARRAY_NUM-1)*8];
  end
end

generate
  genvar i;

  for (i = 1; i < ARRAY_NUM; i = i + 1) begin :unname1
    assign weight_to_pe[i] = weight_from_pe[i-1];
    assign oResultValid[i] = clear_acc_from_pe[i];
    assign clear_acc_to_pe[i] = clear_acc_from_pe[i-1];
  end

  for (i = 0; i < ARRAY_NUM; i = i + 1) begin : pe
    assign data_to_pe[i] = data_cache[i];
    pe pe_i(
      .iClk(iClk),
      .iRst(iRst),
      .iData(data_to_pe[i]),
      .iWeight(weight_to_pe[i]),
      .iClearAcc(clear_acc_to_pe[i]),
      .oWeight(weight_from_pe[i]),
      .oAcc(acc[i]),
      .oClearAcc(clear_acc_from_pe[i])
    );
  end

  for (i = 0; i < ARRAY_NUM; i = i + 1) begin :unname2
    always @(posedge iClk) begin
      if (iRst) begin
        data_cache_dly[i] <= 'd0;
      end else begin
        data_cache_dly[i] <= data_cache[i];
      end
    end
  end

  for (i = 0; i < ARRAY_NUM-1; i = i + 1) begin :unname3
    always @(posedge iClk) begin
      if (iRst) begin
        data_cache[i] <= 'd0; 
      end else begin
        if (iCfsPassDataLeft[i]) begin
          data_cache[i] <= data_cache_dly[i+1];
        end else begin
          data_cache[i] <= iData[(i+1)*8-1:i*8];
        end
      end
    end
  end

  for (i = 0; i < ARRAY_NUM; i = i + 1) begin :unname4
    always @(posedge iClk) begin
      if (iRst) begin
        oResult[(i+1)*8-1:i*8] <= 'd0;
      end else begin
        oResult[(i+1)*8-1:i*8] <= acc[i] >> iCfsOutputLeftShift;
      end
    end
  end

endgenerate

endmodule
