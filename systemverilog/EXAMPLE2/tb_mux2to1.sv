//------------------------------------------------------------------------------
// File        : tb_mux2to1.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : tb
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// Class-based testbench for 8-bit 2-to-1 multiplexer.
// Uses a Transaction class with randomized inputs.
// Functional coverage tracks select line values.
// Self-checking logic validates DUT output.
// Waveform dumping enabled for debugging.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


// TRANSACTION CLASS 
class Transaction;
    rand bit [7:0] a, b;
    rand bit       sel;
endclass


// TESTBENCH MODULE 
module tb;

    logic [7:0] a, b, y;
    logic       sel;

    // DUT instantiation (connect by name)
    mux2to1 dut (.*);

    // Covergroup for select line
    covergroup cg_mux;
        cp_sel : coverpoint sel {
            bins sel_0 = {0};
            bins sel_1 = {1};
        }
    endgroup

    cg_mux      cg = new();
    Transaction tr = new();

    initial begin
        // Waveform dump
        $dumpfile("mux2to1.vcd");
        $dumpvars(0, tb);

        repeat (20) begin
            // Random stimulus
            tr.randomize();
            a   = tr.a;
            b   = tr.b;
            sel = tr.sel;

            #5;
            cg.sample();

            // Self-check
            if (y !== (sel ? b : a))
                $error("Mismatch! sel=%0b a=%0h b=%0h y=%0h",
                        sel, a, b, y);
        end

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
