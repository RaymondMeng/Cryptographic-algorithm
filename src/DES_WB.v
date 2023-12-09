`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MengCheng
// 
// Create Date: 2023/12/07 19:50:08
// Design Name: 
// Module Name: DES_WB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: DES with wishbone slave 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DES_WB(
    input clk,
    input rst_n,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i, //1:write 0:read
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i, //wbs reg offset address
    output wbs_ack_o,
    output [31:0] wbs_dat_o
    );

wire valid;
wire [3:0] wstrb;
wire [31:0] wdata;
reg [31:0] rdata;
wire dat_valid;
reg ready; //ready to output

//————————————————————————————————————————
// 31~24  |  23~16  |  15~8  |    7~0    |
//unused     MODE     START     FINISH 
reg [31:0] CFG_REG;
reg [31:0] RECEIVE_H32, RECEIVE_L32;
reg [31:0] KEY_H32, KEY_L32;
wire [31:0] TRANSMIT_H32, TRANSMIT_L32;
wire [63:0] key_din;
wire [63:0] din;

wire mode, start, finish;

assign valid = wbs_cyc_i && wbs_stb_i; //master request valid
assign wstrb = wbs_sel_i & {4{wbs_we_i}}; //select which byte can be wrote
assign wbs_dat_o = rdata;
assign wdata = wbs_dat_i[31:0];
assign wbs_ack_o = ready; //ready to ack
assign mode = CFG_REG[16];
assign start = CFG_REG[8];

always @(posedge clk) begin
    if (rst_n == 1'b0) begin
        ready <= 1'b0;
        CFG_REG <= {31'd0, finish};
        RECEIVE_H32 <= 'd0;
        RECEIVE_L32 <= 'd0;
        KEY_H32 <= 'd0;
        KEY_L32 <= 'd0;
        rdata <= 'd0;
    end
    else begin
        if (valid & ~ready) begin   //思路应该是首先按地址分情况讨论，然后在该地址上按sel使能字节
            CFG_REG[0] = finish;
            if (wbs_we_i) begin //write
                ready <= 1'b1;
                case (wbs_adr_i)
                    32'h0: CFG_REG[23:8] <= {{8{wstrb[2]}} & wdata[23:16], {8{wstrb[1]}} & wdata[15:8]}; //写入的时候需要考虑写入哪个字节
                    32'hc: RECEIVE_H32 <= wdata;
                    32'h10: RECEIVE_L32 <= wdata;
                    32'h14: KEY_H32 <= wdata; 
                    32'h18: KEY_L32 <= wdata;
                endcase
            end
            else if (!wbs_we_i) begin //read
                ready <= 1'b1;
                case (wbs_adr_i)
                    32'h0:  rdata <= CFG_REG; //读取的时候直接32位，在soc中用户自己截取字节
                    32'h4:  rdata <= TRANSMIT_H32;
                    32'h8:  rdata <= TRANSMIT_L32;
                    32'hc:  rdata <= RECEIVE_H32;
                    32'h10: rdata <= RECEIVE_L32;
                    32'h14: rdata <= KEY_H32;
                    32'h18: rdata <= KEY_L32;
                endcase
            end        
        end
        else begin
            ready <= 1'b0;
            CFG_REG <= CFG_REG;
            RECEIVE_H32 <= RECEIVE_H32;
            RECEIVE_L32 <= RECEIVE_L32;
            KEY_H32 <= KEY_H32;
            KEY_L32 <= KEY_L32;
        end
    end
end

assign key_din = {KEY_H32, KEY_L32};
assign din = {RECEIVE_H32, RECEIVE_L32};
assign finish = start ? (dat_valid ? 1'b1 : finish) : 1'b0; 

DES_top DES_top_inst(
    .clk(clk),
    .rst_n(rst_n),
    .mode(mode), //0:加密 1:解密
    .key_din(key_din),
    .start(start), //1:start
    .din(din),
    .dout({TRANSMIT_H32, TRANSMIT_L32}),
    .dat_valid(dat_valid)
);

endmodule
