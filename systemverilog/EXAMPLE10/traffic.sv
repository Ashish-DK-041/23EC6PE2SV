//------------------------------------------------------------------------------
// File        : traffic.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : traffic
// Project     : SystemVerilog and Verification (23EC6PE2SV)
//
// Description :
// Traffic Light Controller FSM.
// Cycles through RED → GREEN → YELLOW → RED
// on every positive clock edge.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------

typedef enum logic [1:0] {RED, GREEN, YELLOW} light_t;

module traffic (
    input  logic   clk,
    input  logic   rst,
    output light_t color
);

    always_ff @(posedge clk) begin
        if (rst)
            color <= RED;
        else begin
            case (color)
                RED    : color <= GREEN;
                GREEN  : color <= YELLOW;
                YELLOW : color <= RED;
                default: color <= RED;
            endcase
        end
    end

endmodule
