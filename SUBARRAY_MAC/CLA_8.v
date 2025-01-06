`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 20:22:46
// Design Name: 
// Module Name: CLA_8
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


module CLA_8(
    //clock and reset

    //input
    a,
    b,
    cin,

    //output
    SO,
    Gm,
    Pm,
    cout

    );

    //clock and reset

    //input
    input [7:0]a;
    input [7:0]b;
    input cin;

    output [7:0]SO;
    output Gm;
    output Pm;
    output cout;

    //wires
    wire [1:0]Gi;
    wire [1:0]Pi;
    wire [1:0]CI;

    //code
    CLA_4 c1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .SO(SO[3:0]), .Gm(Gi[0]), .Pm(Pi[0]));
    CLA_4 c2(.a(a[7:4]), .b(b[7:4]), .cin(CI[0]), .SO(SO[7:4]), .Gm(Gi[1]), .Pm(Pi[1]));

    carry_LA_2 co(.P(Pi), .G(Gi), .cin(cin), .coi(CI), .Gm(Gm), .Pm(Pm));

    assign cout = CI[1];
endmodule
