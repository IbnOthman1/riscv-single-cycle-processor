module alu_control (
    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    input  wire       funct7,
    output reg  [3:0] ALUControl
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010; 
            2'b01: ALUControl = 4'b0110; 
            2'b10: begin
                case (funct3)
                    3'b000: ALUControl = funct7 ? 4'b0110 : 4'b0010;
                    
                    3'b110: ALUControl = 4'b0001;

                    3'b111: ALUControl = 4'b0000;

                    default: ALUControl = 4'b0010; 
                endcase
            end
            default: ALUControl = 4'b0010;
        endcase
    end
endmodule