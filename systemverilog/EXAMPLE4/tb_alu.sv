//------------------------------------------------------------------------------
// File        : tb_alu.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Testbench for 8-bit ALU using enumerated opcodes.
// Random stimulus is applied to inputs and opcode.
// Functional coverage automatically tracks all enum values.
// Waveform dumping is enabled for simulation analysis.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module tb;

    logic [7:0] a, b, y;
    opcode_e    op;

    // DUT instantiation
    alu dut (.*);

    // Coverage group for opcode
    covergroup cg_alu;
        cp_op : coverpoint op; // Tracks ADD, SUB, AND, OR
    endgroup

    cg_alu cg = new();

    initial begin
        // Waveform dump
        $dumpfile("alu.vcd");
        $dumpvars(0, tb);

        repeat (50) begin
            a  = $urandom;
            b  = $urandom;
            op = opcode_e'($urandom_range(0, 3)); // Random enum value
            #5;
            cg.sample();
        end

        $display("Coverage : %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
