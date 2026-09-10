module data_mem(

	input clk,
	input [31: 0] address,
	input [31: 0] write_data,
	input MemWrite,
	input MemRead,

	output [31: 0] read_data
);

	reg [31:0] memory [0:255];

	// asynchronous read
	assign read_data = (MemRead) ? memory[address[9:2]] : 32'b0; // the address is divided by 4; slot "0" holds the full 32 bits of bytes 0, 1, 2, 3
	
	// synchronous write
	always @(posedge clk) begin
        	if (MemWrite) memory[address[9:2]] <= write_data;
	end
endmodule
