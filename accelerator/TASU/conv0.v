//conv0 layer
`timescale 1ns/1ps
module conv0(
	input				clk,
	input				rst_n,
	
	input		[63:0]	idata,
	input				idata_empty,
	output				odata_rd,
	
	input		[127:0]	ipara,
	input				ipara_empty,
	output				opara_rd,
	
	output		[31:0]	odata,
	output				ovalid
);
	
	parameter			OUTPUT_NUM = 16;

	wire		[7:0]	data_ch0;
	wire		[7:0]	data_ch1;
	wire		[7:0]	data_ch2;
	wire				data_valid;
	
	wire		[7:0]	row_cnt;
	wire		[7:0]	col_cnt;
	wire				row_flag;
	
	wire				para_valid_ch0;
	wire				para_valid_ch1;
	wire				para_valid_ch2;
	
	wire		[7:0]	para_ch[OUTPUT_NUM - 1 : 0];
	
	wire				finish_flag[OUTPUT_NUM - 1 : 0];
	wire				over_flag;
	
	wire		[71:0]	result_map0[OUTPUT_NUM - 1 : 0];
	wire		[71:0]	result_map1[OUTPUT_NUM - 1 : 0];
	wire		[71:0]	result_map2[OUTPUT_NUM - 1 : 0];
	wire		[8:0]	result_valid[OUTPUT_NUM - 1 : 0];
	wire				wr_valid[OUTPUT_NUM - 1 : 0];
	
	wire		[1:0]	out_result[OUTPUT_NUM - 1 : 0];
	wire				out_valid[OUTPUT_NUM - 1 : 0];
	
	conv0_st conv0_st_inst(
		.clk				(clk),
		.rst_n				(rst_n),
		.idata				(idata),
		.idata_empty		(idata_empty),
		.odata_rd			(odata_rd),
		.ipara_empty		(ipara_empty),
		.opara_rd			(opara_rd),
		.odata_ch0			(data_ch0),
		.odata_ch1			(data_ch1),
		.odata_ch2			(data_ch2),
		.odata_valid		(data_valid),
		.orow_cnt			(row_cnt),
		.ocol_cnt			(col_cnt),
		.orow_flag			(row_flag),
		.opara_valid_ch0	(para_valid_ch0),
		.opara_valid_ch1	(para_valid_ch1),
		.opara_valid_ch2	(para_valid_ch2),
		.ifinish_flag		(finish_flag[0]),
		.oover_flag			(over_flag)
	);
	
	assign para_ch[0] = ipara[7:0];
	assign para_ch[1] = ipara[15:8];
	assign para_ch[2] = ipara[23:16];
	assign para_ch[3] = ipara[31:24];
	assign para_ch[4] = ipara[39:32];
	assign para_ch[5] = ipara[47:40];
	assign para_ch[6] = ipara[55:48];
	assign para_ch[7] = ipara[63:56];
	assign para_ch[8] = ipara[71:64];
	assign para_ch[9] = ipara[79:72];
	assign para_ch[10] = ipara[87:80];
	assign para_ch[11] = ipara[95:88];
	assign para_ch[12] = ipara[103:96];
	assign para_ch[13] = ipara[111:104];
	assign para_ch[14] = ipara[119:112];
	assign para_ch[15] = ipara[127:120];
	
	genvar ii;
	generate
	
		for(ii=0;ii<OUTPUT_NUM;ii=ii+1) begin:	conv0_ch0_function
			conv0_fu	conv0_fu_map0_inst(
				.clk				(clk),
				.rst_n				(rst_n),
				.idata				(data_ch0),
				.id_valid			(data_valid),
				.iweight			(para_ch[ii]),
				.iw_valid			(para_valid_ch0),
				.irow_cnt			(row_cnt),
				.icol_cnt			(col_cnt),
				.irow_flag			(row_flag),
				.ofinish_flag		(finish_flag[ii]),
				.odata				(result_map0[ii]),
				.owr_valid			(wr_valid[ii]),
				.oresult_valid		(result_valid[ii])
			);
			
			conv0_fu	conv0_fu_map1_inst(
				.clk				(clk),
				.rst_n				(rst_n),
				.idata				(data_ch1),
				.id_valid			(data_valid),
				.iweight			(para_ch[ii]),
				.iw_valid			(para_valid_ch1),
				.irow_cnt			(row_cnt),
				.icol_cnt			(col_cnt),
				.irow_flag			(row_flag),
				.ofinish_flag		(),
				.odata				(result_map1[ii]),
				.owr_valid			(),
				.oresult_valid		()
			);
			
			conv0_fu	conv0_fu_map2_inst(
				.clk				(clk),
				.rst_n				(rst_n),
				.idata				(data_ch2),
				.id_valid			(data_valid),
				.iweight			(para_ch[ii]),
				.iw_valid			(para_valid_ch2),
				.irow_cnt			(row_cnt),
				.icol_cnt			(col_cnt),
				.irow_flag			(row_flag),
				.ofinish_flag		(),
				.odata				(result_map2[ii]),
				.owr_valid			(),
				.oresult_valid		()
			);
			
			conv0_go	conv0_go_inst(
				.clk				(clk),
				.rst_n				(rst_n),
				
				.idata_map0			(result_map0[ii]),
				.idata_map1			(result_map1[ii]),
				.idata_map2			(result_map2[ii]),
				
				.itemp_valid		(wr_valid[ii]),
				.iresult_valid		(result_valid[ii]),
				.ifinish_flag		(finish_flag[ii]),
				
				.odata				(out_result[ii]),
				.ovalid				(out_valid[ii])
			);
		end
	
	endgenerate
	
	assign odata = {out_result[15],out_result[14],out_result[13],out_result[12],out_result[11],out_result[10],out_result[9],out_result[8],
					out_result[7],out_result[6],out_result[5],out_result[4],out_result[3],out_result[2],out_result[1],out_result[0]};
	assign ovalid = out_valid[0];
	
	// this is for debug
	reg        [19:0]          data_cnt;
	reg        [19:0]          result_cnt;
	always @(posedge clk)
	begin
	   if(!rst_n)
	       data_cnt <= 20'h0;
	   else if(data_valid)
	       data_cnt <= data_cnt + 1'b1;
	end
	
	always @(posedge clk)
	begin
	   if(!rst_n)
	       result_cnt <= 20'h0;
	   else if(wr_valid[0])
	       result_cnt <= result_cnt + 1'b1;
	end

endmodule	