`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2024 17:26:11
// Design Name: 
// Module Name: seed_in
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

module seed_in(
    input CLK500Hz,
    input rstn,
    output reg [15:0]seed
    );
    
always @* begin 
    seed = 16'd8808;
end

endmodule
