`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 22:34:27
// Design Name: 
// Module Name: MAC_25
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


module MAC_25(
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,

    //input
    data_in_a,
    sign_data_in_a,
    data_in_b,

    //output
    mul_output,
    mac_output

    );

    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;

    //input
    input [7:0]data_in_a;
    input sign_data_in_a;
    input [7:0]data_in_b;

    //output
    output [15:0]mul_output;
    output [24:0]mac_output;

    //wires
    wire [24:0]accu_in;
    wire [15:0]mul_output;
    //wire [7:0]unsign_a;
    wire [7:0]unsign_b;
    wire [15:0]unsign_mul_out;

    wire signa1;
    wire signa2;
    wire signa3;
    wire signa4;

    wire signb1;
    wire signb2;
    wire signb3;
    wire signb4;

    //code
    //sign_num_enc s1(.data_in(data_in_a), .mul_in(unsign_a));
    sign_num_enc s2(.data_in(data_in_b), .mul_in(unsign_b));

    multiply_CSA m1(.a(data_in_a), .b(unsign_b), .mul(unsign_mul_out));
    //mul_shift m1(.mac_clk(sys_clk), .mod_en(sys_en), .rst_n(rst_n), .data_in(data_in_a), .weight(unsign_b), .data_out(unsign_mul_out));
    
    /*
    DFF d1(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in_a[7]), .q(signa1));
    DFF d2(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(signa1), .q(signa2));
    DFF d3(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(signa2), .q(signa3));
    DFF d7(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(signa3), .q(signa4));
    DFF d4(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in_b[7]), .q(signb1));
    DFF d5(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(signb1), .q(signb2));
    DFF d6(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(signb2), .q(signb3));
    DFF d8(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(signb3), .q(signb4));
    */

    sign_mul_out s3(.mul_out(unsign_mul_out), .sign_a(sign_data_in_a), .sign_b(data_in_b[7]), .data_out(mul_output));
    accumulation_25 a1(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .data_in(accu_in), .data_out(mac_output), .cout());

    assign accu_in = {{9{mul_output[15]}}, mul_output};
endmodule
