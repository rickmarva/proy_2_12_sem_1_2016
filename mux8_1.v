`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    16:18:34 04/12/2016 
// Design Name: 
// Module Name:    mux8_1 
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
module mux8_1(clk_i,sel,in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,in_8,out_o);

input clk_i;
input [3:0] sel;
input [7:0]in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,in_8;
output reg[7:0] out_o;

always @(posedge clk_i)
      case (sel)
			4'b0000: out_o = in_0;
         4'b0001: out_o = in_1;
         4'b0010: out_o = in_2;
         4'b0011: out_o = in_3;
         4'b0100: out_o = in_4;
         4'b0101: out_o = in_5;
         4'b0110: out_o = in_6;
         4'b0111: out_o = in_7;
         4'b1000: out_o = in_8;
			
      endcase
		


endmodule
