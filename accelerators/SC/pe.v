module pe (
  input  wire        iClk,
  input  wire        iRst,
  input  wire [7:0]  iData,
  input  wire [7:0]  iWeight,
  input  wire        iClearAcc,
  output reg  [7:0]  oWeight,
  output reg  [19:0] oAcc,
  output reg         oClearAcc
);

wire [19:0] result;

always @(posedge iClk) begin
  if (iRst) begin
    oClearAcc <= 'd0;
  end else begin
    oClearAcc <= iClearAcc;
  end
end

always @(posedge iClk) begin
  if (iRst) begin
    oWeight <= 'd0;
  end else begin
    oWeight <= iWeight;
  end
end

always @(posedge iClk) begin
  if (iRst) begin
    oAcc <= 'd0;
  end else if (iClearAcc) begin
    oAcc <= 'd0;
  end else begin
    oAcc <= oAcc + result;
  end
end

//appr_mult appr_mult_i(
//  .iClk(iClk),
//  .iRst(iRst),
//  .iData1(iData),
//  .iData2(oWeight),
//  .oResult(result)
//);

mad_unit_test mul_i(
  .iClk(iClk),
  .iRst(iRst),
  .iData1(iData),
  .iData2(oWeight),
  .oResult(result)
);

endmodule
