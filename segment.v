`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2024 17:25:42
// Design Name: 
// Module Name: segment
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

module segment(
    input rstn,
    input CLK500Hz,
    input [15:0]seed_value, 
    input [3:0] digit_order,
    input [7:0] digit_val
    );
reg [13:0]randomised_value;
assign random_number = randomised_value;
always @(posedge CLK500Hz) begin 
    if (!rstn) begin  
        randomised_value = $urandom(seed_value);
    end       
end
endmodule
