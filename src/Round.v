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
    input             clk,
    input      [31:0] R_dat,
    input      [47:0] key_dat,
    output     [31:0] f_out
    );

wire [47:0] extension_out;
wire [47:0] xor_out;
wire [31:0] s_box_out;
wire [31:0] round_p_out;

extension extension_inst(.dat_in(R_dat), .dat_out(extension_out));

assign xor_out = extension_out ^ key_dat;

s_box s_box_inst(.dat_in(xor_out), .dat_out(s_box_out));

round_p round_p_inst(.dat_in(s_box_out), .dat_out(round_p_out));

assign f_out = round_p_out;
// always @(posedge clk) begin
//     f_out <= round_p_out;
// end

endmodule
