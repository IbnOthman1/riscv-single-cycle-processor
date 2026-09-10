module instruction_mem(

	input [31: 0] read,
	output [31: 0] instruction
);

	reg [31: 0] storage [0: 255];

	initial begin
       		$readmemh("instruction.hex", storage); // can either be here or in the tb
    	end 

	assign instruction = storage[read[9:2]]; // read[9:2]: the "read" from the PC is divided by 4

endmodule
