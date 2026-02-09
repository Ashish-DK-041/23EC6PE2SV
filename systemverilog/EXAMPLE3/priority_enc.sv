//------------------------------------------------------------------------------
// File        : priority_enc.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : priority_enc
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// This module implements a 4-bit priority encoder.
// The highest-order bit has the highest priority.
// Output `out` encodes the position of the highest
// asserted input bit. Output `valid` indicates whether
// any input bit is high.
//
// Priority Order: in[3] > in[2] > in[1] > in[0]
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module priority_enc (
    input  logic [3:0] in,
    output logic [1:0] out,
    output logic       valid
);

    always_comb begin
        valid = 1'b1;
        if      (in[3]) out = 2'b11;
        else if (in[2]) out = 2'b10;
        else if (in[1]) out = 2'b01;
        else if (in[0]) out = 2'b00;
        else begin
            out   = 2'b00;
            valid = 1'b0;
        end
    end

endmodule
