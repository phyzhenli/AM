//conv0 layer generate output feature map
module conv0_go(
	input					clk,
	input					rst_n,
	
	input		[71:0]		idata_map0,
	input		[71:0]		idata_map1,
	input		[71:0]		idata_map2,
	
	input					itemp_valid,
	input		[8:0]		iresult_valid,
	input					ifinish_flag,
	
	output	reg	[1:0]		odata,
	output	reg				ovalid
);

	parameter				REF_VALUE0 = 16'd21;			// 128/6=21
	parameter				REF_VALUE1 = 16'd64;			// 128/2=64
	parameter				REF_VALUE2 = 16'd107;			// 128*5/6=107
	reg			[23:0]		data_sum1[2:0];
	reg			[23:0]		data_sum2[2:0];
	reg			[23:0]		temp_in[2:0];
	wire		[23:0]		temp_out[2:0];
	reg			[8:0]		go_valid[2:0];
	
	reg			[1:0]		wr_en_r;
	reg						wr_en;
	wire		[71:0]		data_temp_in;
	wire					rd_en;
	wire		[71:0]		data_temp_out;
	wire					full;
	wire					empty;
	wire		[5:0]		data_count;
	reg						rd_flag;
	reg			[3:0]		finish_flag_delay;
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			wr_en <= 1'b0;
			wr_en_r <= 2'b00;
			data_sum1[0] <= 24'h0;
			data_sum1[1] <= 24'h0;
			data_sum1[2] <= 24'h0;
			data_sum2[0] <= 24'h0;
			data_sum2[1] <= 24'h0;
			data_sum2[2] <= 24'h0;
		end
		else begin
			wr_en_r <= {wr_en_r[0],itemp_valid};
			wr_en <= wr_en_r[1];
			if(wr_en_r[0] | go_valid[0]) begin
				data_sum1[2] <= idata_map0[71:48] + idata_map1[71:48];
				data_sum2[2] <= temp_out[2] + idata_map2[71:48];
				data_sum1[1] <= idata_map0[47:24] + idata_map1[47:24];
				data_sum2[1] <= temp_out[1] + idata_map2[47:24];
				data_sum1[0] <= idata_map0[23:0] + idata_map1[23:0];
				data_sum2[0] <= temp_out[0] + idata_map2[23:0];
			end
		end
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			temp_in[0] <= 24'h0;
			temp_in[1] <= 24'h0;
			temp_in[2] <= 24'h0;
			go_valid[0] <= 9'h0;
			go_valid[1] <= 9'h0;
			go_valid[2] <= 9'h0;
		end
		else begin
			go_valid[0] <= iresult_valid;
			go_valid[1] <= go_valid[0];
			go_valid[2] <= go_valid[1];
			if(wr_en_r[1] | go_valid[1]) begin
				temp_in[0] <= data_sum1[0] + data_sum2[0];
				temp_in[1] <= data_sum1[1] + data_sum2[1];
				temp_in[2] <= data_sum1[2] + data_sum2[2];
			end
		end
	end
	assign data_temp_in[23:0] = (go_valid[2][0] | go_valid[2][1] | go_valid[2][2]) ? 24'h0 : temp_in[0];
	assign data_temp_in[47:24] = (go_valid[2][3] | go_valid[2][4] | go_valid[2][5]) ? 24'h0 : temp_in[1];
	assign data_temp_in[71:48] = (go_valid[2][6] | go_valid[2][7] | go_valid[2][8]) ? 24'h0 : temp_in[2];
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			finish_flag_delay <= 4'h0;
			rd_flag <= 1'b0;
		end
		else begin
			finish_flag_delay <= {finish_flag_delay[2:0],ifinish_flag};
			if(data_count == 6'd54)
				rd_flag <= 1'b1;
			else if(finish_flag_delay[3])
				rd_flag <= 1'b0;
		end
	end
	assign rd_en = (itemp_valid | (|iresult_valid)) & rd_flag;
	
	conv0_temp_buf conv0_temp_buf_inst (
  		.clk(clk),                // input wire clk
  		.rst(!rst_n),                // input wire rst
  		.din(data_temp_in),                // input wire [71 : 0] din
  		.wr_en(wr_en),            // input wire wr_en
  		.rd_en(rd_en),            // input wire rd_en
  		.dout(data_temp_out),              // output wire [71 : 0] dout
  		.full(full),              // output wire full
  		.empty(empty),            // output wire empty
  		.data_count(data_count)  // output wire [5 : 0] data_count
	);
	assign temp_out[0] = rd_flag ? data_temp_out[23:0] : 24'h0;
	assign temp_out[1] = rd_flag ? data_temp_out[47:24] : 24'h0;
	assign temp_out[2] = rd_flag ? data_temp_out[71:48] : 24'h0;
			
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			odata <= 2'b00;
			ovalid <= 1'b0;
		end
		else begin
			ovalid <= |go_valid[2];
			case({(go_valid[2][8] | go_valid[2][7] | go_valid[2][6]),(go_valid[2][5] | go_valid[2][4] | go_valid[2][3]),(go_valid[2][2] | go_valid[2][1] | go_valid[2][0])})
				3'b001:		begin
								if(temp_in[0][23] || (temp_in[0][23:7] < REF_VALUE0))							//multiplication cause point drifting, so divided by 128
									odata <= 2'b00;
								else if(temp_in[0][23:7] < REF_VALUE1)
									odata <= 2'b01;
								else if(temp_in[0][23:7] < REF_VALUE2)
									odata <= 2'b10;
								else
									odata <= 2'b11;
							end
				3'b010:		begin
								if(temp_in[1][23] || (temp_in[1][23:7] < REF_VALUE0))							//multiplication cause point drifting, so divided by 128
									odata <= 2'b00;
								else if(temp_in[1][23:7] < REF_VALUE1)
									odata <= 2'b01;
								else if(temp_in[1][23:7] < REF_VALUE2)
									odata <= 2'b10;
								else
									odata <= 2'b11;
							end
				3'b100:		begin
								if(temp_in[2][23] || (temp_in[2][23:7] < REF_VALUE0))							//multiplication cause point drifting, so divided by 128
									odata <= 2'b00;
								else if(temp_in[2][23:7] < REF_VALUE1)
									odata <= 2'b01;
								else if(temp_in[2][23:7] < REF_VALUE2)
									odata <= 2'b10;
								else
									odata <= 2'b11;
							end
			endcase
		end
	end

endmodule