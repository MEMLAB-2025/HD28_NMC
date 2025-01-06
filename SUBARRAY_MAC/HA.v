`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 14:56:25
// Design Name: 
// Module Name: HA
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


module HA(
    //clock and reset

    //input
    a,
    b,

    //output
    sum,
    carry
    );

    //clock and reset

    //input
    input a;
    input b;

    //output
    output sum;
    output carry;

    assign sum = a^b;
    assign carry = a&b;
    
endmodule
