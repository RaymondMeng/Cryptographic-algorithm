`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 21:37:44
// Design Name: 
// Module Name: round_tb
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


module round_tb;

reg clk;
reg [31:0] R_dat;
wire [31:0] f_out;
reg [47:0] key_dat;

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

Round round_inst(.clk(clk), .R_dat(R_dat), .f_out(f_out), .key_dat(key_dat));
   
initial begin
    #1 clk <= 1'bx;
    R_dat <= 'dx;
    key_dat <= 'dx;
    #(CLK_PERIOD*3) clk <= 0;
    #(CLK_PERIOD*10) R_dat <= 32'b10101010101010100000111100101001;
                     key_dat <= 48'b101010101010001100110011001000100001111000101010;
    #(CLK_PERIOD*10) R_dat <= 32'd0;
                     key_dat <= 48'd0;
    #(CLK_PERIOD*10) R_dat <= 32'b10101010101010100000111100101001;
                     key_dat <= 48'b101010101010001100110011001000100001111000101010;
    #(CLK_PERIOD*10) R_dat <= 32'b10101010101010100000111100101000;
                     key_dat <= 48'b101010101010001100110011001000100001111000101011;

end

endmodule
