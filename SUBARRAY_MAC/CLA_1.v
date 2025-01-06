`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/12 15:42:19
// Design Name: 
// Module Name: CLA_1
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


module CLA_1(
    //clock and reset

    //input
    a,
    b,
    cin,

    //output
    SO,
    Gi,
    Pi
    );

    //clock and reset

    //input
    input a;
    input b;
    input cin;

    //output
    output SO;
    output Gi;
    output Pi;

    //code
    assign Gi = a&b;
    assign Pi = a|b;

    assign SO = a^b^cin;
endmodule
