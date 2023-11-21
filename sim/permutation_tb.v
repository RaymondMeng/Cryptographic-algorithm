`timescale 1ns / 1ps
`include "./src/Permutation_init.v"


module tb_Permutation;
reg [63:0] dat_in;
wire [63:0] dat_out;

Permutation_init Permutation_init_inst
(
    .dat_in (dat_in),
    .dat_out (dat_out)
);

initial begin
    $dumpfile("tb_Permutation.vcd");
    $dumpvars(0, tb_Permutation);
end

initial begin
    #100 dat_in <= 64'b1010101010100011001100110010001000011110001010101010101010101010;
    #100 dat_in <= 64'b1010101010100011001100110010001000011110001010101010101010101011;
    #100 dat_in <= 64'b1010101010100011001100110010001000011110001010101010101010101001;
    #100 dat_in <= 64'b1010101010100011001100110010001000011110001010101010101010101101;
    $finish(2);
end

endmodule