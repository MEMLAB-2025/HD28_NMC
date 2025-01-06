`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 20:00:00
// Design Name: 
// Module Name: carry_LA_2
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


module carry_LA_2(
    //clock and reset

    //input
    P,
    G,
    cin,

    //output
    coi,
    Gm,
    Pm

    );

    //clock and reset

    //output
    input [1:0]P;
    input [1:0]G;
    input cin;

    //output
    output [1:0]coi;
    output Gm;
    output Pm;

    //code
    assign coi[0] = G[0]|(P[0]&cin);
    assign coi[1] = G[1]|(P[1]&G[0])|(P[1]&P[0]&cin);
    
    assign Gm = G[1]|(P[1]&G[0]);
    assign Pm = P[1]&P[0];
endmodule
