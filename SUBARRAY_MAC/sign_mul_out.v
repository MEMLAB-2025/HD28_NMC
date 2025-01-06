`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/14 16:35:16
// Design Name: 
// Module Name: sign_mul_out
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


module sign_mul_out(
    //clock and reset

    //input
    mul_out,
    sign_a,
    sign_b,

    //output
    data_out

    );

    //clock and reset

    //input
    input [15:0]mul_out;
    input sign_a;
    input sign_b;

    //output
    output [15:0]data_out;

    //wire
    wire sign_out;
    wire [14:0]sign_num;

    //code
    assign sign_out = sign_a^sign_b;
    assign sign_num = ~mul_out[14:0]+1;
    assign data_out = (!mul_out)?0:(sign_out?{sign_out, sign_num}:{{1'b0}, mul_out});
endmodule
