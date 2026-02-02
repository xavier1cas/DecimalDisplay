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


module FixedPointAdder #(parameter N = 32) (
    input  [N-1:0] add1,
    input  [N-1:0] add2,
    output [N-1:0] sum
);
    // Perform addition
    assign sum = add1 + add2;

    // Note: No scaling needed since we assume operands are already in fixed-point format
endmodule