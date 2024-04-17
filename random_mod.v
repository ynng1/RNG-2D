`timescale 1ns / 1ps

module random_mod(
    input clk,     
    input rstn,     
    input [15:0] seed, 
    output reg [15:0] data 
);
reg feedback;
reg [15:0] state; 

always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        state <= seed; 
        data <= 16'b0; 
    end
    else begin
        feedback = (state[0] ^ state[2] ^ state[3] ^ state[5]);
        
        state <= {feedback, state[15:1]};
        data <= state; 
    end
end

endmodule
