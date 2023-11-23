`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 16:16:04
// Design Name: 
// Module Name: keygen_tb
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
module tb_keygen;
reg clk;
wire [4:0] cnt;
reg [63:0] key;
wire [47:0] round_key;
reg start;
wire cnt_end;


keygen keygen_inst(
    .cnt(cnt),
    .key(key),
    .round_key(round_key)
    );

counter counter_inst(
    .clk(clk),
    .start(start),
    .cnt(cnt),
    .cnt_end(cnt_end)
    );

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    #1 clk<=1'bx; start = 1'b0;
    #(CLK_PERIOD*3) clk<=0;
    #(CLK_PERIOD*3) key <= 64'b0000111000000001110000000000000000111000000000000011100000001000;
    #(CLK_PERIOD*3) start <= 1'b1;


end

endmodule
