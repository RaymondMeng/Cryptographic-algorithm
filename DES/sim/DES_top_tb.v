`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/21 18:08:11
// Design Name: 
// Module Name: DES_top_tb
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


module DES_top_tb;

reg clk;
reg rst_n;
reg [63:0] din;
wire [63:0] dout;
reg start;
wire dat_valid;
reg mode;

parameter plain_text = 64'h0123456789abcdef;
parameter cipher_text = 64'h85e813540f0ab405;
parameter key_din = 64'h133457799bbcdff1;

DES_top DES_top_inst
(
    .din(din),
    .rst_n (rst_n),
    .clk (clk),
    .start(start),
    .dout(dout),
    .dat_valid(dat_valid),
    .key_din(key_din),
    .mode(mode)
);

localparam CLK_PERIOD = 100;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    #1 rst_n<=1'bx;clk<=1'bx; start <= 1'b0;
    #(CLK_PERIOD*3) rst_n<=0;clk<=0;mode<=0;
    #(CLK_PERIOD*3) din <= plain_text;
                    rst_n <= 1'b1;
    #(CLK_PERIOD*3) start <= 1'b1;
    #(CLK_PERIOD)   start <= 1'b0;
    #(CLK_PERIOD*100) mode<=1'b1; din<=cipher_text;
    #(CLK_PERIOD*3) start <= 1'b1;
    #(CLK_PERIOD)   start <= 1'b0;
    #(CLK_PERIOD*20);
end

endmodule
