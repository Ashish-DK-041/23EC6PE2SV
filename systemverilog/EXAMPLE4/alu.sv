//------------------------------------------------------------------------------
// File        : alu.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : alu
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description :
// This module implements an 8-bit Arithmetic Logic Unit (ALU).
// Supported operations are ADD, SUB, AND, and OR.
// Enumerated type is used for opcode selection to improve
// readability and enable easy randomization during verification.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------


// Enumerated opcode definition
typedef enum bit [1:0] {ADD, SUB, AND, OR} opcode_e;


// ---------------- ALU DESIGN ----------------
module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  opcode_e    op,
    output logic [7:0] y
);

    always_comb begin
        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            AND: y = a & b;
            OR : y = a | b;
            default: y = 8'h00;
        endcase
    end

endmodule
