`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 20:25:01
// Design Name: 
// Module Name: round_p
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


module round_p(
    input  [31:0] dat_in,
    output [31:0] dat_out
    );

assign dat_out = {dat_in[16], dat_in[25], dat_in[12], dat_in[11], dat_in[3], dat_in[20], dat_in[4], dat_in[15], dat_in[31], dat_in[17], dat_in[9], dat_in[6], dat_in[27], dat_in[14], dat_in[1], dat_in[22], dat_in[30], dat_in[24], dat_in[8], dat_in[18], dat_in[0], dat_in[5], dat_in[29], dat_in[23], dat_in[13], dat_in[19], dat_in[2], dat_in[26], dat_in[10], dat_in[21], dat_in[28], dat_in[7]};

endmodule
