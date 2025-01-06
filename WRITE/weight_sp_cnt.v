`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/23 11:46:57
// Design Name: 
// Module Name: weight_sp_cnt
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


module weight_sp_cnt(
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,

    //input
    data_in,

    //output
    data_out,
    sp_col

    );

    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;

    //input 
    input data_in;

    //output
    output reg [7:0]data_out;
    output reg sp_col;

    //regs
    reg [6:0]data_mid;

    //code
    always @(posedge sys_clk or negedge rst_n) begin
        if(!rst_n)begin
            data_mid <= 0;
            data_out <= 0;
        end
        else begin
            if(sys_en) begin
                if(data_in)begin
                    data_mid <= data_mid+1;
                    if(data_mid == 7'b1111111)begin
                        data_out <= data_out+1;
                    end
                    else begin
                        data_out <= data_out;
                    end
                end
                else begin
                    data_mid <= 7'b0000000;
                end
            end
            else begin
                data_mid <= data_mid;
            end
        end
    end

    always @(*) begin
        if(data_mid == 7'b1111111)begin
            sp_col = 1;
        end
        else begin
            sp_col = 0;
        end
    end
endmodule