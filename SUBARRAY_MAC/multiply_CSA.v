`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 14:58:29
// Design Name: 
// Module Name: multiply_CSA
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


module multiply_CSA(
    //clock and reset

    //input
    a,
    b,

    //output
    mul
    );

    //clock and reset

    //input
    input [7:0]a;
    input [7:0]b;

    //output
    output [15:0]mul;

    //wire
    //中间和
    wire [7:0]mul_mid[7:0];

    //中间进位
    wire [7:1]cout[13:1];

    //中间和
    wire [7:1]sum[13:1];

    //code
    //产生部分积
    assign mul_mid[0] = b[0]?a:0;
    assign mul_mid[1] = b[1]?a:0;
    assign mul_mid[2] = b[2]?a:0;
    assign mul_mid[3] = b[3]?a:0;
    assign mul_mid[4] = b[4]?a:0;
    assign mul_mid[5] = b[5]?a:0;
    assign mul_mid[6] = b[6]?a:0;
    assign mul_mid[7] = b[7]?a:0;

    //第一行乘法
    assign mul[0] = mul_mid[0][0];
    HA h11(.a(mul_mid[0][1]),.b(mul_mid[1][0]),.sum(mul[1]),.carry(cout[1][1]));
    FA f12(.a(mul_mid[0][2]),.b(mul_mid[1][1]),.cin(mul_mid[2][0]),.sum(sum[2][1]),.carry(cout[2][1]));
    FA f13(.a(mul_mid[0][3]),.b(mul_mid[1][2]),.cin(mul_mid[2][1]),.sum(sum[3][1]),.carry(cout[3][1]));
    FA f14(.a(mul_mid[0][4]),.b(mul_mid[1][3]),.cin(mul_mid[2][2]),.sum(sum[4][1]),.carry(cout[4][1]));
    FA f15(.a(mul_mid[0][5]),.b(mul_mid[1][4]),.cin(mul_mid[2][3]),.sum(sum[5][1]),.carry(cout[5][1]));
    FA f16(.a(mul_mid[0][6]),.b(mul_mid[1][5]),.cin(mul_mid[2][4]),.sum(sum[6][1]),.carry(cout[6][1]));
    FA f17(.a(mul_mid[0][7]),.b(mul_mid[1][6]),.cin(mul_mid[2][5]),.sum(sum[7][1]),.carry(cout[7][1]));
    HA h18(.a(mul_mid[1][7]),.b(mul_mid[2][6]),.sum(sum[8][1]),.carry(cout[8][1]));

    //第二行乘法
    HA h22(.a(sum[2][1]),.b(cout[1][1]),.sum(mul[2]),.carry(cout[2][2]));
    FA f23(.a(sum[3][1]),.b(cout[2][1]),.cin(mul_mid[3][0]),.sum(sum[3][2]),.carry(cout[3][2]));
    FA f24(.a(sum[4][1]),.b(cout[3][1]),.cin(mul_mid[3][1]),.sum(sum[4][2]),.carry(cout[4][2]));
    FA f25(.a(sum[5][1]),.b(cout[4][1]),.cin(mul_mid[3][2]),.sum(sum[5][2]),.carry(cout[5][2]));
    FA f26(.a(sum[6][1]),.b(cout[5][1]),.cin(mul_mid[3][3]),.sum(sum[6][2]),.carry(cout[6][2]));
    FA f27(.a(sum[7][1]),.b(cout[6][1]),.cin(mul_mid[3][4]),.sum(sum[7][2]),.carry(cout[7][2]));
    FA f28(.a(sum[8][1]),.b(cout[7][1]),.cin(mul_mid[3][5]),.sum(sum[8][2]),.carry(cout[8][2]));
    FA f29(.a(mul_mid[2][7]),.b(cout[8][1]),.cin(mul_mid[3][6]),.sum(sum[9][2]),.carry(cout[9][2]));

    //第三行乘法
    HA h33(.a(sum[3][2]),.b(cout[2][2]),.sum(mul[3]),.carry(cout[3][3]));
    FA f34(.a(sum[4][2]),.b(cout[3][2]),.cin(mul_mid[4][0]),.sum(sum[4][3]),.carry(cout[4][3]));
    FA f35(.a(sum[5][2]),.b(cout[4][2]),.cin(mul_mid[4][1]),.sum(sum[5][3]),.carry(cout[5][3]));
    FA f36(.a(sum[6][2]),.b(cout[5][2]),.cin(mul_mid[4][2]),.sum(sum[6][3]),.carry(cout[6][3]));
    FA f37(.a(sum[7][2]),.b(cout[6][2]),.cin(mul_mid[4][3]),.sum(sum[7][3]),.carry(cout[7][3]));
    FA f38(.a(sum[8][2]),.b(cout[7][2]),.cin(mul_mid[4][4]),.sum(sum[8][3]),.carry(cout[8][3]));
    FA f39(.a(sum[9][2]),.b(cout[8][2]),.cin(mul_mid[4][5]),.sum(sum[9][3]),.carry(cout[9][3]));
    FA f310(.a(mul_mid[3][7]),.b(cout[9][2]),.cin(mul_mid[4][6]),.sum(sum[10][3]),.carry(cout[10][3]));

    //第四行乘法
    HA h44(.a(sum[4][3]),.b(cout[3][3]),.sum(mul[4]),.carry(cout[4][4]));
    FA f45(.a(sum[5][3]),.b(cout[4][3]),.cin(mul_mid[5][0]),.sum(sum[5][4]),.carry(cout[5][4]));
    FA f46(.a(sum[6][3]),.b(cout[5][3]),.cin(mul_mid[5][1]),.sum(sum[6][4]),.carry(cout[6][4]));
    FA f47(.a(sum[7][3]),.b(cout[6][3]),.cin(mul_mid[5][2]),.sum(sum[7][4]),.carry(cout[7][4]));
    FA f48(.a(sum[8][3]),.b(cout[7][3]),.cin(mul_mid[5][3]),.sum(sum[8][4]),.carry(cout[8][4]));
    FA f49(.a(sum[9][3]),.b(cout[8][3]),.cin(mul_mid[5][4]),.sum(sum[9][4]),.carry(cout[9][4]));
    FA f410(.a(sum[10][3]),.b(cout[9][3]),.cin(mul_mid[5][5]),.sum(sum[10][4]),.carry(cout[10][4]));
    FA f411(.a(mul_mid[4][7]),.b(cout[10][3]),.cin(mul_mid[5][6]),.sum(sum[11][4]),.carry(cout[11][4]));

    //第五行乘法
    HA h55(.a(sum[5][4]),.b(cout[4][4]),.sum(mul[5]),.carry(cout[5][5]));
    FA f56(.a(sum[6][4]),.b(cout[5][4]),.cin(mul_mid[6][0]),.sum(sum[6][5]),.carry(cout[6][5]));
    FA f57(.a(sum[7][4]),.b(cout[6][4]),.cin(mul_mid[6][1]),.sum(sum[7][5]),.carry(cout[7][5]));
    FA f58(.a(sum[8][4]),.b(cout[7][4]),.cin(mul_mid[6][2]),.sum(sum[8][5]),.carry(cout[8][5]));
    FA f59(.a(sum[9][4]),.b(cout[8][4]),.cin(mul_mid[6][3]),.sum(sum[9][5]),.carry(cout[9][5]));
    FA f510(.a(sum[10][4]),.b(cout[9][4]),.cin(mul_mid[6][4]),.sum(sum[10][5]),.carry(cout[10][5]));
    FA f511(.a(sum[11][4]),.b(cout[10][4]),.cin(mul_mid[6][5]),.sum(sum[11][5]),.carry(cout[11][5]));
    FA f512(.a(mul_mid[5][7]),.b(cout[11][4]),.cin(mul_mid[6][6]),.sum(sum[12][5]),.carry(cout[12][5]));

    //第六行乘法
    HA h66(.a(sum[6][5]),.b(cout[5][5]),.sum(mul[6]),.carry(cout[6][6]));
    FA f67(.a(sum[7][5]),.b(cout[6][5]),.cin(mul_mid[7][0]),.sum(sum[7][6]),.carry(cout[7][6]));
    FA f68(.a(sum[8][5]),.b(cout[7][5]),.cin(mul_mid[7][1]),.sum(sum[8][6]),.carry(cout[8][6]));
    FA f69(.a(sum[9][5]),.b(cout[8][5]),.cin(mul_mid[7][2]),.sum(sum[9][6]),.carry(cout[9][6]));
    FA f610(.a(sum[10][5]),.b(cout[9][5]),.cin(mul_mid[7][3]),.sum(sum[10][6]),.carry(cout[10][6]));
    FA f611(.a(sum[11][5]),.b(cout[10][5]),.cin(mul_mid[7][4]),.sum(sum[11][6]),.carry(cout[11][6]));
    FA f612(.a(sum[12][5]),.b(cout[11][5]),.cin(mul_mid[7][5]),.sum(sum[12][6]),.carry(cout[12][6]));
    FA f613(.a(mul_mid[6][7]),.b(cout[12][5]),.cin(mul_mid[7][6]),.sum(sum[13][6]),.carry(cout[13][6]));

    //第七行乘法
    HA h77(.a(sum[7][6]),.b(cout[6][6]),.sum(mul[7]),.carry(cout[7][7]));
    FA f78(.a(sum[8][6]),.b(cout[7][6]),.cin(cout[7][7]),.sum(mul[8]),.carry(cout[8][7]));
    FA f79(.a(sum[9][6]),.b(cout[8][6]),.cin(cout[8][7]),.sum(mul[9]),.carry(cout[9][7]));
    FA f710(.a(sum[10][6]),.b(cout[9][6]),.cin(cout[9][7]),.sum(mul[10]),.carry(cout[10][7]));
    FA f711(.a(sum[11][6]),.b(cout[10][6]),.cin(cout[10][7]),.sum(mul[11]),.carry(cout[11][7]));
    FA f712(.a(sum[12][6]),.b(cout[11][6]),.cin(cout[11][7]),.sum(mul[12]),.carry(cout[12][7]));
    FA f713(.a(sum[13][6]),.b(cout[12][6]),.cin(cout[12][7]),.sum(mul[13]),.carry(cout[13][7]));
    FA f714(.a(mul_mid[7][7]),.b(cout[13][6]),.cin(cout[13][7]),.sum(mul[14]),.carry(mul[15]));


endmodule
