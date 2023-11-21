`timescale 1ns/1ps
`include "./src/Permutation_init.v"
`include "./src/Round.v"
`include "./src/counter.v"
`include "./src/mux.v"
`include "./src/Permutation_inverse.v"

module DES_top (
    input  [63:0] plain_text,
    input         clk,
    input         start,
    input         rst_n,
    output [63:0] cipher_text,
    output        dat_valid
);

wire [63:0] permu_init_out;
wire [4:0]  cnt_out;
wire        cnt_end;
wire [31:0] f_out;
wire [31:0] R_dat_out, L_dat_out;

localparam key = 48'b000000000000000000000000000000000000000000000001;

Permutation_init Permutation_init_inst(
    .dat_in(plain_text),
    .dat_out(permu_init_out)
);

Round round_inst(
    .clk(clk),
    .R_dat(R_dat_out),
    .key_dat(),
    .f_out(f_out)
);

counter counter_inst(
    .clk(clk),
    .start(start),
    .cnt(cnt_out),
    .cnt_end(cnt_end)
);

mux mux_inst(
    .clk(clk),
    .f_out(f_out),
    .L_init(permu_init_out[63:32]),
    .R_init(permu_init_out[31:0]),
    .cnt(cnt_out),
    .R_dat(R_dat_out),
    .L_dat(L_dat_out),
    .lst_valid(dat_valid)
);

Permutation_inverse Permutation_inverse_inst(
    .dat_in({L_dat_out, R_dat_out}),
    .dat_out(cipher_text)
);
    
endmodule