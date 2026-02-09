//------------------------------------------------------------------------------
// File        : tb_traffic.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Testbench for Traffic Light Controller.
// Demonstrates sequence bins to verify correct
// light transition order:
// RED → GREEN → YELLOW → RED.
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
    light_t color;

    always #5 clk = ~clk;

    // DUT
    traffic dut (
        .clk   (clk),
        .rst   (rst),
        .color (color)
    );

    // Sequence coverage
    covergroup cg_light @(posedge clk);
        cp_color : coverpoint color {
            bins cycle = (RED => GREEN => YELLOW => RED);
        }
    endgroup

    cg_light cg = new();

    initial begin
        // Waveform dump
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb);

        // Reset
        rst = 1;
        @(posedge clk);
        rst = 0;

        // Run enough cycles to hit sequence
        repeat (10) @(posedge clk);

        $display("Traffic Light Sequence Coverage = %0.2f %%", 
                 cg.get_inst_coverage());

        $finish;
    end

endmodule
