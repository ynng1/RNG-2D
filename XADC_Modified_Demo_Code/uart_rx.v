module uart_rx(
    input   clk,
    input   ap_rstn,
    input   ap_ready,
    output  reg ap_vaild,
    input   rx,
    output  reg [7:0] data    
);

localparam  FSM_IDLE = 2'b00,
            FSM_STAR = 2'b01,
            FSM_TRSF = 2'b10,
            FSM_STOP = 2'b11;

reg [1:0] fsm_statu;
reg [1:0] fsm_next;
reg [2:0] cnter;

//fsm statu transfer;
always @(posedge clk, negedge ap_rstn) begin
    if (!ap_rstn)begin
        fsm_statu <= FSM_IDLE;
    end else begin
        fsm_statu <= fsm_next;
    end
end

//fsm conditional transfer;
always @(*)begin
    if(!ap_rstn)begin
        fsm_next <= FSM_IDLE;
    end else begin
        case(fsm_statu)
            FSM_IDLE:begin 
                fsm_next <= (ap_ready) ? FSM_STAR : FSM_IDLE;
            end
            FSM_STAR:begin 
                fsm_next <= (!rx) ? FSM_TRSF: FSM_STAR ;
            end
            FSM_TRSF:begin 
                fsm_next <= (cnter == 3'h7) ? FSM_STOP : FSM_TRSF;
            end
            FSM_STOP:begin 
                fsm_next <= (!ap_ready && rx) ? FSM_IDLE : FSM_STOP;
            end
            default: fsm_next <= FSM_IDLE;
        endcase
    end
end

reg [7:0] buffer;

//fsm FSM_TRSF internal cnter transfer;
always @(posedge clk, negedge ap_rstn) begin
    if(!ap_rstn) begin
        cnter <= 3'h0;
        data <= 8'h00;
    end
    else begin
        if (fsm_statu == FSM_TRSF)begin
            cnter <= cnter + 1'b1;
            buffer <= {rx,buffer[7:1]}; 
        end else if (fsm_statu == FSM_STOP)begin
            data <= buffer;  
        end else begin
            buffer <= 8'h00;
            cnter <= 3'h0;        
        end
    end
end

//fsm output;
always @(*)begin
    if(!ap_rstn)begin
        ap_vaild <= 1'b0;
    end else begin
        case (fsm_statu)
            FSM_STAR: begin 
                ap_vaild <= 1'b0;
            end
            FSM_STOP: begin
                ap_vaild <= 1'b1;
            end
            default: ;
        endcase
    end
end

endmodule