`timescale 1ns / 1ps

module random_mod_tb();
    reg clk;            // Clock input
    reg rst_n;          // Reset input
    reg [15:0] seed;    // Seed value input (16-bit)
    wire [15:0] data;   // Output value (16-bit)
    
random_mod random_mod_u0(
    .clk(clk),
    .rst_n(rst_n),
    .seed(seed),
    .data(data)
);

initial clk = 0;
always #5 clk = !clk;

initial begin
    rst_n = 1'b0;
    seed = 16'd5555;
    repeat(5) begin 
        #5 rst_n = 1'b1;
        #50 rst_n = 1'b0;
    end
    #10 $stop;
end

endmodule