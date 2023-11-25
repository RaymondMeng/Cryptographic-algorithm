`timescale 1ns / 1ps
`include "./src/Permutation_init.v"
`include "./src/counter.v"
`include "./src/Round.v"
`include "./src/mux.v"
`include "./src/Permutation_inverse.v"
`include "./src/keygen.v"
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
    input  [63:0] plain_text,
    input         clk,
    input         start,
    input         rst_n,
    input  [63:0] key_din,
    output [63:0] cipher_text,
    output        dat_valid
);

wire [63:0] permu_init_out;
wire [4:0]  cnt_out;
wire        cnt_end;
wire [31:0] f_out;
wire [31:0] R_dat_out, L_dat_out;
wire [47:0] round_key_out;
wire [31:0] L_init, R_init;

Permutation_init Permutation_init_inst(
    .dat_in(plain_text),
    .dat_out(permu_init_out)
);

Round round_inst(
    .R_dat(R_dat_out),
    .key_dat(round_key_out),
    .f_out(f_out)
);

counter counter_inst(
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .cnt(cnt_out),
    .cnt_end(cnt_end)
);

assign L_init = permu_init_out[63:32];
assign R_init = permu_init_out[31:0];

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
    .dat_in({R_dat_out, L_dat_out}),
    .dat_out(cipher_text)
);

keygen keygen_inst(
    .cnt(cnt_out),
    .key(key_din),
    .round_key(round_key_out)
    );
    
endmodule
