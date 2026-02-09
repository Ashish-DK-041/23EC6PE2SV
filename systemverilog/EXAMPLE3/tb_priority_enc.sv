//------------------------------------------------------------------------------
// File        : tb_priority_enc.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Testbench for 4-bit priority encoder.
// Random stimulus is applied to inputs.
// Functional coverage ensures all single-bit
// input cases are exercised.
// Waveform dumping enabled for debugging.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module tb;

    logic [3:0] in;
    logic [1:0] out;
    logic       valid;

    // DUT instantiation
    priority_enc dut (.*);

    // Coverage group
    covergroup cg_enc;
        cp_in : coverpoint in {
            bins b0 = {4'b0001};
            bins b1 = {4'b0010};
            bins b2 = {4'b0100};
            bins b3 = {4'b1000};
            bins others = default;
        }
    endgroup

    cg_enc cg = new();

    initial begin
        // Waveform dump
        $dumpfile("priority_enc.vcd");
        $dumpvars(0, tb);

        repeat (50) begin
            in = $urandom_range(0, 15);
            #5;
            cg.sample();
        end

        $display("Coverage : %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
