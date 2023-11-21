`timescale 1ns / 1ps
`include "./src/sbox1_lut.v"
`include "./src/sbox2_lut.v"
`include "./src/sbox3_lut.v"
`include "./src/sbox4_lut.v"
`include "./src/sbox5_lut.v"
`include "./src/sbox6_lut.v"
`include "./src/sbox7_lut.v"
`include "./src/sbox8_lut.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 12:01:47
// Design Name: 
// Module Name: s_box
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


module s_box(
    input  [47:0] dat_in,
    output [31:0] dat_out
    );

wire [3:0] sb1_out, sb2_out, sb3_out, sb4_out, sb5_out, sb6_out, sb7_out, sb8_out;

sbox1_lut sbox1_lut_inst(.line({dat_in[47], dat_in[42]}), .column(dat_in[46:43]), .dout(sb1_out));
sbox2_lut sbox2_lut_inst(.line({dat_in[41], dat_in[36]}), .column(dat_in[40:37]), .dout(sb2_out));
sbox3_lut sbox3_lut_inst(.line({dat_in[35], dat_in[30]}), .column(dat_in[34:31]), .dout(sb3_out));
sbox4_lut sbox4_lut_inst(.line({dat_in[29], dat_in[24]}), .column(dat_in[28:25]), .dout(sb4_out));
sbox5_lut sbox5_lut_inst(.line({dat_in[23], dat_in[18]}), .column(dat_in[22:19]), .dout(sb5_out));
sbox6_lut sbox6_lut_inst(.line({dat_in[17], dat_in[12]}), .column(dat_in[16:13]), .dout(sb6_out));
sbox7_lut sbox7_lut_inst(.line({dat_in[11], dat_in[6]}), .column(dat_in[10:7]), .dout(sb7_out));
sbox8_lut sbox8_lut_inst(.line({dat_in[5], dat_in[0]}), .column(dat_in[4:1]), .dout(sb8_out));

assign dat_out = {sb1_out, sb2_out, sb3_out, sb4_out, sb5_out, sb6_out, sb7_out, sb8_out};

endmodule
