`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    18:26:18 04/12/2016 
// Design Name: 
// Module Name:    AcplVGA 
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
module AcplVGA(ano, 
                 clk, 
                 cursor, 
                 date, 
                 dirsel, 
                 h_hora, 
                 h_min, 
                 h_seg, 
                 mes, 
                 reset, 
                 rst_ring, 
                 t_min, 
                 t_seg, 
                 t_hora, 
                 Hsync, 
                 txt_rgb, 
                 Vsync);

    input [7:0] ano;
    input clk;
    input cursor;
    input [7:0] date;
    input [3:0] dirsel;
    input [7:0] h_hora;
    input [7:0] h_min;
    input [7:0] h_seg;
    input [7:0] mes;
    input reset;
    input rst_ring;
    input [7:0] t_min;
    input [7:0] t_seg;
    input [7:0] t_hora;
   output Hsync;
   output [2:0] txt_rgb;
   output Vsync;
   
   wire [3:0] XLXN_21;
   wire [3:0] XLXN_22;
   
   topVGA  cntrlvga (.cursor(cursor), 
                  .decenas(XLXN_21[3:0]), 
                  .direccion(dirsel[3:0]), 
                  .reloj(clk), 
                  .reset(reset), 
                  .rsw(rst_ring), 
                  .unidades(XLXN_22[3:0]), 
                  .Hsync(Hsync), 
                  .rgb_o(txt_rgb[2:0]), 
                  .Vsync(Vsync));
   acop  acople (.ano(ano[7:0]), 
                .clk_i(clk), 
                .date(date[7:0]), 
                .h_hora(h_hora[7:0]), 
                .h_min(h_min[7:0]), 
                .h_seg(h_seg[7:0]), 
                .mes(mes[7:0]), 
                .sel(dirsel[3:0]), 
                .T_hora(t_hora[7:0]), 
                .t_min(t_min[7:0]), 
                .t_seg(t_seg[7:0]), 
                .dec(XLXN_21[3:0]), 
                .uni(XLXN_22[3:0]));
endmodule
