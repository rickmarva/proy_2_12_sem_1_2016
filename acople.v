`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    16:46:35 04/12/2016 
// Design Name: 
// Module Name:    acople 
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
module acop(ano, 
               clk_i, 
               date, 
               h_hora, 
               h_min, 
               h_seg, 
               mes, 
               sel, 
               T_hora, 
               t_min, 
               t_seg, 
               dec, 
               uni);

    input [7:0] ano;
    input clk_i;
    input [7:0] date;
    input [7:0] h_hora;
    input [7:0] h_min;
    input [7:0] h_seg;
    input [7:0] mes;
    input [3:0] sel;
    input [7:0] T_hora;
    input [7:0] t_min;
    input [7:0] t_seg;
   output [3:0] dec;
   output [3:0] uni;
   
   wire [7:0] XLXN_14;
   
   divisorDU  XLXI_1 (.clk_i(clk_i), 
                     .ent_i(XLXN_14[7:0]), 
                     .dec_o(dec[3:0]), 
                     .uni_o(uni[3:0]));
							
							
							
							
							
   mux8_1  XLXI_2 (.clk_i(clk_i), 
                  .in_0(date[7:0]), 
                  .in_1(mes[7:0]), 
                  .in_2(ano[7:0]), 
                  .in_3(h_hora[7:0]), 
                  .in_4(h_min[7:0]), 
                  .in_5(h_seg[7:0]), 
                  .in_6(T_hora[7:0]), 
                  .in_7(t_min[7:0]), 
                  .in_8(t_seg[7:0]), 
                  .sel(sel[3:0]), 
                  .out_o(XLXN_14[7:0]));
endmodule

