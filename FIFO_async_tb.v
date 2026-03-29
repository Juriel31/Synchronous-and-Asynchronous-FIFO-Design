`timescale 1ns / 1ps

module FIFO_async_tb;

parameter fifo_depth = 8;
parameter fifo_width = 32;

localparam pointer_bits = $clog2(fifo_depth);

// DUT signals
reg wr_clk;
reg rd_clk;
reg wr_rst;
reg rd_rst;

reg  [fifo_width-1:0] data_in;
reg  wr_en;
reg  rd_en;

wire [fifo_width-1:0] data_out;
wire full;
wire empty;

// Instantiate DUT
FIFO_TOP_async #(
    .fifo_depth(fifo_depth),
    .fifo_width(fifo_width)
) DUT (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_rst(wr_rst),
    .rd_rst(rd_rst),
    .data_in(data_in),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// clock generation
always #5  wr_clk = ~wr_clk;   // 10ns period
always #7  rd_clk = ~rd_clk;   // 14ns period

integer k;

initial
begin 
    wr_clk = 0;
    rd_clk = 0;
    wr_rst = 0; 
    rd_rst = 0;
    wr_en  = 0;
    rd_en  = 0;
    data_in = 0;

    // Apply reset
    #20;
    wr_rst = 1; 
    rd_rst = 1;     

    #20;

    // case 1 : empty read attempt
    rd_en = 1;    
    #20;
    rd_en = 0;
     
    // case 2 : write until full   
    for (k = 0; k < fifo_depth; k = k + 1)
    begin     
         wr_en  = 1;
         data_in = k + 1;  
         #10;
    end 
    wr_en = 0;
  
    #20;

    // case 3 : read all data 
    for (k = 0; k < fifo_depth; k = k + 1)
    begin     
         rd_en = 1; 
         #10;
    end 
    rd_en = 0;

    #20;

    // reset again
    wr_rst = 0;
    rd_rst = 0;
    #20;
    wr_rst = 1;
    rd_rst = 1;
       
    // case 4 : continuous read write
    for (k = 0; k < 16; k = k + 1)
    begin     
         wr_en  = 1;
         rd_en  = 1;
         data_in = k + 1;
         #10;
    end

    wr_en = 0;
    rd_en = 0;

    #50;
    $stop;
end

endmodule