//------------------------------------------------------------------------------
// File        : arbiter.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : arbiter
// Project     : SystemVerilog and Verification (23EC6PE2SV)
//
// Description :
// 4-request Arbiter.
// Grants access to only one requester at a time
// based on fixed priority (req[0] highest).
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------

module arbiter (
    input  logic       clk,
    input  logic       rst,
    input  logic [3:0] req,
    output logic [3:0] gnt
);

    always_ff @(posedge clk) begin
        if (rst)
            gnt <= 4'b0000;
        else if (req[0])
            gnt <= 4'b0001;
        else if (req[1])
            gnt <= 4'b0010;
        else if (req[2])
            gnt <= 4'b0100;
        else if (req[3])
            gnt <= 4'b1000;
        else
            gnt <= 4'b0000;
    end

endmodule
