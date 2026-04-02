    `timescale 1ns / 1ps
    
    
    module FIFO_TOP_async#( parameter fifo_depth = 8,
                            parameter fifo_width = 32
                          )
                        (
                          input wr_clk ,
                          input rd_clk ,
                          input wr_rst ,  
                          input rd_rst,                               // low for reset  
                          input [fifo_width-1 : 0]data_in,
                          input wr_en,                 		          // 1 safe to write to fifo	
                          input rd_en, 					              // 1 safe to  read from fifo
                          output [fifo_width-1 : 0]data_out,
                          output full,  				              // 1 if full
                          output empty  				              // 1 if empty
                        );
    
    //Pointer bit calculation
    localparam pointer_bits = $clog2(fifo_depth);   
    
    //Read pointer      
    wire [pointer_bits:0]rd_ptr_g;      //input write sync 
    wire [pointer_bits:0]rd_ptr_b_sync; //input write pointer binary pointer 
    wire [pointer_bits:0]rd_ptr_b;      // input fifo buffer 
    
    //Write pointer
    wire [pointer_bits:0]wr_ptr_g;      //input read sync 
    wire [pointer_bits:0]wr_ptr_b_sync; //input read pointer binary pointer 
    wire [pointer_bits:0]wr_ptr_b;      // input fifo buffer 
    
    Synchronizer  #(pointer_bits+1) sync_wr (wr_clk,wr_rst,rd_ptr_g,rd_ptr_b_sync);       //write synchroniser
    Synchronizer  #(pointer_bits+1) sync_rd (rd_clk,rd_rst,wr_ptr_g,wr_ptr_b_sync);       //read synchroniser
    
    write_ptr    # (pointer_bits) wr_ptr (wr_clk,wr_en,wr_rst,rd_ptr_b_sync,wr_ptr_g,wr_ptr_b,full);    
    read_ptr     # (pointer_bits) rd_ptr (rd_clk,rd_en,rd_rst,wr_ptr_b_sync,rd_ptr_g,rd_ptr_b,empty);    
    
    fifo_buff    #(fifo_depth,fifo_width,pointer_bits) buff(wr_clk,rd_clk,data_in,wr_en,rd_en,full,empty,wr_ptr_b,rd_ptr_b,data_out);
    
    endmodule
