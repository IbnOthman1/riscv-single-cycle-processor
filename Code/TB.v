module tb_riscv_top;

    reg CLK;
    reg RST;

    wire [31:0] PC;
    wire [31:0] INSTR;

    wire [31:0] Data_mem_read;
    wire [31:0] Data_mem_add;
    wire [31:0] Data_mem_write;
    wire        Data_mem_En;
    wire        Data_mem_Read;

    instruction_mem u_instr_mem (
        .read        (PC),
        .instruction(INSTR)
    );

    riscv_top dut (
        .CLK           (CLK),
        .RST           (RST),
        .INSTR         (INSTR),
        .PC            (PC),
        .Data_mem_read (Data_mem_read),
        .Data_mem_add  (Data_mem_add),
        .Data_mem_write(Data_mem_write),
        .Data_mem_En   (Data_mem_En),
        .Data_mem_Read (Data_mem_Read)
    );

    data_mem u_data_mem (
        .clk       (CLK),
        .address   (Data_mem_add),
        .write_data(Data_mem_write),
        .MemWrite  (Data_mem_En),
        .MemRead   (Data_mem_Read),
        .read_data (Data_mem_read)
    );

    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RST = 0;
        
        u_data_mem.memory[0] = 32'd5;
        u_data_mem.memory[1] = 32'd3;
        #10;
        
        RST = 1;
        #50
        RST = 0;
        #3
        RST =1;

        #220;

        $finish;
    end

endmodule