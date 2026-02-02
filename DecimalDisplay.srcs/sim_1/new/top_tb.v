`timescale 1ns / 1ps

`define __SIMULATION__
// `include "../../sources_1/new/top_module.v"

module top_tb();

    localparam N=16, D=5, N_BIT_DISPLAY = 5, COUNT_DISPLAY = 10, T=50;

    reg          clk=0, reset_n=1;
    reg  [N-1:0] in_binary=0;
    wire [N-1:0] LED;
    wire [7:0]   AN;
    wire [3:0]   seg_display;
    wire [6:0]   seg_out;

    wire [4*D-1:0] packed_bcd;
    
    top_module #(
        .N(N),
        .D(D),
        .N_BIT_DISPLAY(N_BIT_DISPLAY),
        .COUNT_DISPLAY(COUNT_DISPLAY)
    ) dut
    (
        .clk(clk),
        .reset_n(reset_n),
        .in_binary(in_binary),
        .LED(LED),
        .AN(AN),
        .seg_out(seg_out)
    );  

    always begin
        clk = ~clk; #(T/2);
    end

    initial begin
        in_binary = 16'h00ad; #(2*D*COUNT_DISPLAY*T); // 173
        in_binary = 16'h00a8; #(2*D*COUNT_DISPLAY*T); // 168
        in_binary = 16'h002b; #(2*D*COUNT_DISPLAY*T); // 43
        in_binary = 16'h00dc; #(2*D*COUNT_DISPLAY*T); // 220
        
        in_binary = 16'd0089; #(2*D*COUNT_DISPLAY*T);
        in_binary = 16'd0198; #(2*D*COUNT_DISPLAY*T);
        in_binary = 16'd0033; #(2*D*COUNT_DISPLAY*T);
        in_binary = 16'd0201; #(2*D*COUNT_DISPLAY*T);

        in_binary = 16'd1293; #(2*D*COUNT_DISPLAY*T);
        in_binary = 16'd2047; #(2*D*COUNT_DISPLAY*T);
        in_binary = 16'd4095; #(2*D*COUNT_DISPLAY*T);
        in_binary = 16'd65535; #(2*D*COUNT_DISPLAY*T);

        #(500*T)

        reset_n = 0; #(50*T); reset_n = 1; #(50*T);
        
        $stop;
    end

endmodule
