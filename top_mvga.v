`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    11:28:40 04/18/2016 
// Design Name: 
// Module Name:    top_mvga 
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
module top_mvga(btn_aum, 
					graba,
             clk_nexys, 
             direccion, 
             estado, 
             programo, 
             reset, 
             rst_ring, 
             t_horario, 
             A_D, 
             CS, 
             Hsync, 
             RD, 
             txt_rgb, 
             Vsync, 
             WR, 
             AD,
				 clk_nexys_out);

    input btn_aum;
	 input graba;
    input clk_nexys;
    input [3:0] direccion;
    input [1:0] estado;
    input programo;
    input reset;
    input rst_ring;
    input t_horario;
   output A_D;
   output CS;
   output Hsync;
   output RD;
   output [2:0] txt_rgb;
   output Vsync;
   output WR;
    inout [7:0] AD;
	 output clk_nexys_out;
   
	assign clk_nexys_out=clk_nexys;
   wire [3:0] XLXN_18;
   wire [7:0] XLXN_19;
   wire [7:0] XLXN_20;
   wire [7:0] XLXN_21;
   wire [7:0] XLXN_22;
   wire [7:0] XLXN_23;
   wire [7:0] XLXN_24;
   wire [7:0] XLXN_25;
   wire [7:0] XLXN_26;
   wire [7:0] XLXN_27;
   
   maquinaglobal  XLXI_1 (.aumenta_i(btn_aum), 
                         .cambio_i(direccion[3:0]), 
                         .clk_i(clk_nexys), 
                         .estado_i(estado[1:0]), 
                         .horario_i(t_horario), 
                         .pulsoprogramo(programo),
                         .reset_i(reset),
								 .graba_i(graba),								 
                         .AD_o(A_D), 
                         .chipselecc_o(CS), 
                         .RD(RD), 
                         .regano(XLXN_24[7:0]), 
                         .regdate(XLXN_22[7:0]), 
                         .reghora(XLXN_21[7:0]), 
                         .regmes(XLXN_23[7:0]), 
                         .regmin(XLXN_20[7:0]), 
                         .regseg(XLXN_19[7:0]), 
                         .regThora(XLXN_25[7:0]), 
                         .regTmin(XLXN_26[7:0]), 
                         .regTseg(XLXN_27[7:0]), 
                         .state(XLXN_18[3:0]), 
                         .WR(WR), 
                         .salient(AD[7:0]));
   AcplVGA  XLXI_2 (.ano(XLXN_24[7:0]), 
                   .clk(clk_nexys), 
                   .cursor(estado[1]), 
                   .date(XLXN_22[7:0]), 
                   .dirsel(XLXN_18[3:0]), 
                   .h_hora(XLXN_21[7:0]), 
                   .h_min(XLXN_20[7:0]), 
                   .h_seg(XLXN_19[7:0]), 
                   .mes(XLXN_23[7:0]), 
                   .reset(reset), 
                   .rst_ring(rst_ring), 
                   .t_hora(XLXN_25[7:0]), 
                   .t_min(XLXN_26[7:0]), 
                   .t_seg(XLXN_27[7:0]), 
                   .Hsync(Hsync), 
                   .txt_rgb(txt_rgb[2:0]), 
                   .Vsync(Vsync));
endmodule
