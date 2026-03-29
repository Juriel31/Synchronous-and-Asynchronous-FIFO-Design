`timescale 1ns / 1ps

    module fifo_buff
		#( parameter fifo_depth = 8,
		   parameter fifo_width = 32,
		   parameter fifo_ptr_width =3
		  ) 
		
		(
		  input wr_clk ,
		  input rd_clk ,                             
		  input [fifo_width-1 : 0]data_in,
		  input wr_en,                 		          	
		  input rd_en,
		  input full,
		  input empty, 
		  input [fifo_ptr_width : 0]wr_ptr_b,
		  input [fifo_ptr_width : 0]rd_ptr_b,						              
		  output reg[fifo_width-1 : 0]data_out
		);

        
		reg [fifo_width -1 : 0]  fifo[0 : fifo_depth -1] ;
		
		//write to fifo
		always @(posedge wr_clk)
			if(wr_en && !full )
					fifo[wr_ptr_b[fifo_ptr_width-1 : 0]] <= data_in;	
			

		//read from fifo
		always @(posedge rd_clk)
			if(rd_en && !empty )
	           data_out <= fifo[rd_ptr_b[fifo_ptr_width-1 : 0]];

endmodule

