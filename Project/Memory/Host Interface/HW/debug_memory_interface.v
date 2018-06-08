

module debug_memory_interface
	(
		////////////////////////	Clock Input	 	////////////////////////

		input			clock,				//	50 MHz


		////////////////////////	7-SEG Dispaly	////////////////////////
		output	[6:0]	hex0,					//	Seven Segment Digit 0
		output	[6:0]	hex1,					//	Seven Segment Digit 1
		output	[6:0]	hex2,					//	Seven Segment Digit 2
		output	[6:0]	hex3,					//	Seven Segment Digit 3
		////////////////////////////	LED		////////////////////////////
		output	[7:0]	ledg,					//	LED Green[7:0]
		output	[9:0]	ledr,					//	LED Red[9:0]




		////////////////////	USB JTAG link	////////////////////////////
		input  			tdi,					// CPLD -> FPGA (data in)
		input  			tck,					// CPLD -> FPGA (clk)
		input  			tcs,					// CPLD -> FPGA (CS)
		output 			tdo,					// FPGA -> CPLD (data out)
		
		//	Data Ram
		output [16:0]	data_ram_addr,
		output [15:0]	data_ram_data_wr,
		input  [15:0]	data_ram_data_rd,
		output			data_ram_we,
		//	Program ROM 
		output [16:0]	program_rom_addr,
		output [15:0]	program_rom_data_wr,
		input  [15:0]	program_rom_data_rd,
		output			program_rom_we
	
	);




////////////////////////////////////////////////////////////////////

//	USB JTAG
wire [7:0] mRXD_DATA,mTXD_DATA;
wire mRXD_Ready,mTXD_Done,mTXD_Start;
wire mTCK;


//	SRAM
wire [17:0]	sram_addr;
wire [15:0]	sram_data_wr,sram_data_rd;
wire		sram_wen;
//	SEG7
wire [31:0] mSEG7_DIG;


wire		resetn;



GLOBAL tck_buff (.in(tck), .out(mTCK));



Reset_Delay			d0	(	.iCLK(clock),.oRESET(resetn)	);

SEG7_LUT_4 			u0	(	hex0,hex1,hex2,hex3,mSEG7_DIG );

USB_JTAG			u1	(	//	HOST
							.iTxD_DATA(mTXD_DATA),.oTxD_Done(mTXD_Done),.iTxD_Start(mTXD_Start),
							.oRxD_DATA(mRXD_DATA),.oRxD_Ready(mRXD_Ready),.iRST_n(resetn),.iCLK(clock),
							//	JTAG
							.TDO(tdo),.TDI(tdi),.TCS(tcs),.TCK(mTCK)	);


CMD_Decode			u5	(	//	USB JTAG
							.iRXD_DATA(mRXD_DATA),.iRXD_Ready(mRXD_Ready),
						 	.oTXD_DATA(mTXD_DATA),.oTXD_Start(mTXD_Start),.iTXD_Done(mTXD_Done),
						 	//	FLASH
							.iFL_DATA(8'd0),.iFL_Ready(1'b1),
							//	SDRAM
							.iSDR_DATA(16'd0),.iSDR_Done(1'b1),
							//	SRAM
							.iSR_DATA(sram_data_rd),.oSR_DATA(sram_data_wr),
							.oSR_ADDR(sram_addr),
							.oSR_WE_N(sram_wen),
						 	//	LED + SEG7
							.oLED_GREEN(ledg),.oLED_RED(ledr),
							.oSEG7_DIG(mSEG7_DIG),
							//	PS2
							.iPS2_ScanCode(8'd0),.iPS2_Ready(1'b0),
							//	Control
						 	.iCLK(clock),.iRST_n(resetn)	);
						 	
						 	
		assign data_ram_addr 		= sram_addr[16:0];
		assign data_ram_data_wr 	= sram_data_wr;
		assign data_ram_we 			= !sram_wen & !sram_addr[17];
		
		assign program_rom_addr		= sram_addr[16:0];
		assign program_rom_data_wr	= sram_data_wr;
		assign program_rom_we 		= !sram_wen & sram_addr[17];
		
		
		
		assign sram_data_rd			= sram_addr[17] ? program_rom_data_rd : data_ram_data_rd;
		
