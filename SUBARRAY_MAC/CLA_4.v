`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/12 15:38:22
// Design Name: 
// Module Name: CLA_4
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


module CLA_4(
    //clock and reset

    //input
    a,
    b,
    cin,

    //output
    SO,
    Pm,
    Gm,
    Cout

    );

    //clock and reset

    //input
    input [3:0]a;
    input [3:0]b;
    input cin;

    //output
    output [3:0]SO;
    output Pm;
    output Gm;
    output Cout;

    //code
    wire [3:0]CI;
    wire [3:0]Pi;
    wire [3:0]Gi;

    CLA_1 C1(.a(a[0]), .b(b[0]), .cin(cin), .SO(SO[0]), .Gi(Gi[0]), .Pi(Pi[0]));
    CLA_1 C2(.a(a[1]), .b(b[1]), .cin(CI[0]), .SO(SO[1]), .Gi(Gi[1]), .Pi(Pi[1]));
    CLA_1 C3(.a(a[2]), .b(b[2]), .cin(CI[1]), .SO(SO[2]), .Gi(Gi[2]), .Pi(Pi[2]));
    CLA_1 C4(.a(a[3]), .b(b[3]), .cin(CI[2]), .SO(SO[3]), .Gi(Gi[3]), .Pi(Pi[3]));

    carry_LA co(.P(Pi), .G(Gi), .cin(cin), .coi(CI), .Gm(Gm), .Pm(Pm));

    assign Cout = CI[3];
endmodule
