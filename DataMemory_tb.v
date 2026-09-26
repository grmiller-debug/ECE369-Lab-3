`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
    Address = 32'h0;
    WriteData = 32'h0;
    MemWrite = 1'b0;

    @(negedge Clk);
    Address = 32'h00000000;
    WriteData = 32'hAAAA0000;
    MemWrite = 1'b1;

    @(posedge Clk);

    @(negedge Clk);
    Address = 32'h00000004;
    WriteData = 32'hBBBB0001;

    @(posedge Clk);

    @(negedge Clk);
    Address = 32'h00000FFC; 
    WriteData = 32'hCCCC0002;

    @(posedge Clk);

    @(negedge Clk);
    MemWrite = 1'b0;

    Address = 32'h00000000;
    MemRead = 1'b1;
    #5

    Address = 32'h00000004;
    #5

    Address = 32'h00000FFC;
    #5

    MemRead = 1'b0;
    #5

    $finish;

	end

endmodule

