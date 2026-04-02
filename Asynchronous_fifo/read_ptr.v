`timescale 1ns / 1ps

module read_ptr #(parameter N=3)
    (input rd_clk,
     input rd_en, 
     input rd_rst_n,
     input [N:0]wr_ptr_g_sync,  //synchronized grey pointer 
     output reg[N:0]rd_ptr_g,
     output reg[N:0]rd_ptr_b,
     output reg empty
    );
    
    
   wire [N:0]rd_ptr_nxt_b;
   wire [N:0]rd_ptr_nxt_g;
   wire rd_empty;
   
    assign rd_ptr_nxt_b = rd_ptr_b + (rd_en && !empty);       //binary next location
    assign rd_ptr_nxt_g = ((rd_ptr_nxt_b>>1)^ rd_ptr_nxt_b); //binary to grey
    
    //Pointer logic 
    always @(posedge rd_clk or negedge rd_rst_n)
    begin
            if(!rd_rst_n)
            begin
                rd_ptr_b <= 0;        //current writing location 
                rd_ptr_g <= 0;
            end
            else
            begin
                rd_ptr_b <= rd_ptr_nxt_b;
                rd_ptr_g <= rd_ptr_nxt_g;
            end
    end 
    
    // Full logic 
    always @(posedge rd_clk or negedge rd_rst_n)
    begin
    if(!rd_rst_n)
        empty <= 1;
    else
        empty <= rd_empty;
    end
    
    assign rd_empty = (wr_ptr_g_sync ==rd_ptr_nxt_g);   //Empty logic 
    
endmodule
