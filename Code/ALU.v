module alu(

	input [31: 0] a,
	input [31: 0] b,
	input [3: 0] ctrl,

	output reg [0: 31] result,
	output zero_flag
	
);


	always @(*) begin
		result = 32'b0; // default assignment
		case(ctrl)
			4'b0000: result = a & b;
			4'b0001: result = a | b;
			4'b0010: result = a + b;
			4'b0110: result = a - b;
			default: result = 'b0;
		endcase
	end
	assign zero_flag = !result; // checks if the 32-bit bus is zero

endmodule 
