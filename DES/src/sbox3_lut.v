`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 13:26:27
// Design Name: 
// Module Name: sbox3_lut
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


module sbox3_lut(
    input      [1:0] line,
    input      [3:0] column,
    output reg [3:0] dout
);

always @(*) begin
    case ({line, column})
        6'b000000: dout = 'd10;
        6'b000001: dout = 'd0;
        6'b000010: dout = 'd9;
        6'b000011: dout = 'd14;
        6'b000100: dout = 'd6;
        6'b000101: dout = 'd3;
        6'b000110: dout = 'd15;
        6'b000111: dout = 'd5;
        6'b001000: dout = 'd1;
        6'b001001: dout = 'd13;
        6'b001010: dout = 'd12;
        6'b001011: dout = 'd7;
        6'b001100: dout = 'd11;
        6'b001101: dout = 'd4;
        6'b001110: dout = 'd2;
        6'b001111: dout = 'd8;
        6'b010000: dout = 'd13;
        6'b010001: dout = 'd7;
        6'b010010: dout = 'd0;
        6'b010011: dout = 'd9;
        6'b010100: dout = 'd3;
        6'b010101: dout = 'd4;
        6'b010110: dout = 'd6;
        6'b010111: dout = 'd10;
        6'b011000: dout = 'd2;
        6'b011001: dout = 'd8;
        6'b011010: dout = 'd5;
        6'b011011: dout = 'd14;
        6'b011100: dout = 'd12;
        6'b011101: dout = 'd11;
        6'b011110: dout = 'd15;
        6'b011111: dout = 'd1;
        6'b100000: dout = 'd13;
        6'b100001: dout = 'd6;
        6'b100010: dout = 'd4;
        6'b100011: dout = 'd9;
        6'b100100: dout = 'd8;
        6'b100101: dout = 'd15;
        6'b100110: dout = 'd3;
        6'b100111: dout = 'd0;
        6'b101000: dout = 'd11;
        6'b101001: dout = 'd1;
        6'b101010: dout = 'd2;
        6'b101011: dout = 'd12;
        6'b101100: dout = 'd5;
        6'b101101: dout = 'd10;
        6'b101110: dout = 'd14;
        6'b101111: dout = 'd7;
        6'b110000: dout = 'd1;
        6'b110001: dout = 'd10;
        6'b110010: dout = 'd13;
        6'b110011: dout = 'd0;
        6'b110100: dout = 'd6;
        6'b110101: dout = 'd9;
        6'b110110: dout = 'd8;
        6'b110111: dout = 'd7;
        6'b111000: dout = 'd4;
        6'b111001: dout = 'd15;
        6'b111010: dout = 'd14;
        6'b111011: dout = 'd3;
        6'b111100: dout = 'd11;
        6'b111101: dout = 'd5;
        6'b111110: dout = 'd2;
        6'b111111: dout = 'd12;
    endcase
end

endmodule