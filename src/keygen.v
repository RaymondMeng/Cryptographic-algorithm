`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 14:43:12
// Design Name: 
// Module Name: keygen
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


module keygen(
    input  [4:0]  cnt,
    input  [63:0] key,
    output [47:0] round_key
    );

wire [55:0] key_dat;
reg [55:0] key_shift;
//除去校验位 pc1
assign key_dat = {key[7], key[15], key[23], key[31], key[39], key[47], key[55], key[63], key[6], key[14], key[22], key[30], key[38], key[46], key[54], key[62], key[5], key[13], key[21], key[29], key[37], key[45], key[53], key[61], key[4], key[12], key[20], key[28], key[1], key[9], key[17], key[25], key[33], key[41], key[49], key[57], key[2], key[10], key[18], key[26], key[34], key[42], key[50], key[58], key[3], key[11], key[19], key[27], key[35], key[43], key[51], key[59], key[36], key[44], key[52], key[60]};

always @(*) begin
    case (cnt)
        'd1: key_shift = {key_dat[54:28], key_dat[55], key_dat[26:0], key_dat[27]};
        'd2: key_shift = {key_dat[53:28], key_dat[55:54], key_dat[25:0], key_dat[27:26]};
        'd3: key_shift = {key_dat[51:28], key_dat[55:52], key_dat[23:0], key_dat[27:24]};
        'd4: key_shift = {key_dat[49:28], key_dat[55:50], key_dat[21:0], key_dat[27:22]};
        'd5: key_shift = {key_dat[47:28], key_dat[55:48], key_dat[19:0], key_dat[27:20]};
        'd6: key_shift = {key_dat[45:28], key_dat[55:46], key_dat[17:0], key_dat[27:18]};
        'd7: key_shift = {key_dat[43:28], key_dat[55:44], key_dat[15:0], key_dat[27:16]};
        'd8: key_shift = {key_dat[41:28], key_dat[55:42], key_dat[13:0], key_dat[27:14]};
        'd9: key_shift = {key_dat[40:28], key_dat[55:41], key_dat[12:0], key_dat[27:13]};
        'd10: key_shift = {key_dat[38:28], key_dat[55:39], key_dat[10:0], key_dat[27:11]};
        'd11: key_shift = {key_dat[36:28], key_dat[55:37], key_dat[8:0], key_dat[27:9]};
        'd12: key_shift = {key_dat[34:28], key_dat[55:35], key_dat[6:0], key_dat[27:7]};
        'd13: key_shift = {key_dat[32:28], key_dat[55:33], key_dat[4:0], key_dat[27:5]};
        'd14: key_shift = {key_dat[30:28], key_dat[55:31], key_dat[2:0], key_dat[27:3]};
        'd15: key_shift = {key_dat[28], key_dat[55:29], key_dat[0], key_dat[27:1]};
        'd16: key_shift = key_dat;
        default: key_shift = 'd0;
    endcase
end

//置换选择2 pc2 todo
assign round_key = {key_shift[42], key_shift[39], key_shift[45], key_shift[32], key_shift[55], key_shift[51], key_shift[53], key_shift[28], key_shift[41], key_shift[50], key_shift[35], key_shift[46], key_shift[33], key_shift[37], key_shift[44], key_shift[52], key_shift[30], key_shift[48], key_shift[40], key_shift[49], key_shift[29], key_shift[36], key_shift[43], key_shift[54], key_shift[15], key_shift[4], key_shift[25], key_shift[19], key_shift[9], key_shift[1], key_shift[26], key_shift[16], key_shift[5], key_shift[11], key_shift[23], key_shift[8], key_shift[12], key_shift[7], key_shift[17], key_shift[0], key_shift[22], key_shift[3], key_shift[10], key_shift[14], key_shift[6], key_shift[20], key_shift[27], key_shift[24]};


endmodule
