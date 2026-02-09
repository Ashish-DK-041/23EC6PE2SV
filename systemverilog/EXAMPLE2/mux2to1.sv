//------------------------------------------------------------------------------
// File        : mux2to1.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : mux2to1
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// This module implements an 8-bit 2-to-1 multiplexer.
// When select (sel) is 0, output y follows input a.
// When select (sel) is 1, output y follows input b.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//


module mux2to1 (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic       sel,
    output logic [7:0] y
);
    assign y = sel ? b : a;
endmodule
