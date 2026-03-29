`timescale 1ns / 1ps

module fifo_tb ; 

//Parameters 
parameter fifo_depth = 8 ;  
parameter fifo_width = 32 ; 

//signals 
reg clk;
reg rst;
reg [fifo_width-1 : 0]data_in;
reg wr_en;
reg rd_en;
wire full;
wire empty; 
wire [fifo_width-1 : 0]data_out;

fifo_top #( fifo_depth,
		   fifo_width ) 
        dut(  clk ,
              rst ,
              data_in,
              wr_en,                 		          // 1 safe to write to fifo	
              rd_en, 					              // 1 safe to  read from fifo
              data_out,
              full,  				              // 1 if full
              empty  );				              // 1 if empty

   // clock Tp = 10ns
    always #5 clk=~clk;
    
    integer k = fifo_depth; 
    
initial
begin 
    clk <= 0;
    rst <= 1;        // *data_out = 0
    wr_en <= 0;
    rd_en <= 0;
    data_in <= 0;
    
    #25 ;          // wait for 2 clk cycle 
    rst <=0;    
    
    #15 ;         // wait for 1 clk cycle
    
    //case 1 : empty
    rd_en <= 1 ;    //*empty = 1 
    # 15;
    rd_en <= 0;
     
    // case 2 : full   
    for (k=0 ; k <= fifo_depth ; k=k+1)
    begin     
         wr_en  = 1;
         data_in = k+1 ;  //* full flag 1 
         #10 ;
    end 
    wr_en <= 0;
  
    // case 3 : read all data 
    for (k=0 ; k < fifo_depth ; k=k+1)
    begin     
             rd_en <= 1; 
             #10 ;
    end 
    rd_en <= 0;
    #10 ;
    rst <= 1 ;
    #10 ;
    rst <= 0;
       
    // case 4 : continuous read write
    for (k=0 ; k <= 16; k=k+1)
        begin     
             wr_en <= 1;
             rd_en <= 1;
             data_in <= k+1 ;
             # 10;
        end
         
end
endmodule