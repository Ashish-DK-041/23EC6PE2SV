//------------------------------------------------------------------------------
// File        : counter.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : counter
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// This module implements a 4-bit up-counter with synchronous
// active-high reset. The counter increments on every rising
// edge of the clock and wraps around from 15 to 0.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module counter (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (rst)
            count <= 4'b0000;
        else
            count <= count + 1'b1;
    end

endmodule
