module main_controller (
    input  wire [6:0] opcode,
    output reg        Branch,
    output reg        MemRead,
    output reg        MemToReg,
    output reg [1:0]  ALUOp,
    output reg        MemWrite,
    output reg        ALUSrc,
    output reg        RegWrite
);
    always @(*) begin
        Branch   = 1'b0;
        MemRead  = 1'b0;
        MemToReg = 1'b0;
        ALUOp    = 2'b00;
        MemWrite = 1'b0;
        ALUSrc   = 1'b0;
        RegWrite = 1'b0;

        case (opcode)
            // R-type
            7'b0110011: begin
                RegWrite = 1'b1;
                ALUOp    = 2'b10;
            end
            // I-type
            7'b0000011: begin
                ALUSrc   = 1'b1;
                MemToReg = 1'b1;
                RegWrite = 1'b1;
                MemRead  = 1'b1;
                ALUOp    = 2'b00;
            end
            // S-type
            7'b0100011: begin
                ALUSrc   = 1'b1;
                MemWrite = 1'b1;
                ALUOp    = 2'b00;
            end
            // B-type
            7'b1100011: begin
                Branch   = 1'b1;
                ALUOp    = 2'b01;
            end
        endcase
    end

endmodule
