`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/23 11:01:50
// Design Name: 
// Module Name: write_FSM
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

///////////////////////mode list////////////////////////
//00: array forming
//01: sparse row forming
//10: array write
//11: sparse row write


module write_FSM(
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,

    //input from TOP
    wren,
    mode,
    data_in,
    init_addr,

    //input from SA
    read_finish,
    SA_out,

    //output to TOP
    //byte_finish,
    request,
    wr_finish,
    vfy_finish,
    fail_detect,
    //writing_fail,
    //fail_addr,
    current_addr,
    expect_data,
    
    //output to LDO
    forming_en,
    set_en,
    reset_en,
    read_en,
    fail_cnt,

    //output to decoder
    address,
    cnt

    //output to driver
    //WL_enable,
    //row_enable,
    //row_sp_enable

    );

    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;

    //input
    //input from TOP
    input wren;
    input [1:0]mode;
    input [7:0]data_in;
    input [20:0]init_addr;

    //input from SA
    input read_finish;
    input [8:0]SA_out;

    //output to TOP
    //output reg byte_finish;
    output reg wr_finish;
    output reg vfy_finish;
    output reg request;
    output reg fail_detect;
    //output reg writing_fail;
    //output reg [20:0]fail_addr;
    output reg [20:0]current_addr;
    output reg [8:0]expect_data;

    //output to LDO
    output reg forming_en;
    output reg set_en;
    output reg reset_en;
    output reg read_en;
    output reg [1:0]fail_cnt;

    //output to decoder
    output reg [20:0]address;

    //output to driver
    //output [511:0]WL_enable;
    //output [2047:0]row_enable;
    //output [15:0]row_sp_enable;

    //wires
    //wire [20:0]address;
    //wire [15:0]sub_address;
    wire sp_out;
    wire [8:0]encode_out;
    wire [7:0]SPARSE;

    //wire SA_out_mux;
    //wire data_write_mux;
    //wire [3:0]mux_cnt;

    //counters
    reg [4:0]set_cnt;
    reg [4:0]reset_cnt;
    reg [7:0]forming_cnt;

    reg [4:0]set_cnt_n;
    reg [4:0]reset_cnt_n;
    reg [7:0]forming_cnt_n;

    //regs
    reg [8:0]data_write;

    reg [3:0]current_state;
    reg [3:0]next_state;

    reg set_bypass;
    reg encoder_en;

    //reg [15:0]address;
    reg [20:0]address_n;
    reg [20:0]current_addr_n;

    /*
    reg [2:0]nvALU_addr;
    reg [2:0]nvALU_addr_n;
    reg [1:0]sub_array;
    reg [1:0]sub_array_n;
    reg [8:0]column_addr;
    reg [8:0]column_addr_n;
    reg [6:0]row_addr;
    reg [6:0]row_addr_n;
    */


    reg vfy_correct;

    output reg [3:0]cnt;
    reg [3:0]cnt_n;
    //reg [2:0]fail_cnt;
    reg [1:0]fail_cnt_n;
    //reg [3:0]vfy_cnt;

    //parameters
    parameter IDLE = 4'b0000, FORMING = 4'b0001, WAIT = 4'b0010, SET = 4'b0011, RESET = 4'b0100, 
              VERIFY = 4'b0101, ADDRESS = 4'b0110, JUDGE = 4'b0111, FAIL = 4'b1000, DELAY = 4'b1001, ENCODE = 4'b1010,
              DELAY_VERIFY = 4'b1011, DELAY_JUDGE = 4'b1100;

    //code
    //assign address = {nvALU_addr, sub_array, column_addr, row_addr};
    //assign sub_address = {column_addr, row_addr};

    always @(posedge sys_clk or negedge rst_n) begin
        if(!rst_n)begin
            current_state <= IDLE;
            address <= 0;

            /*
            nvALU_addr <= 0;
            sub_array <= 0;
            column_addr <= 0;
            row_addr <= 0;
            */

            cnt <= 0;
            fail_cnt <= 0;

            set_cnt <= 0;
            reset_cnt <= 0;
            forming_cnt <= 0;
        end
        else begin
            current_state <= next_state;
            address <= address_n;
            /*
            nvALU_addr <= init_addr[20:18] + nvALU_addr_n;
            sub_array <= init_addr[17:16] + sub_array_n;
            column_addr <= init_addr[15:7] + column_addr_n;
            row_addr <= init_addr[6:0] + row_addr_n;
            */

            cnt <= cnt_n;
            fail_cnt <= fail_cnt_n;

            set_cnt <= set_cnt_n;
            reset_cnt <= reset_cnt_n;
            forming_cnt <= forming_cnt_n;
        end
    end

    always @(*) begin

        /*
        data_write_mid[8] = data_write[0];
        data_write_mid[7] = data_write[1];
        data_write_mid[6] = data_write[2];
        data_write_mid[5] = data_write[3];
        data_write_mid[4] = data_write[4];
        data_write_mid[3] = data_write[5];
        data_write_mid[2] = data_write[6];
        data_write_mid[1] = data_write[7];
        data_write_mid[0] = data_write[8];

        SA_out_mid[8] = SA_out[0];
        SA_out_mid[7] = SA_out[1];
        SA_out_mid[6] = SA_out[2];
        SA_out_mid[5] = SA_out[3];
        SA_out_mid[4] = SA_out[4];
        SA_out_mid[3] = SA_out[5];
        SA_out_mid[2] = SA_out[6];
        SA_out_mid[1] = SA_out[7];
        SA_out_mid[0] = SA_out[8];
        */

        case (current_state)
            //����״̬����sys_enΪ��־
            IDLE: begin
                //output to TOP
                //byte_finish = 0;
                wr_finish = 0;
                request = 0;
                fail_detect = 0;
                //fail_addr = 0;
                current_addr = init_addr;
                expect_data = 0;

                //output to LDO
                forming_en = 0;
                set_en = 0;
                reset_en = 0;
                read_en = 0;

                //inside regs
                vfy_finish = 0;
                vfy_correct = 0;
                cnt_n = 0;
                fail_cnt_n = 0;
                set_bypass = 0;
                encoder_en = 0;
                //mux_cnt = 0;
                //vfy_cnt = 0;

                //counters
                set_cnt_n = 0;
                reset_cnt_n = 0;
                forming_cnt_n = 0;

                if(sys_en)begin
                    next_state = DELAY;
                    address_n = init_addr;
                end
                else begin
                    //state
                    next_state = IDLE;

                    //address
                    address_n = 0;
                    /*
                    nvALU_addr_n = 0;
                    sub_array_n = 0;
                    column_addr_n = 0;
                    row_addr_n = 0;
                    */
                    
                end
            end

            //����ȫ�����н���Forming����ɺ����е�Ԫ���ǵ����?
            FORMING: begin
                vfy_finish = 0;
                vfy_correct = 0;
                //fail_detect = 0;
                request = 0;
                forming_en = 1;
                set_en = 0;
                reset_en = 0;
                read_en = 0;
                vfy_correct = 0;
                if(forming_cnt == 8'd250) begin
                    forming_cnt_n = 0;
                    next_state = DELAY_VERIFY;
                end
                else begin
                    forming_cnt_n = forming_cnt+1;
                    next_state = FORMING;
                end
            end

            //ÿ��INPUT��״̬����������ģʽ�����¸�״̬����FORMING��write
            WAIT: begin
                //request = 1;
                if(sys_en) begin
                    if(wren) begin
                        if(!mode[1]) begin //forming�׶�ֱ��judge
                            next_state = DELAY_JUDGE; 
                        end
                        else begin //д��׶���ϡ�����
                            encoder_en = 1;
                            next_state = ENCODE;
                        end
                        if(mode[0]) begin
                            cnt_n = 1;
                        end
                        else begin
                            cnt_n = 0;
                        end
                    end
                    else begin
                        next_state = WAIT;
                    end
                    fail_detect = 0;
                end
                else begin
                    next_state = IDLE;
                end
            end

            //1������ʱ�����TOP������
            DELAY: begin
                request = 1;
                next_state = WAIT;
            end

            DELAY_VERIFY: begin
                request = 0;
                set_en = 0;
                reset_en = 0;
                forming_en = 0;
                read_en = 1;
                if(!read_finish) begin
                    next_state = VERIFY;
                end
                else begin
                    next_state = DELAY_VERIFY;
                end
            end

            DELAY_JUDGE: begin
                request = 0;
                read_en = 1;
                encoder_en = 0;
                if(!read_finish) begin
                    next_state = JUDGE;
                end
                else begin
                    next_state = DELAY_JUDGE;
                end
            end

            //Ȩ�ر���
            ENCODE: begin
                request = 0;
                //fail_detect = 0;
                expect_data = 0;
                if(mode[0]) begin
                    data_write = {data_in, {1'b0}};
                end
                else begin
                    data_write = encode_out;
                end
                next_state = DELAY_JUDGE;
            end

            //����������������£����Ƚ�SET
            //ÿbit��Ҫ����set��verify
            SET: begin
                //request = 0;
                set_en = 1;
                forming_en = 0;
                reset_en = 0;
                read_en = 0;
                vfy_correct = 0;
                if(set_cnt == 5'd25) begin
                    set_cnt_n = 0;
                    next_state = DELAY_VERIFY;
                end
                else begin
                    set_cnt_n = set_cnt+1;
                    next_state = SET;
                end     
            end

            //SET����RESET
            //ÿbit��ҪRESET��Verify
            RESET: begin
                //request = 0;
                reset_en = 1;
                forming_en = 0;
                set_en = 0;
                read_en = 0;
                vfy_correct = 0;
                if(reset_cnt == 5'd25) begin
                    reset_cnt_n = 0;
                    next_state = DELAY_VERIFY;
                end
                else begin
                    reset_cnt_n = reset_cnt+1;
                    next_state = RESET;
                end
            end

            //ÿ��SET��RESET��Ҫ�����������VERIFY����buffer�е����ݽ��бȽ�
            VERIFY: begin
                read_en = 0;
                forming_en = 0;
                set_en = 0;
                reset_en = 0;
                case(mode)
                    //����forming
                    2'b00: begin
                        if(cnt == 4'b1000) begin
                            if(SA_out[cnt] == 1) begin
                                cnt_n = 0;
                                //mux_cnt = 0;
                                vfy_finish = 1;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                current_addr = address;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                        else begin
                            if(SA_out[cnt] == 1) begin
                                cnt_n = cnt + 1;
                                //mux_cnt = mux_cnt+1;
                                vfy_finish = 0;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                next_state = JUDGE;
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                    end

                    //ϡ��forming
                    2'b01: begin
                        if(cnt == 4'b1000) begin
                            if(SA_out[cnt] == 1) begin
                                cnt_n = 1;
                                //mux_cnt = 0;
                                vfy_finish = 1;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                current_addr = address;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                        else begin
                            if(SA_out[cnt] == 1) begin
                                cnt_n = cnt+1;
                                //mux_cnt = mux_cnt+1;
                                vfy_finish = 0;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                next_state = JUDGE;
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                    end

                    //����write
                    2'b10: begin
                        if(cnt == 4'b1000) begin
                            if(data_write[cnt] == SA_out[cnt]) begin
                                cnt_n = 0;
                                //mux_cnt = 0;
                                vfy_finish = 1;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                current_addr = address;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                        else begin
                            if(data_write[cnt] == SA_out[cnt]) begin
                                cnt_n = cnt+1;
                                //mux_cnt = mux_cnt+1;
                                vfy_finish = 0;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                next_state = JUDGE;
                                /*
                                if(set_bypass) begin
                                    next_state = RESET;
                                end
                                else begin
                                    next_state = JUDGE;
                                end
                                */
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                    end

                    //ϡ��write
                    2'b11: begin
                        if(cnt == 4'b1000) begin
                            if(data_write[cnt] == SA_out[cnt]) begin
                                cnt_n = 1;
                                //mux_cnt = 0;
                                vfy_finish = 1;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                current_addr = address;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                        else begin
                            if(data_write[cnt] == SA_out[cnt]) begin
                                cnt_n = cnt+1;
                                //mux_cnt = mux_cnt+1;
                                vfy_finish = 0;
                                vfy_correct = 1;
                                fail_cnt_n = 0;
                                next_state = JUDGE;
                                /*
                                if(set_bypass) begin
                                    next_state = RESET;
                                end
                                else begin
                                    next_state = JUDGE;
                                end
                                */
                            end
                            else begin
                                cnt_n = cnt_n;
                                //mux_cnt = mux_cnt;
                                vfy_finish = 0;
                                vfy_correct = 0;
                                fail_cnt_n = fail_cnt_n;
                                next_state = FAIL;
                            end
                        end
                    end
                endcase
            end

            //��һ����ȫ��forming���д��֮�󣬶���һ����???
            ADDRESS: begin
                read_en = 0;
                if(mode[0]) begin
                    address_n = address+128;
                end
                else begin
                    address_n = address+1;
                end
                next_state = DELAY;
                /*
                if(address == 21'b111111111111111111111) begin
                    
                    row_addr_n = row_addr_n+1;
                    column_addr_n = column_addr_n+1;
                    sub_array_n = sub_array_n+1;
                    nvALU_addr_n = nvALU_addr_n+1;
                    
                    next_state = WREND;
                end
                else begin
                    next_state = WAIT;
                end
                */
            end

            //��1bit���SET��RESET���ж���һbit��ҪSET����RESET
            JUDGE: begin
                if(!mode[1]) begin //forming
                    read_en = 0;
                    request = 0;
                    vfy_finish = 0;
                    vfy_correct = 0;
                    //fail_detect = 0;
                    encoder_en = 0;
                    //ϡ���ж�
                    /*
                    if(data_write[8]) begin
                        set_bypass = 1;
                    end
                    else begin
                        set_bypass = 0;
                    end
                    */

                    //��һ״̬�ж�
                    if(!mode[0]) begin //����
                        if(SA_out[cnt]) begin
                            if(cnt == 4'b1000) begin
                                cnt_n = 0;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt+1;
                                next_state = JUDGE;
                            end
                        end
                        else begin
                            next_state = FORMING;
                        end
                    end
                    else begin//ϡ���???8��
                        if(SA_out[cnt]) begin
                            if(cnt == 4'b1000) begin
                                cnt_n = 1;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt+1;
                                next_state = JUDGE;
                            end
                        end
                        else begin
                            cnt_n = cnt_n;
                            next_state = FORMING;
                        end
                    end
                end

                else begin //write
                    if(!mode[0]) begin //array
                        request = 0;
                        vfy_finish = 0;
                        vfy_correct = 0;
                        //fail_detect = 0;
                        encoder_en = 0;
                        //ϡ���ж�
                        if(data_write[8]) begin
                            set_bypass = 1;
                        end
                        else begin
                            set_bypass = 0;
                        end

                        //��һ״̬�ж�
                        if(data_write[cnt] == SA_out[cnt]) begin
                            if(cnt == 4'b1000) begin
                                cnt_n = 0;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt+1;
                                next_state = JUDGE;
                            end
                        end
                        else begin
                            if(SA_out[cnt]) begin
                                next_state = RESET;
                            end
                            else begin
                                next_state = SET;
                            end
                        end
                    end


                    else begin //sparse
                        request = 0;
                        vfy_finish = 0;
                        vfy_correct = 0;
                        //fail_detect = 0;
                        encoder_en = 0;
                        if(data_write[cnt] == SA_out[cnt]) begin
                            if(cnt == 4'b1000) begin
                                cnt_n = 1;
                                next_state = ADDRESS;
                            end
                            else begin
                                cnt_n = cnt+1;
                                next_state = JUDGE;
                            end
                        end
                        else begin
                            if(SA_out[cnt]) begin
                                next_state = RESET;
                            end
                            else begin
                                next_state = SET;
                            end
                        end
                    end
                end
            end

            //ÿ��forming��writeʧ�ܺ����fail��fail4�κ�������bit
            FAIL: begin
                read_en = 0;
                if(!mode[0]) begin
                    if(fail_cnt == 2'b11) begin
                        fail_cnt_n = 0;
                        if(mode[1]) begin
                            expect_data = data_write;
                        end
                        else begin
                            expect_data = 0;
                        end
                        if(cnt == 4'b1000) begin
                            vfy_finish = 1;
                            cnt_n = 0;
                            next_state = ADDRESS;
                            current_addr = address;
                            fail_detect = 1;
                            /*
                            if(mode[1]) begin
                                expect_data = data_write;
                            end
                            else begin
                                expect_data = 0;
                            end
                            */
                            //mux_cnt = 0;
                        end
                        else begin
                            cnt_n = cnt+1;
                            fail_detect = 1;
                            current_addr = address;
                            next_state = JUDGE;
                            //mux_cnt = mux_cnt+1;
                        end
                    end
                    else begin
                        fail_cnt_n = fail_cnt+1;
                        cnt_n = cnt_n;
                        //mux_cnt = mux_cnt;
                        if(!mode[1]) begin
                            next_state = FORMING;
                        end
                        else begin
                            if(data_write[cnt]) begin
                                next_state = SET;
                            end
                            else begin
                                next_state = RESET;
                            end
                        end
                    end
                end
                else begin
                    if(fail_cnt == 2'b11) begin
                        fail_cnt_n = 0;
                        if(mode[1]) begin
                            expect_data = {data_in, {1'b0}};
                        end
                        else begin
                            expect_data = 0;
                        end
                        if(cnt == 4'b1000) begin
                            vfy_finish = 1;
                            cnt_n = 1;
                            next_state = ADDRESS;
                            current_addr = address;
                            fail_detect = 1;
                            /*
                            if(mode[1]) begin
                                expect_data = {data_in, {1'b0}};
                            end
                            else begin
                                expect_data = 0;
                            end
                            */
                            //mux_cnt = 0;
                        end
                        else begin
                            cnt_n = cnt+1;
                            fail_detect = 1;
                            current_addr = address;
                            next_state = JUDGE;
                            //mux_cnt = mux_cnt+1;
                        end
                    end
                    else begin
                        fail_cnt_n = fail_cnt+1;
                        cnt_n = cnt_n;
                        //mux_cnt = mux_cnt;
                        if(!mode[1]) begin
                            next_state = FORMING;
                        end
                        else begin
                            if(data_write[cnt]) begin
                                next_state = SET;
                            end
                            else begin
                                next_state = RESET;
                            end
                        end
                    end
                end
            end
        endcase
    end

    weight_sparse_enc w1(
        .sys_clk(sys_clk), 
        .sys_en(encoder_en), 
        .rst_n(rst_n), 
        .data_in(data_in), 
        .data_out(encode_out), 
        .sp_out(sp_out), 
        .SPARSE(SPARSE), 
        .sp_col(sp_col));

    //mux_91 m1(.a8(data_write[8]), .a7(data_write[7]), .a6(data_write[6]), .a5(data_write[5]), 
    //          .a4(data_write[4]), .a3(data_write[3]), .a2(data_write[2]), .a1(data_write[1]), .a0(data_write[0]), .cnt(cnt), .data_out(data_write_mux));
    //mux_91 m2(.a8(SA_out[8]), .a7(SA_out[7]), .a6(SA_out[6]), .a5(SA_out[5]), .a4(SA_out[4]), .a3(SA_out[3]), .a2(SA_out[2]), .a1(SA_out[1]), .a0(SA_out[0]), .cnt(cnt), .data_out(SA_out_mux));
    /*
    decoder9_512 wl_address(
        .rst_n(rst_n),
        .address(current_addr[15:7]),
        .WL_enable(WL_enable)
    );

    row_addr sl_bl_address(
        .rst_n(rst_n&(!mode[0])),
        .row_address(current_addr[6:0]),
        .cnt(cnt),
        .bit_en(row_enable)
    );

    decoder4_16 sp_address(
        .dac_en(rst_n&mode[0]),
        .cnt(cnt),
        .bit_en(row_sp_enable)
    );
    */

endmodule
