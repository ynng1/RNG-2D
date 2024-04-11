`timescale 1ns / 1ps

module random_mod(
    input clk,
    input rst_n,
    input [15:0] seed,
    output reg [15:0] data
);
    reg [15:0] data_next;

always @* begin
    data_next[15] = data[15] ^ data[1];
    data_next[14] = data[14] ^ data[0];
    data_next[13] = data[13] ^ data_next[15];
    data_next[12] = data[12] ^ data_next[14];
    data_next[11] = data[11] ^ data_next[13];
    data_next[10] = data[10] ^ data_next[12];
    data_next[9] = data[9] ^ data_next[11];
    data_next[8] = data[8] ^ data_next[10];
    data_next[7] = data[7] ^ data_next[9];
    data_next[6] = data[6] ^ data_next[8];
    data_next[5] = data[5] ^ data_next[7];
    data_next[4] = data[4] ^ data_next[6];
    data_next[3] = data[3] ^ data_next[5];
    data_next[2] = data[2] ^ data_next[4];
    data_next[1] = data[1] ^ data_next[3];
    data_next[0] = data[0] ^ data_next[2];  
end

always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
        data <= seed;
    end
    else begin
        data <= data_next;
    end
endmodule

