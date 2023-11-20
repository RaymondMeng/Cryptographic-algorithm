`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 18:53:44
// Design Name: 
// Module Name: count_mux_tb
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


module count_mux_tb;

// reg clk, start;
// wire cnt_end;
// wire [4:0] cnt;
reg clk;
reg [31:0] f_out;
reg [31:0] L_init;
reg [31:0] R_init;
reg [4:0] cnt;
wire [31:0] R_dat;
wire [31:0] L_dat;
wire lst_valid;

// counter count_inst(
//     .clk(clk),
//     .start(start),
//     .cnt(cnt),
//     .cnt_end(cnt_end)
//     );

mux mux_inst(
    .f_out(f_out),
    .L_init(L_init),
    .R_init(R_init),
    .cnt(cnt),
    .R_dat(R_dat),
    .L_dat(L_dat),
    .lst_valid(lst_valid),
    .clk(clk)
);


localparam CLK_PERIOD = 10;
always #(1) clk=~clk;

initial begin
    #2 clk<=1'bx;
       f_out <= 32'b00000000000000000000000000000000;
       L_init <= 32'b10101010101010100000111100101000;
       R_init <= 32'b10101010101010100000111100101000;
       cnt <= 'dx;
    #(CLK_PERIOD*3) clk<=0;
                    cnt <= 'd0;
    #3 f_out <= 32'b00000000000000000000000000000001;
                     cnt <= 'd1;
    #2 f_out <= 32'b00000000000000000000000000000010;
                     cnt <= 'd2;
    #2 f_out <= 32'b00000000000000000000000000000011;
                     cnt <= 'd3;
    #2 f_out <= 32'b00000000000000000000000000000100;
                     cnt <= 'd4;
    #2 f_out <= 32'b00000000000000000000000000000101;
                     cnt <= 'd5;
    #2 f_out <= 32'b00000000000000000000000000000110;
                     cnt <= 'd6;
    #2 f_out <= 32'b00000000000000000000000000000111;
                     cnt <= 'd7;
    #2 f_out <= 32'b00000000000000000000000000001000;
                     cnt <= 'd8;
    #2 f_out <= 32'b00000000000000000000000000001001;
                     cnt <= 'd9;
    #2 f_out <= 32'b00000000000000000000000000001010;
                     cnt <= 'd10;
    #2 f_out <= 32'b00000000000000000000000000001011;
                     cnt <= 'd11;
    #2 f_out <= 32'b00000000000000000000000000001100;
                     cnt <= 'd12;
    #2 f_out <= 32'b00000000000000000000000000001101;
                     cnt <= 'd13;
    #2 f_out <= 32'b00000000000000000000000000001110;
                     cnt <= 'd14;
    #2 f_out <= 32'b00000000000000000000000000001111;
                     cnt <= 'd15;
    #2 f_out <= 32'b00000000000000000000000000010000;
                     cnt <= 'd16;
    #2 f_out <= 32'b00000000000000000000000000010001;
                     cnt <= 'd17;
end



endmodule
