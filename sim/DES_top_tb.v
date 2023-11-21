`include "./src/DES_top.v"

module tb_DES_top;
reg  clk;
reg  rst_n;
reg  start;
wire dat_valid;
reg  [63:0] plain_text;
wire [63:0] cipher_text;


DES_top DES_top_inst
(
    .rst_n (rst_n),
    .clk (clk),
    .plain_text(plain_text),
    .start(start),
    .cipher_text(cipher_text),
    .dat_valid(dat_valid)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_DES_top.vcd");
    $dumpvars(0, tb_DES_top);
end

initial begin
    #1 rst_n<=1'bx;clk<=1'bx;
       plain_text <= 63'd0;
       start <= 1'b0;
    #(CLK_PERIOD*3) rst_n<=1;
    #(CLK_PERIOD*3) rst_n<=0;clk<=0;
    #(CLK_PERIOD*3) rst_n<=1;
    #(CLK_PERIOD*10) plain_text <= 63'd1;
                     start <= 1'b1;
    $finish(2);
end

endmodule
`default_nettype wire