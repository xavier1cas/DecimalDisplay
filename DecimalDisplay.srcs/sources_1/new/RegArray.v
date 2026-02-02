`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// THIS IS NOT A RAM!!!
// 
//////////////////////////////////////////////////////////////////////////////////

module RegArray
#(
    parameter N_ADDRESS = 3,        // Number of addresses available
    parameter N_BITS_ADDRESS = 2,   // Number of bits of the address bus
    parameter N_BITS_DATA = 4      // Numer of bits of data
)
(
    input  wire                        clk,
    input  wire                        reset_n,
    input  wire [N_BITS_ADDRESS-1:0]   r_add,
    input  wire [N_BITS_ADDRESS-1:0]   w_add,
    input  wire [N_BITS_DATA-1:0]      data_in,
    input  wire                        we,
    output reg  [N_BITS_DATA-1:0]      data_out
);

    reg [N_BITS_DATA-1:0] memory [0:N_ADDRESS-1];

    // Read Operation (combinational)
    always @(*) begin
        data_out = memory[r_add];
    end

    // Write Operation (sequential)
    always @(posedge clk, negedge reset_n) begin
        if (reset_n == 0) begin
            for (integer i = 0; i < N_ADDRESS; i++) begin
                memory[i] <= 0;
            end
        end
        else begin
            if (we == 1) memory[w_add] <= data_in;
        end
    end

endmodule
