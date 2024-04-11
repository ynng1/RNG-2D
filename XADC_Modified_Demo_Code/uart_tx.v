module uart_tx(
    input   clk,
    input   ap_rstn,
    input   ap_ready,
    output  reg ap_vaild,
    output  reg tx,
    input  [7:0] data    
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
                fsm_next <= FSM_TRSF;
            end
            FSM_TRSF:begin 
                fsm_next <= (cnter == 3'h7) ? FSM_STOP : FSM_TRSF;
            end
            FSM_STOP:begin 
                fsm_next <= (!ap_ready) ? FSM_IDLE : FSM_STOP;
            end
            default: fsm_next <= FSM_IDLE;
        endcase
    end
end

//fsm FSM_TRSF internal cnter transfer;
always @(posedge clk, negedge ap_rstn) begin
    if(!ap_rstn) cnter <= 3'h0;
    else begin
        if (fsm_statu == FSM_TRSF)begin
            cnter <= cnter + 1'b1;
        end else begin
            cnter <= 3'h0;
        end
    end
end

//fsm output;
always @(*)begin
    if(!ap_rstn)begin
        ap_vaild <= 1'b0;
        tx <= 1'b1;
    end else begin
        case (fsm_statu)
            FSM_IDLE: begin 
                tx <= 1'b1;
            end
            FSM_STAR: begin 
                ap_vaild <= 1'b0;
                tx <= 1'b0;
            end
            FSM_TRSF: begin 
                tx <= data[cnter];
            end
            FSM_STOP: begin
                tx <= 1'b1; 
                ap_vaild <= 1'b1;
            end
        endcase
    end
end

endmodule