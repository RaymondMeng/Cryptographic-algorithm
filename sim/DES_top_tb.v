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
reg [63:0] plain_text;
wire [63:0] cipher_text;
reg start;
wire dat_valid;
reg [63:0] key_din;

DES_top DES_top_inst
(
    .plain_text(plain_text),
    .rst_n (rst_n),
    .clk (clk),
    .start(start),
    .cipher_text(cipher_text),
    .dat_valid(dat_valid),
    .key_din(key_din)
);

localparam CLK_PERIOD = 100;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    #1 rst_n<=1'bx;clk<=1'bx; start <= 1'b0;
    #(CLK_PERIOD*3) rst_n<=0;clk<=0;
    #(CLK_PERIOD*3) plain_text <= 64'b000000000000000011100000000000000000000000000000000000000000001;
                    key_din <= 64'b000000000000000000000011100000000000000000000000000000000000001;
                    rst_n <= 1'b1;
    #(CLK_PERIOD*3) start <= 1'b1;
end

endmodule
