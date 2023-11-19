`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 11:19:59
// Design Name: Round.v
// Module Name: Round
// Project Name: des
// Target Devices: xc7a200t
// Tool Versions: 
// Description: round function
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Round(
    input         clk,
    input  [31:0] R_dat,
    input  [47:0] key_dat,
    input  [3:0]  cnt,
    output [31:0] f_out
    );

wire [47:0] extension_out;
wire [47:0] xor_out;

extension extension_inst(.dat_in(R_dat), .dat_out(extension_out));

assign xor_out = extension_out ^ key_dat;


endmodule
