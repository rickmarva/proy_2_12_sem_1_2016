`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    16:03:41 03/29/2016 
// Design Name: 
// Module Name:    DeMUX 
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

//Demultiplexor de decenas

module DeMUX(clk_i,data,sel,sal_0,sal_1,sal_2,sal_3,sal_4,sal_5,sal_6,sal_7,sal_8);
input clk_i;
input [3:0] sel,data;
output reg[3:0] sal_0,sal_1,sal_2,sal_3,sal_4,sal_5,sal_6,sal_7,sal_8;

always@(posedge clk_i)
	begin
		case(sel)
		4'd0: sal_0=data;
		4'd1: sal_1=data;
		4'd2: sal_2=data;
		4'd3: sal_3=data;
		4'd4: sal_4=data;
		4'd5: sal_5=data;
		4'd6: sal_6=data;
		4'd7: sal_7=data;
		4'd8: sal_8=data;
		endcase

	end

endmodule
