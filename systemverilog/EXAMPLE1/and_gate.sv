//------------------------------------------------------------------------------
// File        : and_gate.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-01-30
// Module      : and_gate
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// This module implements a simple 2-input AND gate.
// The output `y` is asserted high only when both inputs
// `a` and `b` are logic high. This design is intended
// for basic digital logic demonstration and verification
// using a corresponding testbench.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module and_gate (
    input  logic a,
    input  logic b,
    output logic y
);
    assign y = a & b;
endmodule
