module control_unit(
    input [31:0] instruction,
    input clk,
    input reset,
    input hazard_detected,
    input [2:0] hazard_stage,
    input branch_taken,
    input [2:0] branch_stage,
    output reg [2:0] OperationCode,
    output reg RegSelect,
    output reg SecondOperand,
    output reg MemToRegSelect,
    output reg RegWriteEnable,
    output reg ReadEnable,
    output reg WriteEnable,
    output reg Branching,
    output reg Jumping,
    output reg EqualBranch,
    output reg ShiftEnable,
    output reg condX,
    output reg stall_fetch,
    output reg stall_decode,
    output reg stall_execute,
    output reg stall_memory,
    output reg stall_writeback,
    output reg flush_fetch,
    output reg flush_decode,
    output reg flush_execute,
    output reg flush_memory,
    output reg flush_writeback
    );

    always @(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
            // Reset all signals
            OperationCode <= 3'b000;
            RegSelect <= 1'b0;
            SecondOperand <= 1'b0;
            MemToRegSelect <= 1'b0;
            RegWriteEnable <= 1'b0;
            ReadEnable <= 1'b0;
            WriteEnable <= 1'b0;
            Branching <= 1'b0;
            Jumping <= 1'b0;
            EqualBranch <= 1'b0;
            ShiftEnable <= 1'b0;
            condX <= 1'b0;
            stall_fetch <= 1'b0;
            stall_decode <= 1'b0;
            stall_execute <= 1'b0;
            stall_memory <= 1'b0;
            stall_writeback <= 1'b0;
            flush_fetch <= 1'b0;
            flush_decode <= 1'b0;
            flush_execute <= 1'b0;
            flush_memory <= 1'b0;
            flush_writeback <= 1'b0;
        end
        else 
        begin
            // Defaults
            OperationCode <= 3'b000;
            RegSelect <= 1'b0;
            SecondOperand <= 1'b0;
            MemToRegSelect <= 1'b0;
            RegWriteEnable <= 1'b0;
            ReadEnable <= 1'b0;
            WriteEnable <= 1'b0;
            Branching <= 1'b0;
            Jumping <= 1'b0;
            EqualBranch <= 1'b0;
            ShiftEnable <= 1'b0;
            condX <= 1'b0;

            // Stall control
            if (hazard_detected) 
            begin
                case(hazard_stage)
                    3'b001: stall_fetch <= 1'b1;
                    3'b010: stall_decode <= 1'b1;
                    3'b011: stall_execute <= 1'b1;
                    3'b100: stall_memory <= 1'b1;
                    3'b101: stall_writeback <= 1'b1;
                    default: ;
                endcase
            end

            // Flush control
            if (branch_taken) 
            begin
                case(branch_stage)
                    3'b001: flush_fetch <= 1'b1;
                    3'b010: flush_decode <= 1'b1;
                    3'b011: flush_execute <= 1'b1;
                    3'b100: flush_memory <= 1'b1;
                    3'b101: flush_writeback <= 1'b1;
                    default: ;
                endcase
            end

            case (instruction[31:26]) // Directly decoding opcode from instruction
                // CMP
                6'b001111: 
                begin
                    OperationCode <= 3'b001;
                    SecondOperand <= 1'b0;
                    if(instruction[31:28] == 4'b0000 || instruction[31:28] == 4'b0001)  // EQ or NE
                        condX <= 1'b1;
                end

                // ADD
                6'b001000: 
                begin
                    OperationCode <= 3'b000;
                    RegSelect <= 1'b1;
                    SecondOperand <= 1'b0;
                    RegWriteEnable <= 1'b1;
                    ShiftEnable <= 1'b1;
                    if(instruction[31:28] == 4'b1110)  // AL
                        condX <= 1'b1;
                end

                // Other instructions here...
                // Please replace with your actual opcodes and control signals.
            endcase
        end
    end
endmodule
