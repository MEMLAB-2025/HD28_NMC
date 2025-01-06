`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/14 14:04:35
// Design Name: 
// Module Name: sign_num_enc
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


module sign_num_enc(
    //clock and reset

    //input
    data_in,

    //output
    mul_in,
    sign_bit

    );

    //clock and reset

    //input
    input [7:0]data_in;
    input sign_bit;

    //output
    output [7:0]mul_in;

    //wires
    wire [6:0]unsign_num;
    wire [6:0]sign_num;

    //code
    assign unsign_num = data_in[6:0];
    assign sign_num = ~data_in[6:0]+1;
    assign mul_in = data_in[7]?{{1'b0}, sign_num}:{data_in[7], unsign_num};
    assign sign_bit = data_in[7];
endmodule
