`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    15:54:27 03/29/2016 
// Design Name: 
// Module Name:    DMHz 
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
//Divisor de frecuencia de 100Mhz a 50Mhz
module DMHz(input clk_i,output reg clk_o=1'b0 );

 
	always@(posedge clk_i)
			begin

			clk_o=~clk_o;
			end

endmodule

