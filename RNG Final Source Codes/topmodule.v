module top_module(
        input sysclk,
        input [1:0] btn,
        output pio48,
        output pio47,
        output pio45,
        output pio44,
        output pio43,
        output pio42,
        output pio41,
        output pio40,
        output pio36,
        output pio35,
        output pio34,
        output pio33,
        output [1:0] led,
        input vp_in,
        input vn_in,
        input [1:0] xa_n,
        input [1:0] xa_p
);

wire rstn;
assign rstn = ~btn[1];
wire CLK500Hz,CLK1Hz;

clock_div clk_div_u1(rstn,sysclk,CLK500Hz);
clock_div clk_div_u2(rstn,CLK500Hz,CLK1Hz);
defparam clk_div_u1.FREQ_INPUT  = 12_000_000;
defparam clk_div_u1.FREQ_OUTPUT = 500;
defparam clk_div_u2.FREQ_INPUT  = 500;
defparam clk_div_u2.FREQ_OUTPUT = 1;

// reg [7:0] display_buffer;
reg [15:0] Segment_data;
drv_segment segment_u0(rstn,CLK500Hz,Segment_data,{pio40,pio43,pio44,pio48},{pio35,pio47,pio42,pio33,pio34,pio36,pio45,pio41});

localparam PIN15_ADDR = 8'h14;  //VAUX4;
localparam PIN16_ADDR = 8'h1C;  //VAUX12;

wire enable;                     //enable into the xadc to continuosly get data out
reg [6:0] Address_in = 7'h14;    //Adress of register in XADC drp corresponding to data
wire ready;                      //XADC port that declares when data is ready to be taken
wire [15:0] ADC_data;                //XADC data   
        
xadc_wiz_0 xadc_u0
(
    .daddr_in(PIN16_ADDR),        // Address bus for the dynamic reconfiguration port
    .dclk_in(sysclk),             // Clock input for the dynamic reconfiguration port
    .den_in(enable),              // Enable Signal for the dynamic reconfiguration port
    .di_in(0),                    // Input data bus for the dynamic reconfiguration port
    .dwe_in(0),                   // Write Enable for the dynamic reconfiguration port
    .vauxp12(xa_p[1]),
    .vauxn12(xa_n[1]),
    .vauxp4(xa_p[0]),
    .vauxn4(xa_n[0]),  
    .busy_out(),                 // ADC Busy signal
    .channel_out(),              // Channel Selection Outputs
    .do_out(ADC_data),           // Output data bus for dynamic reconfiguration port
    .drdy_out(ready),            // Data ready signal for the dynamic reconfiguration port
    .eoc_out(enable),            // End of Conversion Signal
    .vp_in(vp_in),               // Dedicated Analog Input Pair
    .vn_in(vn_in)
);

always @(posedge CLK1Hz) begin
    Segment_data <= ADC_data;
end

endmodule