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
        output pio33,
        output pio34,
        output pio35,
        output pio36,
        output pio40,
        output pio41,
        output pio42,
        output pio43,
        output pio44,
        output pio45,
        output pio47,
        output pio48
);

wire rstn;
assign rstn = ~btn[1];  
wire CLK500Hz, CLK1Hz;
wire [15:0] seed;
wire [15:0] data;

//clock for 500hz and 1hz
clock_tree clock_tree_u0(sysclk, rstn, CLK500Hz, CLK1Hz);

//draw value from seed to input for random_mod
seed_in seed_in_u0(CLK1Hz, rstn, seed);

// output from seed input to random number generator; output digits 
random_mod random_mod_u0(CLK1Hz, rstn, seed, data);
 
// output of digits from random number generator to 7 segment display 
segment segment_u0(rstn,CLK500Hz,data,
{pio40,pio43,pio44,pio48},
{pio35,pio47,pio42,pio33,pio34,pio36,pio45,pio41});

endmodule
