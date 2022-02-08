//conv0 layer base functional unit
//no padding
`timescale 1ns/1ps
module conv0_fu(
	input					clk,
	input					rst_n,
	input		[7:0]		idata,
	input					id_valid,
	input		[7:0]		iweight,
	input					iw_valid,
	input		[7:0]		irow_cnt,
	input		[7:0]		icol_cnt,
	
	input					irow_flag,			//signal indicate a new row
	output	reg				ofinish_flag,		//finish a cycle of calc
	output	reg	[71:0]		odata,
	output	reg				owr_valid,				//temp result
	output	reg	[8:0]		oresult_valid
	);
	
	parameter				KERNEL_NUM_ROW = 3;
	parameter				KERNEL_NUM_COL = 3;
	parameter				KERNEL_NUM = KERNEL_NUM_ROW * KERNEL_NUM_COL;
	parameter				KERNEL_SIZE = 12;
	
	//state machine parameter
	parameter				SIDLE = 2'b00;
	parameter				SSTART = 2'b01;
	parameter				SACCU = 2'b10;
	parameter				SLAST = 2'b11;
	
	reg			[7:0]		data_r[KERNEL_NUM-1:0];
	reg			[7:0]		weight_buf;
	reg						iw_valid_delay = 1'b0;
	reg			[7:0]		weight_store[KERNEL_SIZE * KERNEL_SIZE - 1:0];
	reg			[7:0]		weight_wr_addr;
	wire		[7:0]		weight_rd_addr[KERNEL_NUM - 1:0];
	wire		[47:0]		P[KERNEL_NUM - 1:0];
	
	wire		[23:0]		kernel_temp[KERNEL_NUM - 1:0];
	reg						mode_sel[KERNEL_NUM - 1:0];
	reg			[7:0]		weight_in[KERNEL_NUM - 1:0];
	
	reg			[3:0]		row_addr[KERNEL_NUM_ROW - 1:0];
	reg			[3:0]		col_addr[KERNEL_NUM_COL - 1:0];
	
	reg			[1:0]		row_cur_state[KERNEL_NUM_ROW - 1:0];
	reg			[1:0]		row_nxt_state[KERNEL_NUM_ROW - 1:0];
	reg			[1:0]		col_cur_state[KERNEL_NUM_COL - 1:0];
	reg			[1:0]		col_nxt_state[KERNEL_NUM_COL - 1:0];
	wire					row_valid_flag[KERNEL_NUM_ROW - 1:0];
//	wire					row_repeat_flag[KERNEL_NUM_ROW - 1:0];
	wire					row_end_flag[KERNEL_NUM_ROW - 1:0];
	reg						row_end_flag_exp;											//as the third kernel has a row_cnt input of 223, but the same time as last state
	wire					row_last_flag[KERNEL_NUM_ROW - 1:0];
	wire					col_valid_flag[KERNEL_NUM_COL - 1:0];
//	wire					col_repeat_flag[KERNEL_NUM_COL - 1:0];
	wire					col_end_flag[KERNEL_NUM_COL - 1:0];
	wire					col_last_flag[KERNEL_NUM_COL - 1:0];
	reg						col_end_flag_exp;
	integer					i,j,k;
	
	reg			[2:0]			wr_en_r;
	reg			[2:0]			wr_en_delay;
	reg			[2:0]			wr_en_delay1;
	
	reg			[2:0]			col_wr_valid;
	reg			[2:0]			wr_valid_delay;
	reg			[2:0]			wr_valid_delay1;
	
	reg			[8:0]			result_valid_temp;
	reg			[8:0]			result_valid_delay;
	reg			[8:0]			result_valid_delay1;
	reg			[8:0]			result_valid_delay2;
	
	reg							last_line_flag;	
	reg			[3:0]			finish_delay;				//delay flag to generate finish flag at proper time
	
	//delay a cycle for input data
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			data_r[0] <= 8'h0;
			data_r[1] <= 8'h0;
			data_r[2] <= 8'h0;
			data_r[3] <= 8'h0;
			data_r[4] <= 8'h0;
			data_r[5] <= 8'h0;
			data_r[6] <= 8'h0;
			data_r[7] <= 8'h0;
			data_r[8] <= 8'h0;
			weight_buf <= 8'h0;
		end
		else begin
			data_r[0] <= idata;
			data_r[1] <= idata;
			data_r[2] <= idata;
			data_r[3] <= idata;
			data_r[4] <= idata;
			data_r[5] <= idata;
			data_r[6] <= idata;
			data_r[7] <= idata;
			data_r[8] <= idata;
			weight_buf <= iweight;
		end
	end
	
	always @(posedge clk)
		iw_valid_delay <= iw_valid;
	
	//buffer weight
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			weight_wr_addr <= 8'h0;
		else if(iw_valid_delay) begin
			if(weight_wr_addr == KERNEL_SIZE * KERNEL_SIZE - 1)
				weight_wr_addr <= 8'h0;
			else
				weight_wr_addr <= weight_wr_addr + 1'b1;
		end
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			for(k=0;k<KERNEL_SIZE * KERNEL_SIZE;k=k+1)
				weight_store[k] <= 8'h0;
		else begin
			if(iw_valid_delay)
				weight_store[weight_wr_addr] <= weight_buf;
		end
	end
	
	//transfer condition for state machines
	assign row_valid_flag[0] = id_valid & (irow_cnt < 8'd216);
	assign row_valid_flag[1] = id_valid & (irow_cnt < 8'd220) & (irow_cnt > 8'd3);
	assign row_valid_flag[2] = id_valid & (irow_cnt > 8'd7);
	assign row_end_flag[0] = id_valid & (irow_cnt >= 8'd216);
	assign row_end_flag[1] = id_valid & (irow_cnt >= 8'd220);
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			row_end_flag_exp <= 1'b0;
		else if(id_valid & (irow_cnt == 8'd223))
			row_end_flag_exp <= 1'b1;
		else
			row_end_flag_exp <= 1'b0;
	end
	assign row_end_flag[2] = row_end_flag_exp;
			
	//row state machine
	genvar ii;
	generate
	
		for(ii=0;ii<KERNEL_NUM_ROW;ii=ii+1)
		begin: row_state_machine_inst
			always @(posedge clk or negedge rst_n)
			begin
				if(!rst_n)
					row_cur_state[ii] <= SIDLE;
				else
					row_cur_state[ii] <= row_nxt_state[ii];
			end
		
			always @(*)
			begin
				row_nxt_state[ii] <= SIDLE;
				case(row_cur_state[ii])
					SIDLE:		if(row_valid_flag[ii])
									row_nxt_state[ii] <= SSTART;
								else
									row_nxt_state[ii] <= SIDLE;
					SSTART:		if(row_valid_flag[ii])
									row_nxt_state[ii] <= SACCU;
								else
									row_nxt_state[ii] <= SSTART;
					SACCU:		if(row_last_flag[ii])
									row_nxt_state[ii] <= SLAST;
								else
									row_nxt_state[ii] <= SACCU;
					SLAST:		if(row_end_flag[ii])
									row_nxt_state[ii] <= SIDLE;
								else if(row_valid_flag[ii])
									row_nxt_state[ii] <= SSTART;
								else
									row_nxt_state[ii] <= SLAST;
					default:	row_nxt_state[ii] <= SIDLE;
				endcase
			end
			
			//generate 2D address of feature in kernel
			always @(posedge clk or negedge rst_n)
			begin
				if(!rst_n)
					row_addr[ii] <= 4'h0;
				else begin
					if(row_valid_flag[ii]) begin
						if(row_nxt_state[ii] == SLAST)
							row_addr[ii] <= 4'h0;
						else if((row_nxt_state[ii] == SACCU) || (row_nxt_state[ii] == SSTART))
							row_addr[ii] <= row_addr[ii] + 1'b1;
					end
				end
			end
			
//			assign row_repeat_flag[ii] = id_valid && (row_addr[ii] == 4'd0);
			assign row_last_flag[ii] = id_valid && (row_addr[ii] == 4'd11);	 
		end
	
	endgenerate
	
	//transfer condition for state machines
	assign col_valid_flag[0] = irow_flag & (icol_cnt < 8'd216);
	assign col_valid_flag[1] = irow_flag & (icol_cnt < 8'd220) & (icol_cnt > 8'd3);
	assign col_valid_flag[2] = irow_flag & (icol_cnt > 8'd7);
	assign col_end_flag[0] = irow_flag & (icol_cnt >= 8'd216);
	assign col_end_flag[1] = irow_flag & (icol_cnt >= 8'd220);
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			col_end_flag_exp <= 1'b0;
		else
			col_end_flag_exp <= id_valid & (irow_cnt == 8'd223) & (icol_cnt == 8'd223);
	end
	assign col_end_flag[2] = col_end_flag_exp;
			
	//col state machine
	genvar jj;
	generate
	
		for(jj=0;jj<KERNEL_NUM_COL;jj=jj+1)
		begin: unname100
			always @(posedge clk or negedge rst_n)
			begin: col_state_machine_inst
				if(!rst_n)
					col_cur_state[jj] <= SIDLE;
				else
					col_cur_state[jj] <= col_nxt_state[jj];
			end
		
			always @(*)
			begin
				col_nxt_state[jj] <= SIDLE;
				case(col_cur_state[jj])
					SIDLE:		if(col_valid_flag[jj])
									col_nxt_state[jj] <= SSTART;
								else
									col_nxt_state[jj] <= SIDLE;
					SSTART:		if(col_valid_flag[jj])
									col_nxt_state[jj] <= SACCU;
								else
									col_nxt_state[jj] <= SSTART;
					SACCU:		if(col_last_flag[jj])
									col_nxt_state[jj] <= SLAST;
								else
									col_nxt_state[jj] <= SACCU;
					SLAST:		if(col_end_flag[jj])
									col_nxt_state[jj] <= SIDLE;
								else if(col_valid_flag[jj])
									col_nxt_state[jj] <= SSTART;
								else
									col_nxt_state[jj] <= SLAST;
					default:	col_nxt_state[jj] <= SIDLE;
				endcase
			end
			
			//generate 2D address of feature in kernel
			always @(posedge clk or negedge rst_n)
			begin
				if(!rst_n)
					col_addr[jj] <= 4'h0;
				else begin
					if(id_valid && (irow_cnt == 8'd223)) begin
						if(col_nxt_state[jj] == SLAST)
							col_addr[jj] <= 4'h0;
						else if((col_nxt_state[jj] == SACCU) || (col_nxt_state[jj] == SSTART))
							col_addr[jj] <= col_addr[jj] + 1'b1;
					end
				end
			end
			
//			assign col_repeat_flag[jj] = irow_flag && (col_addr[jj] == 4'd0);	 
			assign col_last_flag[jj] = irow_flag && (col_addr[jj] == 4'd11);	
		end
	
	endgenerate
	
	//generate weight read address
	assign weight_rd_addr[0] = col_addr[0] * 4'd12 + row_addr[0];
	assign weight_rd_addr[1] = col_addr[0] * 4'd12 + row_addr[1];
	assign weight_rd_addr[2] = col_addr[0] * 4'd12 + row_addr[2];
	assign weight_rd_addr[3] = col_addr[1] * 4'd12 + row_addr[0];
	assign weight_rd_addr[4] = col_addr[1] * 4'd12 + row_addr[1];
	assign weight_rd_addr[5] = col_addr[1] * 4'd12 + row_addr[2];
	assign weight_rd_addr[6] = col_addr[2] * 4'd12 + row_addr[0];
	assign weight_rd_addr[7] = col_addr[2] * 4'd12 + row_addr[1];
	assign weight_rd_addr[8] = col_addr[2] * 4'd12 + row_addr[2];
	
	//feed feature and weight into kernel
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			for(i=0;i<KERNEL_NUM;i=i+1)
				weight_in[i] <= 8'h0;
		else begin
			if(id_valid)
				for(i=0;i<KERNEL_NUM;i=i+1)
					weight_in[i] <= weight_store[weight_rd_addr[i]];
			else
			    for(i=0;i<KERNEL_NUM;i=i+1)
				    weight_in[i] <= 8'h0;
		end
	end
	
	//select mode of accu
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			for(i=0;i<KERNEL_NUM;i=i+1)
				mode_sel[i] <= 1'b0;
		else begin
			for(i=0;i<KERNEL_NUM_ROW;i=i+1)
				for(j=0;j<KERNEL_NUM_COL;j=j+1)
					if(((row_nxt_state[i] == SACCU) || (row_nxt_state[i] == SLAST)) && (col_nxt_state[j] != SIDLE))
						mode_sel[j * KERNEL_NUM_ROW + i] <= 1'b1;
					else
						mode_sel[j * KERNEL_NUM_ROW + i] <= 1'b0;
		end
	end
	
	genvar nn;
	generate
	
		for(nn=0;nn<KERNEL_NUM;nn=nn+1)
		begin: conv0_kernel_calc
//			conv0_kernel conv0_kernel_inst (
//  				.CLK(clk),  // input wire CLK
//  				.SEL(mode_sel[nn]),  // input wire [0 : 0] SEL				// 0��A*B+C; 1: A*B+P
//  				.A(data_r[nn]),      // input wire [7 : 0] A
//  				.B(weight_in[nn]),      // input wire [7 : 0] B
//  				.C(24'h0),      // input wire [23 : 0] C
//  				.P(P[nn])      // output wire [47 : 0] P
//			);
			//TODO
			mad_unit_test conv0_kernel_inst (
  				.CLK(clk),  // input wire CLK
  				.SEL(mode_sel[nn]),  // input wire [0 : 0] SEL				// 0��A*B+C; 1: A*B+P
  				.A(data_r[nn]),      // input wire [7 : 0] A
  				.B(weight_in[nn]),      // input wire [7 : 0] B
  				.C(24'h0),      // input wire [23 : 0] C
  				.P(P[nn])      // output wire [47 : 0] P
			);
			assign kernel_temp[nn] = P[nn][23:0];
		end
	
	endgenerate
	
	//buffer row calc results
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			last_line_flag <= 1'b0;
		else
			last_line_flag <= (icol_cnt == 8'd223);
	end
	
	//generate wr_en signal to write result of row into fifo, as dsp has 2 cycles delay, so delay two cycles to get right result
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			wr_en_r <= 3'h0;
			wr_en_delay <= 3'h0;
			wr_en_delay1 <= 3'h0;
			owr_valid <= 1'b0;
			col_wr_valid <= 3'b000;
			wr_valid_delay <= 3'b000;
			wr_valid_delay1 <= 3'b000;
		end
		else begin
			wr_en_r <= {(row_cur_state[2] == SLAST) & (!last_line_flag),
						(row_cur_state[1] == SLAST) & (!last_line_flag),
						(row_cur_state[0] == SLAST) & (!last_line_flag)};
			wr_en_delay <= wr_en_r;
			wr_en_delay1 <= wr_en_delay;
			col_wr_valid <= {(col_cur_state[2] != SIDLE),(col_cur_state[1] != SIDLE),(col_cur_state[0] != SIDLE)};
			wr_valid_delay <= col_wr_valid;
			wr_valid_delay1 <= wr_valid_delay;
			owr_valid <= |wr_en_delay1;
		end
	end
	
	//3 rows has temp result come at the same time, combine them to a 48 bits
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			odata <= 72'h0;
		else begin
			if(wr_en_delay1[0] | result_valid_delay2[0] | result_valid_delay2[3] | result_valid_delay2[6]) begin
				odata[23:0] <= wr_valid_delay1[0] ? kernel_temp[0] : 24'h0;
				odata[47:24] <= wr_valid_delay1[1] ? kernel_temp[3] : 24'h0;
				odata[71:48] <= wr_valid_delay1[2] ? kernel_temp[6] : 24'h0;
			end
			else if(wr_en_delay1[1] | result_valid_delay2[1] | result_valid_delay2[4] | result_valid_delay2[7]) begin
				odata[23:0] <= wr_valid_delay1[0] ? kernel_temp[1] : 24'h0;
				odata[47:24] <= wr_valid_delay1[1] ? kernel_temp[4] : 24'h0;
				odata[71:48] <= wr_valid_delay1[2] ? kernel_temp[7] : 24'h0;
			end
			else if(wr_en_delay1[2] | result_valid_delay2[2] | result_valid_delay2[5] | result_valid_delay2[8]) begin
				odata[23:0] <= wr_valid_delay1[0] ? kernel_temp[2] : 24'h0;
				odata[47:24] <= wr_valid_delay1[1] ? kernel_temp[5] : 24'h0;
				odata[71:48] <= wr_valid_delay1[2] ? kernel_temp[8] : 24'h0;
			end
		end
	end
	
	//output result
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			result_valid_temp <= 9'h0;
		else begin
			result_valid_temp[0] <= (row_nxt_state[0] == SLAST) && id_valid && (col_cur_state[0] == SLAST);
			result_valid_temp[1] <= (row_nxt_state[1] == SLAST) && id_valid && (col_cur_state[0] == SLAST);
			result_valid_temp[2] <= (row_nxt_state[2] == SLAST) && id_valid && (col_cur_state[0] == SLAST);
			result_valid_temp[3] <= (row_nxt_state[0] == SLAST) && id_valid && (col_cur_state[1] == SLAST);
			result_valid_temp[4] <= (row_nxt_state[1] == SLAST) && id_valid && (col_cur_state[1] == SLAST);
			result_valid_temp[5] <= (row_nxt_state[2] == SLAST) && id_valid && (col_cur_state[1] == SLAST);
			result_valid_temp[6] <= (row_nxt_state[0] == SLAST) && id_valid && (col_cur_state[2] == SLAST);
			result_valid_temp[7] <= (row_nxt_state[1] == SLAST) && id_valid && (col_cur_state[2] == SLAST);
			result_valid_temp[8] <= (row_nxt_state[2] == SLAST) && id_valid && (col_cur_state[2] == SLAST);
		end
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			result_valid_delay <= 9'h0;
			result_valid_delay1 <= 9'h0;
			result_valid_delay2 <= 9'h0;
			oresult_valid <= 9'h0;
		end
		else begin
			result_valid_delay <= result_valid_temp;
			result_valid_delay1 <= result_valid_delay;
			result_valid_delay2 <= result_valid_delay1;
			oresult_valid <= result_valid_delay2;
		end
	end
	
	//generate finish_flag signal
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			finish_delay <= 4'h0;
			ofinish_flag <= 1'b0;
		end
		else begin
			finish_delay[0] <= (irow_cnt == 8'd223) && (icol_cnt == 8'd223) && id_valid;
			finish_delay[3:1] <= finish_delay[2:0];
			ofinish_flag <= finish_delay[3];
		end
	end
	
endmodule