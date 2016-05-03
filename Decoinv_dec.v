`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    13:15:28 04/18/2016 
// Design Name: 
// Module Name:    Decoinv_dec 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Decoinv_dec(reset,clk,code_i,out_o);

input clk,reset;
output reg [3:0] out_o;
   
input [3:0] code_i;

always @(posedge clk)
if (reset)
         out_o <= 4'b0;
      else
         case (code_i)
            4'b0000  : out_o <= 4'b0101;
            4'b0001  : out_o <= 4'b0100;
            4'b0010  : out_o <= 4'b0011;
            4'b0011  : out_o <= 4'b0010;
				4'b0100  : out_o <= 4'b0001;
           default : out_o <= 4'b0;
         endcase
				

endmodule