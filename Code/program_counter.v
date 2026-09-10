module pc(

	input clk,
	input rst,
	input [31: 0] pc_next,

	output reg [31: 0] pc_current
);

	always @(posedge clk or negedge rst) begin

	if(!rst) pc_current <= 'b0;
	else pc_current <= pc_next;

	end

endmodule
