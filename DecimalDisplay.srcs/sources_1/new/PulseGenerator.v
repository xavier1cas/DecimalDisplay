//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////


module PulseGenerator #(parameter N_BIT_COUNTER = 19, COUNT = 333333)
(
    input  wire clk,
    input  wire reset_n,
    output wire pulse
);

    reg [N_BIT_COUNTER-1:0] counter;

    // State Machine
    always @(posedge clk, negedge reset_n) begin
        if (reset_n == 0) counter <= 0;
        else begin
            if (counter < COUNT-1) counter <= counter + 1;
            else counter <= 0;
        end
    end

    // Output Machine
    assign pulse = (counter == COUNT-1) ? 1'b1 : 1'b0;

endmodule