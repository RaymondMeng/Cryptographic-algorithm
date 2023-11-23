`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 16:17:52
// Design Name: 
// Module Name: mux
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


module mux(
    input             clk,
    input             rst_n,
    input      [31:0] f_out,
    input      [31:0] L_init,
    input      [31:0] R_init,
    input      [4:0]  cnt,
    output reg [31:0] R_dat,
    output reg [31:0] L_dat,
    output reg        lst_valid
    );

wire lst_valid_d;

//加上R0 L0总共17个参数
always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        R_dat <= 'd0;
        L_dat <= 'd0;
    end
    else begin
        if (cnt == 'd0) begin
            R_dat <= R_init;
            L_dat  <= L_init;
        end
        else if (cnt > 'd0 && cnt < 'd17) begin
            R_dat <= f_out ^ L_dat;
            L_dat <= R_dat;
        end
        else begin
            R_dat <= R_dat;
            L_dat <= L_dat;
        end
    end
end

assign lst_valid_d = (cnt == 'd17) ? 1'b1 : 1'b0;

always @(posedge clk) begin
    lst_valid <= lst_valid_d;
end

endmodule
