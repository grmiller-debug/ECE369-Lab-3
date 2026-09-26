`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;


	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
		//initialize to 0
    	RegWrite = 0; 
		WriteRegister = 0; 
		WriteData = 0;
		ReadRegister1 = 0; 
		ReadRegister2 = 0;

		// Write registers 8-25 with 0x100 + register number
		for (r = 8; r <= 25; r = r + 1) begin
			@(negedge Clk);
			RegWrite = 1; 
			WriteRegister = r; 
			WriteData = 32'h100 + r;
		end
		@(negedge Clk);

		// should ignore regwrite=0
		RegWrite = 0; 
		WriteRegister = 8; 
		WriteData = 32'hABCDABCD;
		@(negedge Clk);

		// ignore writing register 0 
		RegWrite = 1; 
		WriteRegister = 0; 
		WriteData = 32'hFFFFFFFF;
		@(negedge Clk);
		RegWrite = 0;

		// read back 2 at a time
		for (r = 8; r <= 25; r = r + 2) begin
			ReadRegister1 = r; 
			ReadRegister2 = r + 1;
			@(negedge Clk); #1;
			$display("R%0d = %h  R%0d = %h", ReadRegister1, ReadData1, ReadRegister2, ReadData2);
		end
		ReadRegister1 = 0; 
		ReadRegister2 = 8;
		@(negedge Clk); #1;
		$finish;
	
	end

endmodule
