//conv0 layer base storeage unit
module conv0_st(
	input				clk,
	input				rst_n,
	
	input		[63:0]	idata,
	input				idata_empty,
	output				odata_rd,
	
	input				ipara_empty,
	output				opara_rd,
	
	output		[7:0]	odata_ch0,
	output		[7:0]	odata_ch1,
	output		[7:0]	odata_ch2,
	output	reg			odata_valid,
	output	reg	[7:0]	orow_cnt,
	output	reg	[7:0]	ocol_cnt,
	output				orow_flag,
	
	output	reg			opara_valid_ch0,
	output	reg			opara_valid_ch1,
	output	reg			opara_valid_ch2,
	
	input				ifinish_flag,
	output				oover_flag
);

	parameter			SIDLE = 3'b000;
	parameter			SSTD = 3'b001;				//first stage, store data
	parameter			SLDP = 3'b010;				//second stage, load para
	parameter			SLDD = 3'b011;				//third stage, load data
	parameter			SFICYCLE = 3'b100;			//finish a cycle of calc
	
	parameter			DATA_SIZE = 15'd18816;
	parameter			PARA_SIZE = 9'd432;
	
	reg			[2:0]	cur_state;
	reg			[2:0]	nxt_state;
	
	reg			[14:0]	data_cnt;						//counter for data to restore, 224*224*3*8bit/64bit=18816
	reg			[14:0]	data_cnt_delay;
	reg			[8:0]	para_cnt;						//counter for para to restore, 12*12*3*16*8bits/128bits=432
	
	//ping data bram
	reg					wea_bram0_ch0;
	reg			[15:0]	addra_bram0_ch0;
	wire		[7:0]	dout_bram0_ch0;
	reg					wea_bram0_ch1;
	reg			[15:0]	addra_bram0_ch1;
	wire		[7:0]	dout_bram0_ch1;
	reg					wea_bram0_ch2;
	reg			[15:0]	addra_bram0_ch2;
	wire		[7:0]	dout_bram0_ch2;
	reg			[63:0]	din_bram0;
	
	//pang
	reg					wea_bram1_ch0;
	reg					wea_bram1_ch1;
	reg					wea_bram1_ch2;
	reg			[15:0]	addra_bram1_ch0;
	reg			[15:0]	addra_bram1_ch1;
	reg			[15:0]	addra_bram1_ch2;
	wire		[7:0]	dout_bram1_ch0;
	wire		[7:0]	dout_bram1_ch1;
	wire		[7:0]	dout_bram1_ch2;
	
	wire				bram_rdy;
	reg			[1:0]	bram_status;
	reg					bram_onuse;
	reg					bram_onwr;
	reg					finish_state_flag;			//this is for bram_status control
	
	reg					data_rd_r;
	reg					data_in_valid;
	reg					data_valid_temp;
	reg					para_rd_r;
	reg			[1:0]	para_rd_ch;
	
	reg			[18:0]	wait_cnt;					// wait 311040 cycles to read data again
	
	reg			[2:0]	cycles;
	reg					aux_finish_flag;			//aux signal to judge finish a cycle of reading bram
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			cur_state <= 3'h0;
		else
			cur_state <= nxt_state;
	end
	
	always @(*)
	begin
		case(cur_state)
			SIDLE:		if(bram_rdy)
							nxt_state <= SLDP;
						else if(!idata_empty)
							nxt_state <= SSTD;
						else
							nxt_state <= SIDLE;
			SSTD:		if((data_cnt_delay == (DATA_SIZE - 1'b1)) && data_in_valid)
							nxt_state <= SLDP;
						else
							nxt_state <= SSTD;
			SLDP:		if(para_cnt == PARA_SIZE)
							nxt_state <= SLDD;
						else
							nxt_state <= SLDP;
			SLDD:		if(ifinish_flag)
							nxt_state <= SFICYCLE;
						else
							nxt_state <= SLDD;
			SFICYCLE:	if(finish_state_flag) begin
							if(cycles == 3'b101)
								nxt_state <= SIDLE;
							else
								nxt_state <= SLDP;
						end
						else
							nxt_state <= SFICYCLE;
			default:	nxt_state <= SIDLE;
		endcase
	end
	
	//generate data rd signal, if brams are not full filled
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			data_rd_r <= 1'b0;
		else begin
			if((cur_state != SIDLE) && (nxt_state != SFICYCLE) && (bram_status != 2'b11) && (!idata_empty))
				data_rd_r <= (wait_cnt == 0);
			else
				data_rd_r <= 1'b0;
		end
	end
	assign odata_rd = data_rd_r & (!idata_empty) & (bram_status != 2'b11);
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			wait_cnt <= 19'h0;
		else if((data_cnt_delay == (DATA_SIZE - 1'b1)) && data_in_valid)
			wait_cnt <= 19'h1;
		else if(wait_cnt == 19'd400_000)
			wait_cnt <= 19'h0;
		else if(wait_cnt != 0)
			wait_cnt <= wait_cnt + 1'b1;
	end
	
	always @(posedge clk) begin
		data_in_valid <= odata_rd;
		data_cnt_delay <= data_cnt;
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			data_cnt <= 15'h0;
		else if(odata_rd) begin
			if(data_cnt == (DATA_SIZE - 1'b1))
				data_cnt <= 15'h0;
			else
				data_cnt <= data_cnt + 1'b1;
		end
	end
	
	//set bram status and bram_rdy
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bram_status <= 2'b00;
		else begin
			if((data_cnt_delay == (DATA_SIZE - 1'b1)) && data_in_valid)
				case(bram_status)
					2'b00:	bram_status <= bram_onwr ? 2'b10 : 2'b01;
					2'b01:	bram_status <= 2'b11;
					2'b10:	bram_status <= 2'b11;
				endcase
			else if((cur_state == SFICYCLE) && (nxt_state == SIDLE))
				case(bram_status)
					2'b01:	bram_status <= 2'b00;
					2'b10:	bram_status <= 2'b00;
					2'b11:	bram_status <= bram_onuse ? 2'b01 : 2'b10;
				endcase
		end
	end
	assign bram_rdy = |bram_status;
	
	//set bram_onuse signal, flag = 0 indicate bram0 are used, flag = 1 indicate bram1 are used
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bram_onuse <= 1'b0;
		else if((cur_state == SFICYCLE) && (nxt_state == SIDLE))
			bram_onuse <= ~bram_onuse;
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			bram_onwr <= 1'b0;
		else if(data_in_valid && (data_cnt_delay == DATA_SIZE - 1))
			bram_onwr <= ~bram_onwr;
	end
	
	//avoid bram_status increate and sub at same time
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			finish_state_flag <= 1'b0;
		else if(cur_state == SFICYCLE)
			finish_state_flag <= 1'b1;
		else
			finish_state_flag <= 1'b0;
	end
	
	//count for calc cycles
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			cycles <= 3'h0;
		else if((cur_state == SFICYCLE) && finish_state_flag)
			cycles <= cycles + 1'b1;
		else if(cur_state == SIDLE)
			cycles <= 3'h0;
	end
	
	//generate bram write signal
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			wea_bram0_ch0 <= 1'b0;
			wea_bram0_ch1 <= 1'b0;
			wea_bram0_ch2 <= 1'b0;
			wea_bram1_ch0 <= 1'b0;
			wea_bram1_ch1 <= 1'b0;
			wea_bram1_ch2 <= 1'b0;
			din_bram0 <= 64'h0;
		end
		else begin
			if(data_in_valid) begin
				if(data_cnt_delay < 15'd6272) begin
					wea_bram0_ch0 <= ~bram_onwr;
					wea_bram1_ch0 <= bram_onwr;
					wea_bram0_ch1 <= 1'b0;
					wea_bram1_ch1 <= 1'b0;
					wea_bram0_ch2 <= 1'b0;
					wea_bram1_ch2 <= 1'b0;
				end
				else if(data_cnt_delay < 15'd12544) begin
					wea_bram0_ch1 <= ~bram_onwr;
					wea_bram1_ch1 <= bram_onwr;
					wea_bram0_ch0 <= 1'b0;
					wea_bram1_ch0 <= 1'b0;
					wea_bram0_ch2 <= 1'b0;
					wea_bram1_ch2 <= 1'b0;
				end
				else begin
					wea_bram0_ch2 <= ~bram_onwr;
					wea_bram1_ch2 <= bram_onwr;
					wea_bram0_ch0 <= 1'b0;
					wea_bram1_ch0 <= 1'b0;
					wea_bram0_ch1 <= 1'b0;
					wea_bram1_ch1 <= 1'b0;
				end
				din_bram0 <= idata;
			end
			else begin
				wea_bram0_ch0 <= 1'b0;
				wea_bram0_ch1 <= 1'b0;
				wea_bram0_ch2 <= 1'b0;
				wea_bram1_ch0 <= 1'b0;
				wea_bram1_ch1 <= 1'b0;
				wea_bram1_ch2 <= 1'b0;
			end
		end
	end	
	
	//generate bram address
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			addra_bram0_ch0 <= 16'h0;
			addra_bram0_ch1 <= 16'h0;
			addra_bram0_ch2 <= 16'h0;
			addra_bram1_ch0 <= 16'h0;
			addra_bram1_ch1 <= 16'h0;
			addra_bram1_ch2 <= 16'h0;
		end
		else begin
			if(wea_bram0_ch0) begin
				if(addra_bram0_ch0 == 16'd50168)				//224��224-8=50176-8=50168
					addra_bram0_ch0 <= 16'h0;
				else
					addra_bram0_ch0 <= addra_bram0_ch0 + 4'h8;
			end
			else if(data_valid_temp && (!bram_onuse))
				addra_bram0_ch0 <= addra_bram0_ch0 + 1'b1;
			else if((cur_state == SFICYCLE) && (!bram_onuse))
				addra_bram0_ch0 <= 16'h0;
				
			if(wea_bram0_ch1) begin
				if(addra_bram0_ch1 == 16'd50168)
					addra_bram0_ch1 <= 16'h0;
				else
					addra_bram0_ch1 <= addra_bram0_ch1 + 4'h8;
			end
			else if(data_valid_temp && (!bram_onuse))
				addra_bram0_ch1 <= addra_bram0_ch1 + 1'b1;
			else if((cur_state == SFICYCLE) && (!bram_onuse))
				addra_bram0_ch1 <= 16'h0;
				
			if(wea_bram0_ch2) begin
				if(addra_bram0_ch2 == 16'd50168)
					addra_bram0_ch2 <= 16'h0;
				else
					addra_bram0_ch2 <= addra_bram0_ch2 + 4'h8;
			end
			else if(data_valid_temp && (!bram_onuse))
				addra_bram0_ch2 <= addra_bram0_ch2 + 1'b1;
			else if((cur_state == SFICYCLE) && (!bram_onuse))
				addra_bram0_ch2 <= 16'h0;
			
			if(wea_bram1_ch0) begin
				if(addra_bram1_ch0 == 16'd50168)
					addra_bram1_ch0 <= 16'h0;
				else
					addra_bram1_ch0 <= addra_bram1_ch0 + 4'h8;
			end
			else if(data_valid_temp && bram_onuse)
				addra_bram1_ch0 <= addra_bram1_ch0 + 1'b1;
			else if((cur_state == SFICYCLE) && bram_onuse)
				addra_bram1_ch0 <= 16'h0;
				
			if(wea_bram1_ch1) begin
				if(addra_bram1_ch1 == 16'd50168)
					addra_bram1_ch1 <= 16'h0;
				else
					addra_bram1_ch1 <= addra_bram1_ch1 + 4'h8;
			end
			else if(data_valid_temp && bram_onuse)
				addra_bram1_ch1 <= addra_bram1_ch1 + 1'b1;
			else if((cur_state == SFICYCLE) && bram_onuse)
				addra_bram1_ch1 <= 16'h0;
				
			if(wea_bram1_ch2) begin
				if(addra_bram1_ch2 == 16'd50168)
					addra_bram1_ch2 <= 16'h0;
				else
					addra_bram1_ch2 <= addra_bram1_ch2 + 4'h8;
			end
			else if(data_valid_temp && bram_onuse)
				addra_bram1_ch2 <= addra_bram1_ch2 + 1'b1;
			else if((cur_state == SFICYCLE) && bram_onuse)
				addra_bram1_ch2 <= 16'h0;
		end
	end			
			
	//data store
	conv0_data conv0_data_inst_bram0_ch0(
  		.clka(clk),    // input wire clka
  		.ena(1'b1),      // input wire ena
  		.wea(wea_bram0_ch0),      // input wire [0 : 0] wea
  		.addra(addra_bram0_ch0),  // input wire [15 : 0] addra
  		.dina(din_bram0),    // input wire [63 : 0] dina
  		.douta(dout_bram0_ch0)  // output wire [7 : 0] douta
	);
	
	conv0_data conv0_data_inst_bram0_ch1(
  		.clka(clk),    // input wire clka
  		.ena(1'b1),      // input wire ena
  		.wea(wea_bram0_ch1),      // input wire [0 : 0] wea
  		.addra(addra_bram0_ch1),  // input wire [15 : 0] addra
  		.dina(din_bram0),    // input wire [63 : 0] dina
  		.douta(dout_bram0_ch1)  // output wire [7 : 0] douta
	);
	
	conv0_data conv0_data_inst_bram0_ch2(
  		.clka(clk),    // input wire clka
  		.ena(1'b1),      // input wire ena
  		.wea(wea_bram0_ch2),      // input wire [0 : 0] wea
  		.addra(addra_bram0_ch2),  // input wire [15 : 0] addra
  		.dina(din_bram0),    // input wire [63 : 0] dina
  		.douta(dout_bram0_ch2)  // output wire [7 : 0] douta
	);
	
	conv0_data conv0_data_inst_bram1_ch0(
  		.clka(clk),    // input wire clka
  		.ena(1'b1),      // input wire ena
  		.wea(wea_bram1_ch0),      // input wire [0 : 0] wea
  		.addra(addra_bram1_ch0),  // input wire [15 : 0] addra
  		.dina(din_bram0),    // input wire [63 : 0] dina
  		.douta(dout_bram1_ch0)  // output wire [7 : 0] douta
	);
	
	conv0_data conv0_data_inst_bram1_ch1(
  		.clka(clk),    // input wire clka
  		.ena(1'b1),      // input wire ena
  		.wea(wea_bram1_ch1),      // input wire [0 : 0] wea
  		.addra(addra_bram1_ch1),  // input wire [15 : 0] addra
  		.dina(din_bram0),    // input wire [63 : 0] dina
  		.douta(dout_bram1_ch1)  // output wire [7 : 0] douta
	);
	
	conv0_data conv0_data_inst_bram1_ch2(
  		.clka(clk),    // input wire clka
  		.ena(1'b1),      // input wire ena
  		.wea(wea_bram1_ch2),      // input wire [0 : 0] wea
  		.addra(addra_bram1_ch2),  // input wire [15 : 0] addra
  		.dina(din_bram0),    // input wire [63 : 0] dina
  		.douta(dout_bram1_ch2)  // output wire [7 : 0] douta
	);
	
	//generate data output signals
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			data_valid_temp <= 1'b0;
		else if(cur_state == SLDD) begin
			if(((orow_cnt == 8'd222) && (ocol_cnt == 8'd223) && data_valid_temp) || aux_finish_flag)
				data_valid_temp <= 1'b0;
			else
				data_valid_temp <= 1'b1;
		end
		else
			data_valid_temp <= 1'b0;
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			odata_valid <= 1'b0;
			orow_cnt <= 8'h0;
			ocol_cnt <= 8'h0;
		end
		else begin
			odata_valid <= data_valid_temp;
			if(odata_valid) begin
				if(orow_cnt == 8'd223) begin
					orow_cnt <= 8'h0;
					ocol_cnt <= ocol_cnt + 1'b1;
				end
				else
					orow_cnt <= orow_cnt + 1'b1;
			end
			else if(cur_state == SFICYCLE) begin
				orow_cnt <= 8'h0;
				ocol_cnt <= 8'h0;
			end
		end
	end
	assign orow_flag = odata_valid && (orow_cnt == 8'd0);	
					
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			aux_finish_flag <= 1'b0;
		else if(cur_state == SLDD) begin
			if((orow_cnt == 8'd222) && (ocol_cnt == 8'd223) && data_valid_temp)
				aux_finish_flag <= 1'b1;
		end
		else
			aux_finish_flag <= 1'b0;
	end
	
	//select output data
	assign odata_ch0 = bram_onuse ? dout_bram1_ch0 : dout_bram0_ch0;
	assign odata_ch1 = bram_onuse ? dout_bram1_ch1 : dout_bram0_ch1;
	assign odata_ch2 = bram_onuse ? dout_bram1_ch2 : dout_bram0_ch2;
	
	//generate para read and valid signals
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			para_rd_r <= 1'b0;
		else if((cur_state == SLDP) && (para_cnt < (PARA_SIZE - 1'b1)))
			para_rd_r <= !ipara_empty;
		else
			para_rd_r <= 1'b0;
	end
	assign opara_rd = para_rd_r & (!ipara_empty);
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			para_cnt <= 9'h0;
		else if(opara_rd)
			para_cnt <= para_cnt + 1'b1;
		else if(cur_state != SLDP)
			para_cnt <= 9'h0;
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			para_rd_ch <= 2'b00;
		else if(opara_rd)
			if(para_rd_ch == 2'b10)
				para_rd_ch <= 2'b00;
			else
				para_rd_ch <= para_rd_ch + 1'b1;
	end
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			opara_valid_ch0 <= 1'b0;
			opara_valid_ch1 <= 1'b0;
			opara_valid_ch2 <= 1'b0;
		end
		else if(opara_rd) begin
			if(para_rd_ch == 2'b00) begin
				opara_valid_ch0 <= 1'b1;
				opara_valid_ch1 <= 1'b0;
				opara_valid_ch2 <= 1'b0;
			end
			else if(para_rd_ch == 2'b01) begin
				opara_valid_ch0 <= 1'b0;
				opara_valid_ch1 <= 1'b1;
				opara_valid_ch2 <= 1'b0;
			end
			else if(para_rd_ch == 2'b10) begin
				opara_valid_ch0 <= 1'b0;
				opara_valid_ch1 <= 1'b0;
				opara_valid_ch2 <= 1'b1;
			end 
		end
		else begin
			opara_valid_ch0 <= 1'b0;
			opara_valid_ch1 <= 1'b0;
			opara_valid_ch2 <= 1'b0;
		end
	end
	
	assign oover_flag = (cur_state == SFICYCLE) && finish_state_flag && (cycles == 3'b101);

endmodule