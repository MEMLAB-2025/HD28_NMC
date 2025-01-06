`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 22:45:30
// Design Name: 
// Module Name: DFF_25
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


module DFF_25(
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,

    //input
    data_in,

    //output
    data_out

    );

    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;

    //input
    input [24:0]data_in;

    //outout
    output [24:0]data_out;

    //code
    DFF d0(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[0]), .q(data_out[0]));
    DFF d1(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[1]), .q(data_out[1]));
    DFF d2(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[2]), .q(data_out[2]));
    DFF d3(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[3]), .q(data_out[3]));

    DFF d4(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[4]), .q(data_out[4]));
    DFF d5(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[5]), .q(data_out[5]));
    DFF d6(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[6]), .q(data_out[6]));
    DFF d7(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[7]), .q(data_out[7]));

    DFF d8(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[8]), .q(data_out[8]));
    DFF d9(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[9]), .q(data_out[9]));
    DFF d10(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[10]), .q(data_out[10]));
    DFF d11(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[11]), .q(data_out[11]));

    DFF d12(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[12]), .q(data_out[12]));
    DFF d13(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[13]), .q(data_out[13]));
    DFF d14(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[14]), .q(data_out[14]));
    DFF d15(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[15]), .q(data_out[15]));

    DFF d16(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[16]), .q(data_out[16]));
    DFF d17(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[17]), .q(data_out[17]));
    DFF d18(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[18]), .q(data_out[18]));
    DFF d19(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[19]), .q(data_out[19]));

    DFF d20(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[20]), .q(data_out[20]));
    DFF d21(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[21]), .q(data_out[21]));
    DFF d22(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[22]), .q(data_out[22]));
    DFF d23(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[23]), .q(data_out[23]));

    DFF d24(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .d(data_in[24]), .q(data_out[24]));
endmodule
