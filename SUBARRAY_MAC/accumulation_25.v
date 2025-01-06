`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 22:45:14
// Design Name: 
// Module Name: accumulation_25
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


module accumulation_25(
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,

    //input
    data_in,

    //output
    data_out,
    cout

    );

    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;

    //input
    input [24:0]data_in;

    //output
    output [24:0]data_out;
    output cout;

    //wires
    wire dff_en;
    wire dff_rst;
    wire [24:0]data_mid;
    wire [24:0]DFF_out;

    //code
    CLA_25 c1(.a(data_in), .b(DFF_out), .cin(1'b0), .SO(data_mid), .cout(cout));
    DFF_25 d1(.sys_clk(sys_clk), .sys_en(sys_en), .rst_n(rst_n), .data_in(data_mid), .data_out(DFF_out));

    assign data_out = DFF_out;
endmodule
