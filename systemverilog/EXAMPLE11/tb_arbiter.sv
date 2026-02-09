//------------------------------------------------------------------------------
// File        : tb_arbiter.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Testbench for Arbiter demonstrating assertions.
// Uses $onehot0 assertion to ensure that
// multiple grants are never issued simultaneously.
// Waveform dumping enabled.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------

module tb;

    logic clk = 0;
    logic rst;
    logic [3:0] req;
    logic [3:0] gnt;

    always #5 clk = ~clk;

    // DUT
    arbiter dut (.*);

    // Assertion: At most one grant bit may be high
    property p_onehot_grant;
        @(posedge clk) $onehot0(gnt);
    endproperty

    assert property (p_onehot_grant)
        else $error("Protocol Violation: Multiple Grants Detected!");

    initial begin
        // Waveform dump
        $dumpfile("arbiter.vcd");
        $dumpvars(0, tb);

        // Reset
        rst = 1;
        req = 0;
        @(posedge clk);
        rst = 0;

        // Random requests
        repeat (20) begin
            req = $urandom_range(0, 15);
            @(posedge clk);
        end

        $display("Simulation completed without assertion failure.");
        $finish;
    end

endmodule
