//------------------------------------------------------------------------------
// File        : tb_counter.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Testbench for 4-bit counter.
// Functional coverage uses transition bins to verify
// correct rollover behavior from 15 back to 0.
// Waveform dumping enabled for debugging and analysis.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module tb;

    logic       clk = 0;
    logic       rst;
    logic [3:0] count;

    // DUT instantiation
    counter dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Coverage group with transition bin
    covergroup cg_count @(posedge clk);
        cp_val : coverpoint count {
            bins zero = {4'd0};
            bins max  = {4'd15};
            bins roll = (4'd15 => 4'd0); // Wrap-around check
        }
    endgroup

    cg_count cg = new();

    initial begin
        // Waveform dump
        $dumpfile("counter.vcd");
        $dumpvars(0, tb);

        // Apply reset
        rst = 1'b1;
        #20;
        rst = 1'b0;

        // Run enough cycles to force rollover
        repeat (40) @(posedge clk);

        $display("Rollover Hit? %0d",
                 cg.cp_val.roll.get_coverage());

        $finish;
    end

endmodule
