`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/13 17:46:57
// Design Name: 
// Module Name: CLA_16
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


module CLA_16(
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
    input [15:0]a;
    input [15:0]b;
    input cin;

    //output
    output [15:0]SO;
    output Gm;
    output Pm;
    output cout;

    //wires
    wire [3:0]Gi;
    wire [3:0]Pi;
    wire [3:0]CI;

    CLA_4 c1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .SO(SO[3:0]), .Gm(Gi[0]), .Pm(Pi[0]));
    CLA_4 c2(.a(a[7:4]), .b(b[7:4]), .cin(CI[0]), .SO(SO[7:4]), .Gm(Gi[1]), .Pm(Pi[1]));
    CLA_4 c3(.a(a[11:8]), .b(b[11:8]), .cin(CI[1]), .SO(SO[11:8]), .Gm(Gi[2]), .Pm(Pi[2]));
    CLA_4 c4(.a(a[15:12]), .b(b[15:12]), .cin(CI[2]), .SO(SO[15:12]), .Gm(Gi[3]), .Pm(Pi[3]));

    carry_LA co(.P(Pi), .G(Gi), .cin(cin), .coi(CI), .Gm(Gm), .Pm(Pm));

    assign cout = CI[3];

endmodule
