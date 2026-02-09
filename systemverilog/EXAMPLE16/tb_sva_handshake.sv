//------------------------------------------------------------------------------
// File        : tb_sva_handshake.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Example 16: SVA Temporal Sequences.
// Verifies timing behavior using concurrent assertions.
// If req is asserted, gnt must be asserted exactly
// 2 clock cycles later.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------

module tb;

    bit clk = 0;
    bit req = 0;
    bit gnt = 0;

    // Clock generation
    always #5 clk = ~clk;

    // Waveform dump
    initial begin
        $dumpfile("sva_handshake.vcd");
        $dumpvars(0, tb);
    end

    // ---------------- SVA PROPERTY ----------------
    property p_handshake;
        @(posedge clk) req |=> ##2 gnt;
    endproperty

    // Assertion
    assert property (p_handshake)
        else $error("Protocol Fail: gnt did not assert 2 cycles after req");

    // ---------------- STIMULUS ----------------
    initial begin
        @(posedge clk);
        req <= 1'b1;

        @(posedge clk);
        req <= 1'b0;

        // Exactly 2 cycles after req
        @(posedge clk);
        @(posedge clk);
        gnt <= 1'b1;

        #20;
        $finish;
    end

endmodule
