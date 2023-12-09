`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 11:50:49
// Design Name: 
// Module Name: extension
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


module extension(
    input  [31:0] dat_in,
    output [47:0] dat_out
    );

assign dat_out = {dat_in[0], dat_in[31:27], dat_in[28:23], dat_in[24:19], dat_in[20:15], dat_in[16:11], dat_in[12:7], dat_in[8:3], dat_in[4:0], dat_in[31]};

endmodule
