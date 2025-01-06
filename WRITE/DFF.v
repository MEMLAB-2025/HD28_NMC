//Verilog HDL for "HD28_NMC", "DFF" "functional"


module DFF (
    //clock and reset
    sys_clk,
    sys_en,
    rst_n,
    
    //input
    d,
    
    //output
    q );

    //clock and reset
    input sys_clk;
    input sys_en;
    input rst_n;
    
    //input
    input d;
    
    //output
    output reg q;
    
    //code
    always @(posedge sys_clk or negedge rst_n) begin
        if(!rst_n)
            q <= 1'b0;
        else if(sys_en)
            q <= d;
            else    q <= q;
    end

endmodule