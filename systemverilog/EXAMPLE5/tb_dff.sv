//------------------------------------------------------------------------------
// File        : tb_dff.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Constraint-based testbench for D Flip-Flop.
// Reset is randomized using distribution constraints
// to be active only 10% of the time, ensuring realistic
// verification of the data path.
// Functional coverage samples reset and data combinations
// on the rising edge of the clock.
// Waveform dumping enabled for analysis.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


// ---------------- TRANSACTION CLASS ----------------
class packet;
    rand bit d;
    rand bit rst;

    // Reset active only 10% of the time
    constraint c1 {
        rst dist {0 := 90, 1 := 10};
    }
endclass


// ---------------- TESTBENCH MODULE ----------------
module tb;

    logic clk = 0;
    logic rst, d, q;

    // DUT instantiation
    dff dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Coverage sampled on rising edge of clock
    covergroup cg @(posedge clk);
        cross_rst_d : cross rst, d;
    endgroup

    cg     c_inst = new();
    packet pkt    = new();

    initial begin
        // Waveform dump
        $dumpfile("dff.vcd");
        $dumpvars(0, tb);

        repeat (100) begin
            pkt.randomize();
            rst <= pkt.rst;
            d   <= pkt.d;
            @(posedge clk);
        end

        $display("Coverage : %0.2f %%", c_inst.get_inst_coverage());
        $finish;
    end

endmodule
