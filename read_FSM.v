`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/03 22:20:58
// Design Name: 
// Module Name: read_FSM
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


module read_FSM(
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,

    //input from TOP
    mode,
    rden,
    init_addr,

    //input from SA
    read_finish,
    SA_out,

    //output to TOP
    request,
    data_out,
    out_addr,

    //output to SA
    SA_en,

    //output to decoder
    address
    );

<<<<<<< Updated upstream
    //123456

=======
>>>>>>> Stashed changes
    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;

    //input from TOP
    input mode;
    input rden;
    input [20:0]init_addr;

    //input from SA
    input read_finish;
    input [8:0]SA_out;

    //output to TOP
    output reg request;
    output reg [8:0]data_out;
    output reg [20:0]out_addr;

    //output to SA
    output reg SA_en;

    //output to decoder
    output reg [20:0]address;

    //wires

    //regs
    reg [2:0]current_state;
    reg [2:0]next_state;

    reg [20:0]address_n;

    //parameters
    parameter IDLE = 3'b000, WAIT = 3'b001, READ = 3'b010, ADDR = 3'b011, DELAY = 3'b100, DELAY_READ = 3'b101;

    //code
    always @(posedge sys_clk or negedge rst_n) begin
        if(!rst_n)begin
            current_state <= IDLE;
            address <= 0;
        end
        else begin
            current_state <= next_state;
            address <= address_n;
        end
    end

    always @(*) begin
        case (current_state)
            //����״̬���ȴ�enable�ź�
            IDLE: begin
                if(sys_en) begin
                    next_state = WAIT;
                end
                else begin
                    address_n = init_addr;
                    request = 0;
                    data_out = 0;
                    out_addr = 0;
                    SA_en = 0;
                    next_state = IDLE;
                end
            end 

            //WAIT״̬���ݶ�ȡģʽȷ��������Χ
            WAIT: begin
                if(rden) begin
                    next_state = DELAY_READ;
                end
                else begin
                    next_state = WAIT;
                end
            end

            DELAY_READ: begin
                SA_en = 1;
                request = 0;
                out_addr = address;
                if(!read_finish) begin
                    next_state = READ;
                end
                else begin
                    next_state = DELAY_READ;
                end
            end
            
            //�������е�ַ��ȡ����
            READ: begin
                SA_en = 0;
                request = 0;
                //out_addr = address;
                next_state = ADDR;
                if(mode) begin
                    data_out = {SA_out[8:1], {1'b0}};
                end
                else begin
                    data_out = SA_out;
                end
            end

            //��������������ͬʱ��ַ��һ
            ADDR: begin
                //data_out = SA_out;
                if(mode) begin
                    address_n = address+128;
                end
                else begin
                    address_n = address+1;
                end
                next_state = DELAY;
            end

            //�ӳ�һ�����ڣ���ʱrequest���ߣ���TOP��������
            DELAY: begin
                request = 1;
                SA_en = 0;
                next_state = WAIT;
            end
        endcase
    end

endmodule
