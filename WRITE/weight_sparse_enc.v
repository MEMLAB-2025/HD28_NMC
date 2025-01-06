`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/23 11:27:38
// Design Name: 
// Module Name: weight_sparse_enc
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


module weight_sparse_enc(
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,

    //input
    data_in,

    //output
    data_out,
    sp_out,
    SPARSE,
    sp_col

    );

    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;

    //input
    input [7:0]data_in;

    //output
    output [8:0]data_out;
    output sp_out;
    output [7:0]SPARSE;
    output sp_col;

    //wires
    wire [7:0]data_mid;

    //code
    assign sp_out = |data_mid?0:1;
    assign data_out = {sp_out, data_mid};

    DFF d1(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[0]),.q(data_mid[0]));
    DFF d2(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[1]),.q(data_mid[1]));
    DFF d3(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[2]),.q(data_mid[2]));
    DFF d4(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[3]),.q(data_mid[3]));
    DFF d5(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[4]),.q(data_mid[4]));
    DFF d6(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[5]),.q(data_mid[5]));
    DFF d7(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[6]),.q(data_mid[6]));
    DFF d8(.sys_clk(sys_clk),.sys_en(sys_en),.rst_n(rst_n),.d(data_in[7]),.q(data_mid[7]));
    weight_sp_cnt w1(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .data_in(sp_out), .data_out(SPARSE), .sp_col(sp_col));

endmodule
