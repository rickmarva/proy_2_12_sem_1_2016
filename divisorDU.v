`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    16:34:30 04/12/2016 
// Design Name: 
// Module Name:    divisorDU 
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
module divisorDU(clk_i,ent_i,dec_o,uni_o);

input clk_i;
input [7:0] ent_i;
output reg [3:0] dec_o,uni_o;

always@(posedge clk_i)
	begin
	// separando decenas
		dec_o[0]=ent_i[4];
		dec_o[1]=ent_i[5];
		dec_o[2]=ent_i[6];
		dec_o[3]=ent_i[7];
		
	// separando unidades	
		uni_o[0]=ent_i[0];
		uni_o[1]=ent_i[1];
		uni_o[2]=ent_i[2];
		uni_o[3]=ent_i[3];
		
	
	end




endmodule
