`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2024 17:23:01
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_module(
        input sysclk,
        input [1:0] btn,
        output pio37,
        output pio38,
        output pio39,
        output pio40,
        output pio41,
        output pio42,
        output pio43,
        output pio44,
        output pio45,
        output pio46,
        output pio47,
        output pio48
);

wire rstn;
assign rstn = ~btn[1];  
wire CLK500Hz, CLK1Hz;
wire [15:0] seed;
wire [15:0] data;

// output from seed input to random number generator; output digits 
random_mod random_mod_u0(CLK500Hz, rstn, seed_value, data);
 
// output of digits from random number generator to 7 segment display 
segment segment_u0(rstn,CLK500Hz,data,
{pio43,pio46,pio47,pio37},
{pio40,pio38,pio45,pio42,pio41,pio39,pio48,pio44});

endmodule
