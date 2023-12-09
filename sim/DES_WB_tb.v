`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/08 16:43:53
// Design Name: 
// Module Name: DES_WB_tb
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


module DES_WB_tb;

reg clk, rst_n;
reg wbs_stb_i, wbs_cyc_i, wbs_we_i;
reg [3:0] wbs_sel_i;
reg [31:0] wbs_dat_i, wbs_adr_i;
wire wbs_ack_o;
wire [31:0] wbs_dat_o;

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

integer plaintext_H32 = 32'h01234567;
integer plaintext_L32 = 32'h89abcdef;
integer ciphertext_H32 = 32'h85e81354;
integer ciphertext_L32 = 32'h0f0ab405;
integer key_H32 = 32'h13345779;
integer key_L32 = 32'h9bbcdff1;
integer out1, out2;

initial begin
    #1 rst_n<=1'b0;clk<=1'b1;wbs_we_i<=1'b0;wbs_stb_i<=1'b0;wbs_cyc_i<=1'b0;
    #(CLK_PERIOD*3) rst_n<=1;
    $display("plaintext: %h%h\n", plaintext_H32, plaintext_L32);
    $display("key: %h%h\n", key_H32, key_L32);
    /**************            encryption            **************/
    /*first write cycle*/
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'hc; //RECEIVE_H32
                                    wbs_sel_i <= 4'hf; 
                                    wbs_dat_i <= plaintext_H32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*second write cycle*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h10; //RECEIVE_L32
                                    wbs_sel_i <= 4'hf; 
                                    wbs_dat_i <= plaintext_L32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*third write cycle*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h14; //KEY_H32
                                    wbs_sel_i <= 4'hf; 
                                    wbs_dat_i <= key_H32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*fourth write cycle*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h18; //KEY_L32
                                    wbs_sel_i <= 4'hf;
                                    wbs_dat_i <= key_L32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*write mode & start*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h0; //REG_CFG
                                    wbs_sel_i <= 4'b0110;
                                    wbs_dat_i <= 32'h000100; //start encryption
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    $display("start encryption!!!\n");
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*read cycle*/
    #(CLK_PERIOD*20) @(posedge clk) wbs_adr_i <= 32'h0; //read finish
                                    wbs_sel_i <= 4'b1111;
                                    wbs_we_i  <= 1'b0;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    #(CLK_PERIOD) wbs_stb_i <= 1'b0;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
    /*stop encryption*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h0; //REG_CFG
                                    wbs_sel_i <= 4'b0010;
                                    wbs_dat_i <= 32'h0; //stop encryption
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    $display("encryption finish!\n");
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*read cycle*/
    #(CLK_PERIOD)   @(posedge clk)  wbs_adr_i <= 32'h4; //TRANSMIT_H32
                                    wbs_sel_i <= 4'b1111;
                                    wbs_we_i  <= 1'b0;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    #(CLK_PERIOD) wbs_stb_i <= 1'b0;
                    @(negedge wbs_ack_o)    
                                    out1 = wbs_dat_o;
                                    wbs_cyc_i <= 1'b0;        
    /*read cycle*/
    #(CLK_PERIOD)   @(posedge clk)  wbs_adr_i <= 32'h8; //TRANSMIT_L32
                                    wbs_sel_i <= 4'b1111;
                                    wbs_we_i  <= 1'b0;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    #(CLK_PERIOD) wbs_stb_i <= 1'b0;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;  
                                    out2 = wbs_dat_o;
                                    $display("ciphertext: %h%h", out1, out2);
    #(CLK_PERIOD*100);
    /**************            decryption            **************/
    /*first write cycle*/
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'hc; //RECEIVE_H32
                                    wbs_sel_i <= 4'hf; 
                                    wbs_dat_i <= ciphertext_H32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*second write cycle*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h10; //RECEIVE_L32
                                    wbs_sel_i <= 4'hf; 
                                    wbs_dat_i <= ciphertext_L32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*third write cycle*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h14; //KEY_H32
                                    wbs_sel_i <= 4'hf; 
                                    wbs_dat_i <= key_H32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*fourth write cycle*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h18; //KEY_L32
                                    wbs_sel_i <= 4'hf;
                                    wbs_dat_i <= key_L32; 
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*write mode & start*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h0; //REG_CFG
                                    wbs_sel_i <= 4'b0110;
                                    wbs_dat_i <= 32'h010100; //start decryption
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    $display("start decryption!!!\n");
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*read cycle*/
    #(CLK_PERIOD*20) @(posedge clk) wbs_adr_i <= 32'h0; //read finish
                                    wbs_sel_i <= 4'b1111;
                                    wbs_we_i  <= 1'b0;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    #(CLK_PERIOD) wbs_stb_i <= 1'b0;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
    /*stop decryption*/                                
    #(CLK_PERIOD*3) @(posedge clk)  wbs_adr_i <= 32'h0; //REG_CFG
                                    wbs_sel_i <= 4'b0010;
                                    wbs_dat_i <= 32'h0; //stop encryption
                                    wbs_we_i  <= 1'b1;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    $display("decryption finish!\n");
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;
                                    wbs_stb_i <= 1'b0;
                                    wbs_we_i  <= 1'b0;
                                    wbs_adr_i <= 32'h0; 
                                    wbs_sel_i <= 4'h0; 
                                    wbs_dat_i <= 32'h0;
    /*read cycle*/
    #(CLK_PERIOD)   @(posedge clk)  wbs_adr_i <= 32'h4; //TRANSMIT_H32
                                    wbs_sel_i <= 4'b1111;
                                    wbs_we_i  <= 1'b0;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    #(CLK_PERIOD) wbs_stb_i <= 1'b0;
                    @(negedge wbs_ack_o)    
                                    out1 = wbs_dat_o;
                                    wbs_cyc_i <= 1'b0;        
    /*read cycle*/
    #(CLK_PERIOD)   @(posedge clk)  wbs_adr_i <= 32'h8; //TRANSMIT_L32
                                    wbs_sel_i <= 4'b1111;
                                    wbs_we_i  <= 1'b0;
                                    wbs_stb_i <= 1'b1;
                                    wbs_cyc_i <= 1'b1;
                                    #(CLK_PERIOD) wbs_stb_i <= 1'b0;
                    @(negedge wbs_ack_o)    
                                    wbs_cyc_i <= 1'b0;  
                                    out2 = wbs_dat_o;
                                    $display("plaintext: %h%h", out1, out2);



end


DES_WB DES_WB_inst(
    .clk(clk),
    .rst_n(rst_n),
    .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_we_i(wbs_we_i), //1:write 0:read
    .wbs_sel_i(wbs_sel_i),
    .wbs_dat_i(wbs_dat_i),
    .wbs_adr_i(wbs_adr_i), //wbs reg offset address
    .wbs_ack_o(wbs_ack_o),
    .wbs_dat_o(wbs_dat_o)
    );

endmodule
