`timescale 1ns / 1ps

module Reg_n_bit #(parameter N=16) (
    input              clk,
    input              reset_n,
    input              load,
    input      [N-1:0] in_data,
    output reg [N-1:0] out_data
);

    always @(posedge clk, negedge reset_n) begin
        if (reset_n==0) out_data <= 0;
        else if (load) begin
            out_data <= in_data;
        end
    end

endmodule