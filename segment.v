`timescale 1ns / 1ps

module segment(
    input rstn,
    input CLK500Hz,
    input [15:0]seed_value, 
    input [3:0] digit_order,
    input [7:0] digit_val
    );
reg [7:0] segment_r;
reg [3:0] an_r;
reg [3:0] cur_num_r;   
assign digit_val = ~ segment_r;
assign digit_order = ~an_r;

always @(negedge rstn,posedge CLK500Hz)begin
    if(!rstn)begin
        an_r <= 4'b0000;    //When system reset, empty all display;
    end
    else begin
        case(an_r)                  
        4'b0001: an_r <= 4'b0010;   //DISPLAY ON DIG3
        4'b0010: an_r <= 4'b0100;   //DISPLAY ON DIG2
        4'b0100: an_r <= 4'b1000;   //DISPLAY ON DIG1
        default: an_r <= 4'b0001;   //DISPLAY ON DIG4
        endcase
    end
end

always @(an_r,seed_value)begin
    case(an_r)
        4'b0001: cur_num_r <= seed_value[3:0];
        4'b0010: cur_num_r <= seed_value[7:4];
        4'b0100: cur_num_r <= seed_value[11:8];
        4'b1000: cur_num_r <= seed_value[15:12];
        default: cur_num_r <= 4'b0;
    endcase    
end

always @(cur_num_r) begin
    case(cur_num_r)
        4'h0:segment_r <= 8'hc0;    //NUM "0"
        4'h1:segment_r <= 8'hf9;    //NUM "1"
        4'h2:segment_r <= 8'ha4;    //NUM "2"
        4'h3:segment_r <= 8'hb0;    //NUM "3"
        4'h4:segment_r <= 8'h99;    //NUM "4"
        4'h5:segment_r <= 8'h92;    //NUM "5"
        4'h6:segment_r <= 8'h82;    //NUM "6"
        4'h7:segment_r <= 8'hF8;    //NUM "7"
        4'h8:segment_r <= 8'h80;    //NUM "8"
        4'h9:segment_r <= 8'h90;    //NUM "9"
        4'ha:segment_r <= 8'h88;    //NUM "A" - HEX NUMBER DISPLAY
        4'hb:segment_r <= 8'h83;    //NUM "b"
        4'hc:segment_r <= 8'hc6;    //NUM "C"
        4'hd:segment_r <= 8'ha1;    //NUM "D"
        4'he:segment_r <= 8'h86;    //NUM "E"
        4'hf:segment_r <= 8'h8e;    //NUM "F"
        default: segment_r <= 8'hff;
    endcase
end
endmodule
