//------------------------------------------------------------------------------
// File        : tb_and_gate.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// This is the testbench for the 2-input AND gate module.
// The testbench instantiates the DUT using named port
// connections and applies randomized input combinations.
// A covergroup is used to measure functional coverage
// of all possible input combinations (a, b).
// Waveform dumping and coverage reporting are included
// for simulation analysis using EDA Playground.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module tb;

    logic a, b, y;

    // DUT instantiation (connect by name)
    and_gate dut (.*);

    // Covergroup defines what we want to measure
    covergroup cg_and;
        cp_a     : coverpoint a;
        cp_b     : coverpoint b;
        cross_ab : cross cp_a, cp_b;
    endgroup

    cg_and cg;

    initial begin
        // Waveform dump
        $dumpfile("and_gate.vcd");
        $dumpvars(0, tb);

        cg = new();   // Create covergroup instance

        repeat (20) begin
            a = $urandom % 2;   // Randomize inputs
            b = $urandom % 2;
            #5;                 // Allow propagation delay
            cg.sample();        // Sample coverage
        end

        $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
