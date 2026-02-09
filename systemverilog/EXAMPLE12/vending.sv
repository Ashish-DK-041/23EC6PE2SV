//------------------------------------------------------------------------------
// File        : vending.sv
// Author      : ASHISH D K
// USN         : 1BM23EC041
// Created     : 2026-02-09
// Module      : vending
// Project     : SystemVerilog and Verification (23EC6PE2SV)
//
// Description :
// Vending machine FSM.
// Accepts coin values of 5 or 10.
// Dispenses item when total reaches 15.
//
// Tools Used  :
// - SystemVerilog
// - EDA Playground (Aldec Riviera)
//
//------------------------------------------------------------------------------

module vending (
    input  logic       clk,
    input  logic       rst,
    input  logic [4:0] coin,
    output logic       dispense
);

    typedef enum logic [1:0] {IDLE, HAS_5, HAS_10} state_t;
    state_t state, next;

    // State register
    always_ff @(posedge clk) begin
        if (rst)
            state <= IDLE;
        else
            state <= next;
    end

    // Next-state logic
    always_comb begin
        next     = state;
        dispense = 0;

        case (state)
            IDLE: begin
                if (coin == 5)       next = HAS_5;
                else if (coin == 10) next = HAS_10;
            end

            HAS_5: begin
                if (coin == 5)
                    next = HAS_10;
                else if (coin == 10) begin
                    dispense = 1;
                    next = IDLE;
                end
            end

            HAS_10: begin
                if (coin == 5) begin
                    dispense = 1;
                    next = IDLE;
                end
            end
        endcase
    end

endmodule
