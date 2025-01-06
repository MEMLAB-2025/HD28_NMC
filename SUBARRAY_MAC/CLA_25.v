`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 22:18:35
// Design Name: 
// Module Name: CLA_25
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


module CLA_25(
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
    input [24:0]a;
    input [24:0]b;
    input cin;

    //output
    output [24:0]SO;
    output cout;

    //wire
    wire carry_mid;

    //code
    CLA_24 c1(.a(a[23:0]), .b(b[23:0]), .cin(cin), .SO(SO[23:0]), .cout(carry_mid));
    FA f1(.a(a[24]), .b(b[24]), .cin(carry_mid), .sum(SO[24]), .carry(cout));
endmodule
