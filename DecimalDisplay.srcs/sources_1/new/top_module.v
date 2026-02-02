`timescale 1ns / 1ps

module top_module #(parameter N=16, D=5, N_BIT_DISPLAY=19, COUNT_DISPLAY=333333) (
    input  wire         clk,
    input  wire         reset_n,
    input  wire [N-1:0] in_binary,
    output wire [N-1:0] LED,
    output wire   [7:0] AN,
    output wire   [6:0] seg_out
);
    wire [4*D-1:0] packed_bcd;
    wire     [3:0] BCD;
    wire   [D-1:0] AN_tmp;
    wire           pulse_display_enable;
    
    Binary2BCD #(.N(N), .D(D)) B2BCD (
        .in_binary  (in_binary),
        .packed_bcd (packed_bcd)
    );

    PulseGenerator #(.N_BIT_COUNTER(N_BIT_DISPLAY), .COUNT(COUNT_DISPLAY)) FREQ_GENERATOR (
        .clk        (clk),
        .reset_n    (reset_n),
        .pulse      (pulse_display_enable)
    );
    
    DisplayController #(.N(N), .D(D)) DISP_CONTROLLER(
        .clk            (clk),
        .reset_n        (reset_n),
        .display_enable (pulse_display_enable),
        .packed_bcd     (packed_bcd),
        .AN             (AN_tmp),
        .out_segment    (BCD)
    );

    SevenSegDec DECO_7_SEG (
        .BCD        (BCD),
        .seg_out    (seg_out)
    );

    assign AN = {{(8-D){1'b1}}, AN_tmp};
    assign LED = in_binary;

endmodule