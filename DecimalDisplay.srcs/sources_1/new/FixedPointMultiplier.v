`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Universidad San Francisco de Quito
// Engineer:        Xavier Casanova
// 
// Create Date:     10/14/2024 01:42:03 PM
// Design Name: 
// Module Name:     FixedPointDivider
// Project Name:    FloatingPoint
// Target Devices:  Zybo Z720
// Tool Versions:   Xilinx 2022.2
// Description:    
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module FixedPointMultiplier #(parameter N = 27, Q = 20) (
    input   [N-1:0] op1,
    input   [N-1:0] op2,
    output  [N-1:0] result,
    output          overflow
);
    wire [2*N-1:0]  scaled_result; // Multiplication of values of N bits, requires a 2*N bit value
    wire [N-1:0]    op1_n, op2_n, multiplicand, multiplier;
    wire [N-1:0]    q, q_n;
    wire            sign_bit;

    // The multiplication is performed on positive numbers
    assign op1_n = ~op1 + 1'b1;
    assign op2_n = ~op2 + 1'b1;

    assign multiplicand = op1[N-1] ? op1_n : op1;
    assign multiplier   = op2[N-1] ? op2_n : op2;

    // Perform integer multiplication keeping the sign bit
    assign sign_bit         = op1[N-1] ^ op2[N-1];
    assign scaled_result    = multiplicand[N-2:0] * multiplier[N-2:0];

    // {sign bit, 6 (N-Q-1) above decimal, 20 (Q) below decimal}} 
    assign q   =  scaled_result[N + Q - 2:Q];        // Q*2 + N-Q - 2 = N + Q - 2
    assign q_n = ~scaled_result[N + Q - 2:Q] + 1'b1;

    // Choose the right result
    assign result   = sign_bit ? q_n : q;
    assign overflow = (scaled_result[2*N-1:N-1+Q] > 0) ? 1'b1 : 1'b0;

endmodule