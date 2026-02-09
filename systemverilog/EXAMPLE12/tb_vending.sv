//------------------------------------------------------------------------------
// File        : tb_vending.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Testbench for vending machine FSM.
// Randomizes coin inputs (5 or 10).
// Uses whitebox coverage on internal FSM state.
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
    logic [4:0] coin;
    logic dispense;

    always #5 clk = ~clk;

    // DUT
    vending dut (.*);

    // Whitebox coverage (NO explicit enum bins — IMPORTANT)
    covergroup cg_vend @(posedge clk);
        cp_state : coverpoint dut.state;
    endgroup

    cg_vend cg = new();

    initial begin
        // Waveform dump
        $dumpfile("vending.vcd");
        $dumpvars(0, tb);

        // Reset
        rst = 1;
        coin = 0;
        @(posedge clk);
        rst = 0;

        // Random coin input: 5 or 10
        repeat (30) begin
            coin = ($urandom_range(0,1)) ? 5 : 10;
            @(posedge clk);
        end

        $display("Vending FSM Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
