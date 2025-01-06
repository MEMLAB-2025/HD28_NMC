`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 21:34:57
// Design Name: 
// Module Name: CLA_24
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


module CLA_24(
    //clock and reset

    //input
    a,
    b,
    cin,

    //output
    SO,
    cout

    );

    //clock and reset

    //input 
    input [23:0]a;
    input [23:0]b;
    input cin;

    //output
    output [23:0]SO;
    output cout;

    //wire
    wire carry_mid;

    //code
    CLA_16 c1(.a(a[15:0]), .b(b[15:0]), .cin(cin), .SO(SO[15:0]), .Gm(), .Pm(), .cout(carry_mid));
    CLA_8 c2(.a(a[23:16]), .b(b[23:16]), .cin(carry_mid), .SO(SO[23:16]), .Gm(), .Pm(), .cout(cout));
endmodule
