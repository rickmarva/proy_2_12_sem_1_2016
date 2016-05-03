`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Martinez Vallejos
// 
// Create Date:    00:05:57 04/18/2016 
// Design Name: 
// Module Name:    decostate 
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
module decostate(clk,statein,stateout);
input clk;
input wire [3:0] statein;
output reg[3:0] stateout;

   parameter b = 4'b0001;
   parameter c = 4'b0010;
   parameter d = 4'b0011;
   parameter e = 4'b0100;
   parameter f = 4'b0101;
   parameter g = 4'b0110;
   parameter h = 4'b0111;
	parameter i = 4'b1000;
	parameter j = 4'b1001;

	always@(posedge clk)
		begin
		case(statein)
	
				b: stateout=4'b0101;
				c: stateout=4'b0100;
				d: stateout=4'b0011;
				e: stateout=4'b0000;
				f: stateout=4'b0001;
				g: stateout=4'b0010;
				h: stateout=4'b0110;
				i: stateout=4'b0111;
				j: stateout=4'b1000;////	
		endcase
		end
	
	


endmodule

