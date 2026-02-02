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


module FixedPointDivider #(parameter N = 27, Q = 20) (
    input  [N-1:0] op1,
    input  [N-1:0] op2,
    output [N-1:0] result,
    output         zero_div
);

    // Scale the numerator by 2^N (shift left by N)
    wire [2*N-1:0]  scaled_numerator, scaled_result;
    wire [N-1:0]    op1_n, op2_n, numerator, denominator;
    wire [N-1:0]    q, q_n;
    wire            sign_bit;

    // The division is performed on positive numbers
    assign op1_n = ~op1 + 1'b1;
    assign op2_n = ~op2 + 1'b1;

    assign numerator   = op1[N-1] ? op1_n : op1;
    assign denominator = op2[N-1] ? op2_n : op2;

    // Perform division
    assign sign_bit         = op1[N-1] ^ op2[N-1];
    assign scaled_numerator = {numerator, {Q{1'b0}}};                   // numerator << Q

    assign scaled_result = scaled_numerator / {{Q{1'b0}}, denominator}; // num*2^Q / den
    assign zero_div = (denominator != 0) ? 1'b0 : 1'b1;                 // Check for division by zero

    // Scale the result back to the fixed-point format (shift right by N)
    assign q   =  scaled_result[N - 1:0];        // Q*2 + N-Q - 2 = N + Q - 2
    assign q_n = ~scaled_result[N - 1:0] + 1'b1;

    // Choose the right result
    assign result = sign_bit ? q_n : q;


endmodule