endmodule

module	Reset_Delay(iCLK,oRESET);
input		iCLK;
output reg	oRESET;
reg	[19:0]	Cont;

always@(posedge iCLK)
begin
	if(Cont!=20'hFFFFF)
	begin
		Cont	<=	Cont+1;
		oRESET	<=	1'b0;
	end
	else
	oRESET	<=	1'b1;
end

endmodule

module CMD_Decode(	//	USB JTAG
					iRXD_DATA,oTXD_DATA,iRXD_Ready,iTXD_Done,oTXD_Start,
					//	LED
					oLED_RED,oLED_GREEN,
					//	7-SEG
					oSEG7_DIG,
					//	VGA
					oOSD_CUR_EN,oCursor_X,oCursor_Y,
					oCursor_R,oCursor_G,oCursor_B,			
					//	FLASH
					oFL_DATA,iFL_DATA,oFL_ADDR,iFL_Ready,oFL_Start,oFL_CMD,
					//	SDRAM
					oSDR_DATA,iSDR_DATA,oSDR_ADDR,iSDR_Done,oSDR_WR,oSDR_RD,
					//	SRAM
					oSR_DATA,iSR_DATA,oSR_ADDR,oSR_WE_N,oSR_OE_N,
					//	PS2
					iPS2_ScanCode,iPS2_Ready,
					//	Async Port Select
					oSDR_Select,oFL_Select,oSR_Select,
					//	Control
					iCLK,iRST_n	);
//	USB JTAG
input [7:0] iRXD_DATA;
input iRXD_Ready,iTXD_Done;
output [7:0] oTXD_DATA;
output oTXD_Start;
//	LED
output reg [17:0] oLED_RED;
output reg [8:0]  oLED_GREEN;
//	7-SEG
output reg [31:0] oSEG7_DIG;
//	VGA
output reg [9:0] oCursor_X;
output reg [9:0] oCursor_Y;
output reg [9:0] oCursor_R;
output reg [9:0] oCursor_G;
output reg [9:0] oCursor_B;
output reg [1:0] oOSD_CUR_EN;
//	FLASH
input [7:0] iFL_DATA;
input iFL_Ready;
output reg [21:0] oFL_ADDR;
output reg [7:0] oFL_DATA;
output reg [2:0] oFL_CMD;
output reg oFL_Start;
//	SDRAM
input [15:0] iSDR_DATA;
input iSDR_Done;
output reg [21:0] oSDR_ADDR;
output reg [15:0] oSDR_DATA;
output oSDR_WR,oSDR_RD;
//	SRAM
input	[15:0]	iSR_DATA;
output	reg [15:0]	oSR_DATA;
output	reg	[17:0]	oSR_ADDR;
output	oSR_WE_N,oSR_OE_N;
//	PS2
input [7:0] iPS2_ScanCode;
input iPS2_Ready;
//	Async Port Select
output reg [1:0] oSDR_Select;
output reg [1:0] oFL_Select;
output reg [1:0] oSR_Select;
//	Control
input iCLK,iRST_n;

//	Internal Register
reg [63:0] CMD_Tmp;
reg [2:0] mFL_ST,mSDR_ST,mPS2_ST,mSR_ST,mLCD_ST;
//	SDRAM Control Register
reg mSDR_WRn,mSDR_Start;
//	SRAM Control Register
reg	mSR_WRn,mSR_Start;
//	Active Flag
reg f_SETUP,f_LED,f_SEG7,f_SDR_SEL,f_FL_SEL,f_SR_SEL;
reg	f_FLASH,f_SDRAM,f_PS2,f_SRAM,f_VGA;
//	USB JTAG TXD Output
reg oFL_TXD_Start,oSDR_TXD_Start,oPS2_TXD_Start,oSR_TXD_Start;
reg [7:0] oFL_TXD_DATA,oSDR_TXD_DATA,oPS2_TXD_DATA,oSR_TXD_DATA;
//	TXD Output Select Register
reg sel_FL,sel_SDR,sel_PS2,sel_SR;


wire [7:0]	CMD_Action	=	CMD_Tmp[63:56];
wire [7:0]	CMD_Target	=	CMD_Tmp[55:48];
wire [23:0]	CMD_ADDR	=	CMD_Tmp[47:24];
wire [15:0]	CMD_DATA	=	CMD_Tmp[23: 8];
wire [7:0]	CMD_MODE	=	CMD_Tmp[ 7: 0];
wire [7:0] 	Pre_Target	=	CMD_Tmp[47:40];

parameter CMD_READ		=	3'h0;
parameter CMD_WRITE 	= 	3'h1;
parameter CMD_BLK_ERA	= 	3'h2;
parameter CMD_SEC_ERA 	= 	3'h3;
parameter CMD_CHP_ERA	= 	3'h4;
parameter CMD_ENTRY_ID	= 	3'h5;
parameter CMD_RESET		= 	3'h6;

//////////////////	Command Action	/////////////////////
parameter	SETUP	=	8'h61;
parameter	ERASE	=	8'h72;
parameter	WRITE	=	8'h83;
parameter	READ	=	8'h94;
parameter	LCD_DAT	=	8'h83;
parameter	LCD_CMD	=	8'h94;
//////////////////	Command Target	/////////////////////
parameter	LED		=	8'hF0;
parameter	SEG7	=	8'hE1;
parameter	PS2		=	8'hD2;
parameter	FLASH	=	8'hC3;
parameter	SDRAM	=	8'hB4;
parameter	SRAM	=	8'hA5;
parameter	LCD		=	8'h96;
parameter	VGA		=	8'h87;
parameter	SDRSEL	=	8'h1F;
parameter	FLSEL	=	8'h2E;
parameter	EXTIO	=	8'h3D;
parameter	SET_REG	=	8'h4C;
parameter	SRSEL	=	8'h5B;
//////////////////	Command Mode	/////////////////////
parameter	OUTSEL	=	8'h33;
parameter	NORMAL	= 	8'hAA;
parameter	DISPLAY	=	8'hCC;
parameter	BURST	= 	8'hFF;
////////////////	 SDRAM Select	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oSDR_Select	<=0;
		f_SDR_SEL	<=0;
	end
	else
	begin
		if(iRXD_Ready && (Pre_Target == SDRSEL) )
		f_SDR_SEL<=1;
		if(f_SDR_SEL)
		begin
			if( (CMD_Action	== SETUP) && (CMD_MODE	== OUTSEL) && 
				(CMD_ADDR == 24'h123456) )
			oSDR_Select<=CMD_DATA[1:0];
			f_SDR_SEL<=0;
		end
	end
end
/////////////////////////////////////////////////////////
////////////////	 FLASH Select	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oFL_Select	<=0;
		f_FL_SEL	<=0;
	end
	else
	begin
		if(iRXD_Ready && (Pre_Target == FLSEL) )
		f_FL_SEL<=1;
		if(f_FL_SEL)
		begin
			if( (CMD_Action	== SETUP) && (CMD_MODE	== OUTSEL) && 
				(CMD_ADDR == 24'h123456) )
			oFL_Select<=CMD_DATA[1:0];
			f_FL_SEL<=0;
		end
	end
end
/////////////////////////////////////////////////////////
////////////////	 SRAM Select	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oSR_Select	<=0;
		f_SR_SEL	<=0;
	end
	else
	begin
		if(iRXD_Ready && (Pre_Target == SRSEL) )
		f_SR_SEL<=1;
		if(f_SR_SEL)
		begin
			if( (CMD_Action	== SETUP) && (CMD_MODE	== OUTSEL) && 
				(CMD_ADDR == 24'h123456) )
			oSR_Select<=CMD_DATA[1:0];
			f_SR_SEL<=0;
		end
	end
end
/////////////////////////////////////////////////////////
/////////////////	TXD	Output Select		/////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		sel_FL<=0;
		sel_SDR<=0;
		sel_PS2<=0;
		sel_SR<=0;
		f_SETUP<=0;
	end
	else
	begin
		if(iRXD_Ready && (Pre_Target == SET_REG) )
		f_SETUP<=1;
		if(f_SETUP)
		begin
			if( (CMD_Action	== SETUP) && (CMD_MODE	== OUTSEL) &&
				(CMD_ADDR == 24'h123456) )
			begin
				case(CMD_DATA[7:0])
				FLASH:	begin
							sel_FL	<=1;
							sel_SDR	<=0;
							sel_PS2	<=0;
							sel_SR	<=0;
						end
				SDRAM:	begin
							sel_FL	<=0;
							sel_SDR	<=1;
							sel_PS2	<=0;
							sel_SR	<=0;
						end
				PS2:	begin
							sel_FL	<=0;
							sel_SDR	<=0;
							sel_PS2	<=1;
							sel_SR	<=0;
						end
				SRAM:	begin
							sel_FL	<=0;
							sel_SDR	<=0;
							sel_PS2	<=0;
							sel_SR	<=1;
						end
				endcase
			end
			f_SETUP<=0;
		end
	end
end
assign oTXD_Start	= 	(sel_FL)	?	oFL_TXD_Start	:
						(sel_SDR)	?	oSDR_TXD_Start	:
						(sel_SR)	?	oSR_TXD_Start	:
										oPS2_TXD_Start	;
assign oTXD_DATA	=	(sel_FL)	?	oFL_TXD_DATA	:
						(sel_SDR)	?	oSDR_TXD_DATA	:
						(sel_SR)	?	oSR_TXD_DATA	:
										oPS2_TXD_DATA	;
/////////////////////////////////////////////////////////
///////		Shift Register For Command Temp	/////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	CMD_Tmp<=0;
	else
	begin
		if(iRXD_Ready)
		CMD_Tmp<={CMD_Tmp[55:0],iRXD_DATA};
	end
end
/////////////////////////////////////////////////////////
////////////////	 LED Control	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oLED_RED	<=0;
		oLED_GREEN	<=0;
		f_LED		<=0;
	end
	else
	begin
		if(iRXD_Ready && (Pre_Target == LED) )
		f_LED<=1;
		if(f_LED)
		begin
			if( (CMD_Action	== WRITE) && (CMD_MODE	== DISPLAY) )
			begin
				oLED_RED	<=CMD_ADDR;
				oLED_GREEN	<=CMD_DATA;
			end
			f_LED<=0;
		end
	end
end
/////////////////////////////////////////////////////////
////////////////	7-SEG Control	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oSEG7_DIG<=0;
		f_SEG7<=0;
	end
	else
	begin
		if(iRXD_Ready  && (Pre_Target == SEG7) )
		f_SEG7<=1;
		if(f_SEG7)
		begin
			if( (CMD_Action	== WRITE) && (CMD_MODE	== DISPLAY) )
			oSEG7_DIG<={CMD_ADDR[15:0],CMD_DATA};
			f_SEG7<=0;			
		end
	end
end
/////////////////////////////////////////////////////////
////////////////	Flash Control	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oFL_TXD_Start	<=0;
		oFL_Start		<=0;
		f_FLASH			<=0;
		mFL_ST			<=0;
	end
	else
	begin
		if( CMD_Action == READ )
		oFL_CMD		<=	CMD_READ;
		else if( CMD_Action == WRITE )
		oFL_CMD		<=	CMD_WRITE;
		else if( CMD_Action == ERASE )
		oFL_CMD		<=	CMD_CHP_ERA;
		else
		oFL_CMD		<=	3'b000;
		
		if(iRXD_Ready && (Pre_Target == FLASH))
		f_FLASH<=1;
		if(f_FLASH)
		begin
			case(mFL_ST)
			0:	begin
					if( (CMD_MODE	== NORMAL) && (CMD_Target == FLASH) && (CMD_DATA[15:8] == 8'hFF) )
					begin
						oFL_ADDR	<=	CMD_ADDR;
						oFL_DATA	<=	CMD_DATA;
						oFL_Start<=	1;
						mFL_ST	<=	1;
					end
					else
					begin
						mFL_ST	<=	0;
						f_FLASH	<=	0;
					end
				end	
			1:	begin
					if(iFL_Ready)
					begin
						mFL_ST<=2;
						oFL_Start<=0;
					end	
				end
			2:	begin
					oFL_Start<=1;
					mFL_ST<=3;
				end
			3:	begin
					if(iFL_Ready)
					begin
						mFL_ST<=4;
						oFL_Start<=0;
					end	
				end
			4:	begin
					oFL_Start<=1;
					mFL_ST<=5;
				end			
			5:	begin
					if(iFL_Ready)
					begin
						if( (oFL_CMD == CMD_READ) )
							mFL_ST	<=	6;
						else
						begin
							mFL_ST	<=	0;
							f_FLASH	<=	0;							
						end
						oFL_Start	<=	0;
					end				
				end
			6:	begin
					oFL_TXD_DATA	<=	iFL_DATA;
					oFL_TXD_Start	<=	1;
					mFL_ST			<=	7;
				end
			7:	begin
					if(iTXD_Done)
					begin
						oFL_TXD_Start<=0;
						mFL_ST	<=	0;
						f_FLASH	<=	0;
					end
				end
			endcase
		end
	end
end
/////////////////////////////////////////////////////////
/////////////////	PS2 Control		/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oPS2_TXD_Start<=0;
		f_PS2<=0;
		mPS2_ST<=0;
	end
	else
	begin
		if(iPS2_Ready && iPS2_ScanCode!=8'h2e)
		begin
			f_PS2<=1;
			oPS2_TXD_DATA<=iPS2_ScanCode;
		end
		if(f_PS2)
		begin
			case(mPS2_ST)
			0:	begin
					oPS2_TXD_Start	<=1;
					mPS2_ST			<=1;
				end
			1:	begin
					if(iTXD_Done)
					begin
						oPS2_TXD_Start	<=0;
						mPS2_ST			<=0;
						f_PS2			<=0;
					end
				end
			endcase
		end
	end
end
/////////////////////////////////////////////////////////
////////////////	Sdram Control	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oSDR_TXD_Start	<=0;
		mSDR_WRn		<=0;
		mSDR_Start		<=0;
		f_SDRAM			<=0;
		mSDR_ST			<=0;
	end
	else
	begin
		if( CMD_Action == READ )
		mSDR_WRn	<=	1'b0;
		else if( CMD_Action == WRITE )
		mSDR_WRn	<=	1'b1;
		
		if(iRXD_Ready && (Pre_Target == SDRAM))
		f_SDRAM<=1;
		if(f_SDRAM)
		begin
			case(mSDR_ST)
			0:	begin
					if( (CMD_MODE	== NORMAL) && (CMD_Target == SDRAM) )
					begin
						oSDR_ADDR	<=	CMD_ADDR;
						oSDR_DATA	<=	CMD_DATA;
						mSDR_Start	<= 	1;
						mSDR_ST		<=	1;
					end
					else
					begin
						mSDR_ST	<=	0;
						f_SDRAM	<=	0;
					end
				end
			1:	begin
					if(iSDR_Done)
					begin
						if(mSDR_WRn == 1'b0)
							mSDR_ST	<=	2;
						else
						begin
							mSDR_ST	<=	0;
							f_SDRAM	<=	0;							
							mSDR_Start	<=	0;
						end
					end				
				end
			2:	begin
					oSDR_TXD_DATA	<= iSDR_DATA[7:0];
					oSDR_TXD_Start	<=	1;
					mSDR_ST			<=	3;
				end
			3:	begin
					if(iTXD_Done)
					begin
						oSDR_TXD_Start<=0;
						mSDR_ST	<=	4;
					end											
				end
			4:	begin
					oSDR_TXD_DATA	<= 	iSDR_DATA[15:8];
					oSDR_TXD_Start	<=	1;
					mSDR_ST			<=	5;
				end
			5:	begin
					if(iTXD_Done)
					begin
						mSDR_Start	<=	0;
						oSDR_TXD_Start<=0;
						mSDR_ST	<=	0;
						f_SDRAM	<=	0;
					end				
				end
			endcase
		end
	end
end

assign	oSDR_WR	=	mSDR_WRn & mSDR_Start;
assign	oSDR_RD	=	~mSDR_WRn & mSDR_Start;
/////////////////////////////////////////////////////////
////////////////	SRAM Control	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oSR_TXD_Start	<=0;
		mSR_WRn			<=0;
		mSR_Start		<=0;
		f_SRAM			<=0;
		mSR_ST			<=0;
	end
	else
	begin
		if( CMD_Action == READ )
		mSR_WRn	<=	1'b0;
		else if( CMD_Action == WRITE )
		mSR_WRn	<=	1'b1;
		
		if(iRXD_Ready && (Pre_Target == SRAM))
		f_SRAM<=1;
		if(f_SRAM)
		begin
			case(mSR_ST)
			0:	begin
					if( (CMD_MODE	== NORMAL) && (CMD_Target == SRAM) )
					begin
						oSR_ADDR	<=	CMD_ADDR;
						oSR_DATA	<=	CMD_DATA;
						mSR_Start	<= 	1;
						mSR_ST		<=	1;
					end
					else
					begin
						mSR_ST	<=	0;
						f_SRAM	<=	0;
					end
				end
			1:	begin
					if(mSR_WRn == 1'b0)
						mSR_ST	<=	2;
					else
					begin
						mSR_ST	<=	0;
						f_SRAM	<=	0;							
						mSR_Start	<=	0;
					end
				end
			2:	begin
					oSR_TXD_DATA	<= 	iSR_DATA[7:0];
					oSR_TXD_Start	<=	1;
					mSR_ST			<=	3;
				end
			3:	begin
					if(iTXD_Done)
					begin
						oSR_TXD_Start<=0;
						mSR_ST	<=	4;
					end											
				end
			4:	begin
					oSR_TXD_DATA	<= 	iSR_DATA[15:8];
					oSR_TXD_Start	<=	1;
					mSR_ST			<=	5;
				end
			5:	begin
					if(iTXD_Done)
					begin
						mSR_Start	<=	0;
						oSR_TXD_Start<=	0;
						mSR_ST		<=	0;
						f_SRAM		<=	0;
					end				
				end
			endcase
		end
	end
end

assign	oSR_OE_N	=	~(~mSR_WRn & mSR_Start );
assign	oSR_WE_N	=	~( mSR_WRn & mSR_Start );

/////////////////////////////////////////////////////////
////////////////////   VGA Control	/////////////////////
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oCursor_X	<=	0;
		oCursor_Y	<=	0;
		oCursor_R	<=	0;
		oCursor_G	<=	0;
		oCursor_B	<=	0;
		oOSD_CUR_EN	<=	0;
		f_VGA		<=	0;
	end
	else
	begin
		if(iRXD_Ready  && (Pre_Target == VGA) )
		f_VGA<=1;
		if(f_VGA)
		begin
			if( (CMD_Action	== WRITE) && (CMD_MODE	== DISPLAY) )
			begin
				case(CMD_ADDR[2:0])
				0:	oOSD_CUR_EN	<=	CMD_DATA[1:0];
				1:	oCursor_X	<=	CMD_DATA[9:0];
				2:	oCursor_Y	<=	CMD_DATA[9:0];
				3:	oCursor_R	<=	CMD_DATA[9:0];	
				4:	oCursor_G	<=	CMD_DATA[9:0];
				5:	oCursor_B	<=	CMD_DATA[9:0];
				endcase
			end
			f_VGA<=0;			
		end
	end
end
/////////////////////////////////////////////////////////

endmodule

module SEG7_LUT_4 (	oSEG0,oSEG1,oSEG2,oSEG3,iDIG );
input	[15:0]	iDIG;
output	[6:0]	oSEG0,oSEG1,oSEG2,oSEG3;

SEG7_LUT	u0	(	oSEG0,iDIG[3:0]		);
SEG7_LUT	u1	(	oSEG1,iDIG[7:4]		);
SEG7_LUT	u2	(	oSEG2,iDIG[11:8]	);
SEG7_LUT	u3	(	oSEG3,iDIG[15:12]	);

endmodule

module SEG7_LUT	(	oSEG,iDIG	);
input	[3:0]	iDIG;
output	[6:0]	oSEG;
reg		[6:0]	oSEG;

always @(iDIG)
begin
		case(iDIG)
		4'h1: oSEG = 7'b1111001;	// ---t----
		4'h2: oSEG = 7'b0100100; 	// |	  |
		4'h3: oSEG = 7'b0110000; 	// lt	 rt
		4'h4: oSEG = 7'b0011001; 	// |	  |
		4'h5: oSEG = 7'b0010010; 	// ---m----
		4'h6: oSEG = 7'b0000010; 	// |	  |
		4'h7: oSEG = 7'b1111000; 	// lb	 rb
		4'h8: oSEG = 7'b0000000; 	// |	  |
		4'h9: oSEG = 7'b0011000; 	// ---b----
		4'ha: oSEG = 7'b0001000;
		4'hb: oSEG = 7'b0000011;
		4'hc: oSEG = 7'b1000110;
		4'hd: oSEG = 7'b0100001;
		4'he: oSEG = 7'b0000110;
		4'hf: oSEG = 7'b0001110;
		4'h0: oSEG = 7'b1000000;
		endcase
end

endmodule

module USB_JTAG	(	//	HOST
					iTxD_DATA,oTxD_Done,iTxD_Start,
					oRxD_DATA,oRxD_Ready,iRST_n,iCLK,
					//	JTAG
					TDO,TDI,TCS,TCK	);
input [7:0] iTxD_DATA;
input iTxD_Start,iRST_n,iCLK;
output reg [7:0] oRxD_DATA;
output reg oTxD_Done,oRxD_Ready;
input TDI,TCS,TCK;
output TDO;
wire [7:0] mRxD_DATA;
wire mTxD_Done,mRxD_Ready;			
reg Pre_TxD_Done,Pre_RxD_Ready;
reg mTCK;
////////////	JTAG CLK Sync.	///////////////
always@(posedge iCLK)	mTCK<=TCK;
/////////////////	JTAG Receiver	///////////////
JTAG_REC	u0	(mRxD_DATA,mRxD_Ready,TDI,TCS,mTCK);
//	JTAG Receiver Sync.
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oRxD_Ready<=0;
		Pre_RxD_Ready<=0;
	end
	else
	begin
		Pre_RxD_Ready<=mRxD_Ready;
		if({Pre_RxD_Ready,mRxD_Ready}==2'b01 && ~iTxD_Start)
		begin
			oRxD_Ready<=1;
			oRxD_DATA<=mRxD_DATA;
		end
		else
			oRxD_Ready<=0;
	end
end
///////////////////////////////////////////////////
/////////////	JTAG Transmitter	///////////////
JTAG_TRANS	u1	(iTxD_DATA,iTxD_Start,mTxD_Done,TDO,TCK,TCS);
//	JTAG Transmitter Sync.
always@(posedge iCLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oTxD_Done<=0;
		Pre_TxD_Done<=0;
	end
	else
	begin
		Pre_TxD_Done<=mTxD_Done;
		if({Pre_TxD_Done,mTxD_Done}==2'b01)
			oTxD_Done<=1;
		else
			oTxD_Done<=0;
	end
end
///////////////////////////////////////////////////
endmodule


module JTAG_REC	(	//	HOST	
					oRxD_DATA,oRxD_Ready,
					//	JTAG
					TDI,TCS,TCK	);
input TDI,TCS,TCK;
output reg [7:0] oRxD_DATA;
output reg oRxD_Ready;
reg [7:0] rDATA;
reg [2:0] rCont;
always@(posedge TCK or posedge TCS)
begin
	if(TCS)
	begin
		oRxD_Ready<=0;
		rCont<=0;
	end
	else
	begin
		rCont<=rCont+1;
		rDATA<={TDI,rDATA[7:1]};
		if(rCont==0)
		begin
			oRxD_DATA<={TDI,rDATA[7:1]};
			oRxD_Ready<=1;
		end
		else
			oRxD_Ready<=0;
	end
end		
endmodule

module JTAG_TRANS(	//	HOST
					iTxD_DATA,iTxD_Start,oTxD_Done,
					//	JTAG
					TDO,TCK,TCS	);
input [7:0] iTxD_DATA;
input iTxD_Start;
output reg oTxD_Done;
input TCK,TCS;
output reg TDO;
reg [2:0] rCont;
always@(posedge TCK or posedge TCS)
begin
	if(TCS)
	begin
		oTxD_Done<=0;
		rCont<=0;
		TDO<=0;
	end
	else
	begin
		if(iTxD_Start)
		begin
			rCont<=rCont+1;
			TDO<=iTxD_DATA[rCont];
		end
		else
		begin
			rCont<=0;
			TDO<=0;
		end
		if(rCont==7)
		oTxD_Done<=1;
		else
		oTxD_Done<=0;
	end
end

endmodule
