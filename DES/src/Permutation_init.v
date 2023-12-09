`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 22:11:24
// Design Name: 
// Module Name: Permutation_init
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


module Permutation_init(
    input  [63:0] dat_in,
    output [63:0] dat_out
    );

assign dat_out = {dat_in[6], dat_in[14], dat_in[22], dat_in[30], dat_in[38], dat_in[46], dat_in[54], dat_in[62], dat_in[4], dat_in[12], dat_in[20], dat_in[28], dat_in[36], dat_in[44], dat_in[52], dat_in[60], dat_in[2], dat_in[10], dat_in[18], dat_in[26], dat_in[34], dat_in[42], dat_in[50], dat_in[58], dat_in[0], dat_in[8], dat_in[16], dat_in[24], dat_in[32], dat_in[40], dat_in[48], dat_in[56], dat_in[7], dat_in[15], dat_in[23], dat_in[31], dat_in[39], dat_in[47], dat_in[55], dat_in[63], dat_in[5], dat_in[13], dat_in[21], dat_in[29], dat_in[37], dat_in[45], dat_in[53], dat_in[61], dat_in[3], dat_in[11], dat_in[19], dat_in[27], dat_in[35], dat_in[43], dat_in[51], dat_in[59], dat_in[1], dat_in[9], dat_in[17], dat_in[25], dat_in[33], dat_in[41], dat_in[49], dat_in[57] };

endmodule
