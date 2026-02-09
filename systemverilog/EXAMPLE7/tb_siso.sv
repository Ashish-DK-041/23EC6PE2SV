//------------------------------------------------------------------------------
// File        : tb_siso.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Testbench for 4-bit SISO shift register.
// A reference model (q_ref) is maintained in the testbench
// to predict the expected behavior of the DUT.
// The DUT output is compared against the reference output
// on every clock cycle to verify correctness.
// Waveform dumping enabled for analysis.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module tb;

    logic clk = 0;
    logic si, so;

    // DUT instantiation
    siso dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Reference model
    logic [3:0] q_ref = 4'b0000;

    initial begin
        // Waveform dump
        $dumpfile("siso.vcd");
        $dumpvars(0, tb);

        repeat (20) begin
            si = $urandom % 2;

            // Update reference model
            q_ref = {q_ref[2:0], si};

            @(posedge clk);
            #1;

            // Self-check using reference logic
            if (so !== q_ref[3]) begin
                $error("Mismatch! si=%0b expected_so=%0b actual_so=%0b",
                        si, q_ref[3], so);
            end
        end

        $finish;
    end

endmodule
