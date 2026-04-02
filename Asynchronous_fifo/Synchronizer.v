`timescale 1ns / 1ps

module Synchronizer 
                    #(parameter N = 3)
                    ( input clk ,
                      input  rst,      //low reset
                      input [N-1:0] data_in,
                      output reg[N-1:0] data_out
                        );
      reg [N-1 : 0] q1;
                      
      always @(posedge clk)
            if(!rst)
               begin                  
               q1 <= 0;
               data_out<=0;
               end
             else
             begin
                q1<= data_in;
                data_out<=q1;        
             end          
endmodule
