`timescale 1ns / 1ps

module write_ptr #(parameter N=3)
    (input wr_clk,
     input wr_en, 
     input wr_rst_n,
     input [N:0]rd_ptr_g_sync,  //synchronized grey pointer 
     output reg[N:0]wr_ptr_g,
     output reg[N:0]wr_ptr_b,
     output reg full
    );
    
    
   wire [N:0]wr_ptr_nxt_b;
   wire [N:0]wr_ptr_nxt_g;
   wire wr_full;
   
    assign wr_ptr_nxt_b = wr_ptr_b + (wr_en && !full);       //binary next location
    assign wr_ptr_nxt_g = ((wr_ptr_nxt_b>>1)^ wr_ptr_nxt_b); //binary to grey
    
    //Pointer logic 
    always @(posedge wr_clk or negedge wr_rst_n)
    begin
            if(!wr_rst_n)
            begin
                wr_ptr_b <= 0;        //current writing location 
                wr_ptr_g <= 0;
            end
            else
            begin
                wr_ptr_b <= wr_ptr_nxt_b;
                wr_ptr_g <= wr_ptr_nxt_g;
            end
    end 
    
    // Full logic 
    always @(posedge wr_clk or negedge wr_rst_n)
    begin
    if(!wr_rst_n)
        full <= 0;
    else
        full <= wr_full;
    end
    
    assign wr_full = (rd_ptr_g_sync =={~wr_ptr_nxt_g [N:N-1], wr_ptr_nxt_g[N-2:0]});   //Full logic 
    
endmodule
