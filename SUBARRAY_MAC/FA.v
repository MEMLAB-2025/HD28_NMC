`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 14:52:07
// Design Name: 
// Module Name: FA
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


module FA(
    //clock and reset

    //input
    a,
    b,
    cin,

    //output
    sum,
    carry
    );

    //clock and reset

    //input
    input a;
    input b;
    input cin;

    //output
    output sum;
    output carry;

    //code
    assign sum = a^b^cin;
    assign carry = (cin&(a^b))|(a&b);
    
endmodule
