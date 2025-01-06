`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/12 16:40:17
// Design Name: 
// Module Name: carry_LA
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


module carry_LA(
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
    
    //input
    input [3:0]P;
    input [3:0]G;
    input cin;

    //output
    output [3:0]coi;
    output Gm;
    output Pm;

    //code
    assign coi[0] = G[0]|(P[0]&cin);
    assign coi[1] = G[1]|(P[1]&G[0])|(P[1]&P[0]&cin);
    assign coi[2] = G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&cin);
    assign coi[3] = G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0])|(P[3]&P[2]&P[1]&P[0]&cin);

    assign Gm = G[3]|P[3]&G[2]|P[3]&P[2]&G[1]|P[3]&P[2]&P[1]&G[0];
    assign Pm = P[3]&P[2]&P[1]&P[0];

endmodule
