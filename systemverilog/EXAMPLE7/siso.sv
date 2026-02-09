//------------------------------------------------------------------------------
// File        : siso.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : siso
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// This module implements a 4-bit Serial-In Serial-Out (SISO)
// shift register. On every rising edge of the clock, the input
// bit `si` is shifted into the register. The output `so` reflects
// the most significant bit of the shift register.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


module siso (
    input  logic clk,
    input  logic si,
    output logic so
);

    logic [3:0] q;

    assign so = q[3];

    always_ff @(posedge clk) begin
        q <= {q[2:0], si};
    end

endmodule
