module register (

	input clk,
	input RegWrite,
	input [4: 0] ReadReg1,
	input [4: 0] ReadReg2,
	input [4: 0] WriteReg,
	input [31: 0] write_data,

	output [31: 0] read_data1,
	output [31: 0] read_data2
);

	reg [31: 0] registers [0: 31]; // storage array
	
	// Asynchronous Read Logic (we need to be able to read the data immediately)
	assign read_data1 = (ReadReg1 == 'b0)? 'b0 : registers[ReadReg1];
	assign read_data2 = (ReadReg2 == 'b0)? 'b0 : registers[ReadReg2];

	// Synchronous Write Logic (to prevent a feedback loop from the ALU's O/P)
	always @(posedge clk) begin

	if (RegWrite && !(WriteReg == 'b0)) registers[WriteReg] <= write_data;
	end

endmodule
