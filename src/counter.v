`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 17:30:44
// Design Name: 
// Module Name: counter
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


module counter(
    input            clk,
    input            rst_n,
    input            start,
    output reg [4:0] cnt,
    output reg       cnt_end
    );

wire cnt_start; //是否持续加的信号
always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        cnt <= 'd0;
        cnt_end <= 1'b0;
    end
    else begin
        if (start == 1'b1) begin
            if(cnt_start == 1'b1 && cnt < 'd17) begin
                cnt <= cnt + 1'b1;
                cnt_end <= (cnt == 'd16);
            end
            else begin
                cnt_end <= 1'b1;
                cnt <= cnt;
            end
        end
        else begin
            cnt_end <= 1'b0;
            cnt <= 'd0;
        end
    end
end

assign cnt_start = start & ~cnt_end;

endmodule

