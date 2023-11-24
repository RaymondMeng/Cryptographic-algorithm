`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/21 17:51:37
// Design Name: 
// Module Name: DES_top
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

module DES_top (
    input      [63:0] din,
    input             clk,
    input             start,
    input             rst_n,
    input             mode, //0:加密 1:解密
    input      [63:0] key_din,
    output reg [63:0] dout,
    output            dat_valid
);

wire [63:0] permu_init_out;
wire [4:0]  cnt_out;
reg         cnt_end;
wire [31:0] f_out;
wire [31:0] R_dat_out, L_dat_out;
wire [47:0] round_key_out;
reg  [31:0] L_init, R_init;
// wire [63:0] plain_text, cipher_text;
reg  [63:0] Permutation_init_din, Permutation_inverse_din;
wire [63:0] Permutation_init_dout, Permutation_inverse_dout;
reg  [4:0]  keygen_cnt;
reg  [4:0]  cnt;
reg         start_d;
reg         cnt_start;
wire        start_valid;


reg  [1:0] state, next_state;
localparam [1:0] IDLE = 3'b000, ENCRY = 3'b001, DECRY = 3'b011;

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = mode ? DECRY : ENCRY;
        DECRY: next_state = mode ? DECRY : ENCRY;
        ENCRY: next_state = mode ? DECRY : ENCRY; 
        default: next_state = IDLE;
    endcase
end

always @(*) begin
    if (state == DECRY && cnt_start) begin
        dout = Permutation_init_dout;
        Permutation_inverse_din = din;
        Permutation_init_din = {L_dat_out, R_dat_out};
        {L_init, R_init} = Permutation_inverse_dout;
        keygen_cnt = 'd19 - cnt_out;
    end
    else if (state == ENCRY && cnt_start)begin
        dout = Permutation_inverse_dout;
        Permutation_init_din = din;
        Permutation_inverse_din = {L_dat_out, R_dat_out};
        {L_init, R_init} = Permutation_init_dout;
        keygen_cnt = cnt_out;
    end
    else begin
        dout = 'd0;
        Permutation_init_din = 'd0;
        Permutation_inverse_din = 'd0;
        {L_init, R_init} = 'd0;
        keygen_cnt = 'd0;
    end
end

assign start_valid = start & ~start_d;
always @(posedge clk) begin
    start_d <= start;
end

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        cnt <= 'd0;
        cnt_end <= 1'b0;
    end
    else begin
        if (cnt_start == 1'b1) begin
            if(cnt < 'd17) begin
                cnt <= cnt + 1'b1;
                cnt_end <= (cnt == 'd16);
            end
            else begin
                cnt_end <= 1'b1;
                cnt <= cnt;
            end
        end
        else begin
            cnt_end <= 1'b0;
            cnt <= 'd0;
        end
    end
end
assign cnt_out = cnt;
//assign cnt_start = cnt_end ? 1'b0 : ((start_d == 1'b1 && cnt_end == 1'b0) ? 1'b1 : cnt_start);
always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        cnt_start <= 1'b0;
    end
    else begin
        if (cnt_end) begin
            cnt_start <= 1'b0;
        end
        else if (start_d == 1'b1 && cnt_end == 1'b0) begin
            cnt_start <= 1'b1;
        end
        else begin
            cnt_start <= cnt_start;
        end
    end 
end

// assign Permutation_init_din = (state == DECRY) ? {L_dat_out, R_dat_out} : ((state == ENCRY) ? plain_text : 'd0);
// assign Permutation_init_dout = ()

Permutation_init Permutation_init_inst(
    .dat_in(Permutation_init_din),
    .dat_out(Permutation_init_dout)
);

Round round_inst(
    .R_dat(R_dat_out),
    .key_dat(round_key_out),
    .f_out(f_out)
);

mux mux_inst(
    .clk(clk),
    .rst_n(rst_n),
    .f_out(f_out),
    .L_init(L_init),
    .R_init(R_init),
    .cnt(cnt_out),
    .R_dat(R_dat_out),
    .L_dat(L_dat_out),
    .lst_valid(dat_valid)
);

Permutation_inverse Permutation_inverse_inst(
    .dat_in(Permutation_inverse_din),
    .dat_out(Permutation_inverse_dout)
);

keygen keygen_inst(
    .cnt(keygen_cnt),
    .key(key_din),
    .round_key(round_key_out)
    );

endmodule
