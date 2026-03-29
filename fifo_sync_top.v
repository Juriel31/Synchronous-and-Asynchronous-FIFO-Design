`timescale 1ns / 1ps

//8 bit 
    module fifo_top 
		#( parameter fifo_depth = 8,
		   parameter fifo_width = 32
		  ) 
		
		(
		  input clk ,
		  input rst ,                                 // 1 for reset  
		  input [fifo_width-1 : 0]data_in,
		  input wr_en,                 		          // 1 safe to write to fifo	
		  input rd_en, 					              // 1 safe to  read from fifo
		  output reg[fifo_width-1 : 0]data_out,
		  output full,  				              // 1 if full
		  output empty  				              // 1 if empty
		);

		localparam pointer_bits = $clog2(fifo_depth);       // pointer bits calculation 
		
		reg [pointer_bits : 0]wr_ptr = 0;		           //write pointer
		reg [pointer_bits : 0]rd_ptr = 0;		           //read pointer 

		reg [fifo_width -1 : 0]  fifo[0 : fifo_depth -1] ;
		
		//write to fifo
		always @(posedge clk)
			begin
			if (rst)
			   begin
			    wr_ptr   <= 0;
			   end
			else if(wr_en && !full )
				begin
					fifo[wr_ptr[pointer_bits-1 : 0]] <= data_in;
					wr_ptr <= wr_ptr + 1'b1;
			        end	
			end

		//read from fifo
		always @(posedge clk)
			begin
			if (rst)
			   begin
			    data_out <= 0;
			    rd_ptr   <= 0;
			   end
			else if(rd_en && !empty)
				begin
					data_out <= fifo[rd_ptr[pointer_bits-1 : 0]];
					rd_ptr <= rd_ptr + 1'b1;
				end
			end
       
                
		//full and empty logic (circular buffer)
		assign  full = (rd_ptr == {!wr_ptr[pointer_bits] , wr_ptr[pointer_bits-1:0]});
		assign  empty =  (wr_ptr == rd_ptr);
        
       

endmodule
