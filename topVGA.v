`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    16:04:50 03/29/2016 
// Design Name: 
// Module Name:    topVGA 
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
module topVGA(reloj,cursor, 
                     decenas, 
                     direccion, 
                     reset, 
                     rsw, 
                     unidades, 
                     Hsync, 
                     rgb_o, 
                     Vsync);

    input wire reloj,cursor;
    input wire[3:0] decenas;
    input wire[3:0] direccion;
    input wire reset;
    input wire rsw;
    input wire [3:0] unidades;
   output Hsync;
   output [2:0] rgb_o;
   output Vsync;
   
   wire [9:0] XLXN_15;
   wire [9:0] XLXN_36;
   wire [3:0] XLXN_59;
   wire [3:0] XLXN_60;
   wire [3:0] XLXN_61;
   wire [3:0] XLXN_62;
   wire [3:0] XLXN_63;
   wire [3:0] XLXN_64;
   wire [3:0] XLXN_65;
   wire [3:0] XLXN_66;
   wire [3:0] XLXN_67;
   wire [3:0] XLXN_69;
   wire [3:0] XLXN_70;
   wire [3:0] XLXN_71;
   wire [3:0] XLXN_72;
   wire [3:0] XLXN_73;
   wire [3:0] XLXN_74;
   wire [3:0] XLXN_75;
   wire [3:0] XLXN_76;
   wire [3:0] XLXN_77;
   wire XLXN_78;
	
	wire [3:0] Tmindec;
	wire [3:0] Tminuni;
	
	wire [3:0] Tsegdec;
	wire [3:0] Tseguni;
	
	wire [3:0] Thoradec;
	wire [3:0] Thorauni;
	
	
	
   
   DMHz  Divisor (.clk_i(reloj),.clk_o(XLXN_78));
	
   vga_sync  vgasync (.clk(XLXN_78), 
               .reset(reset), 
               .hsync(Hsync), 
               .pixel_x(XLXN_15[9:0]), 
               .pixel_y(XLXN_36[9:0]), 
               .vsync(Vsync));
					
   gentexto  Genarador (.ano_d(XLXN_63[3:0]), 
                      .ano_u(XLXN_64[3:0]), 
                      .clk_i(reloj),
							 .cursor(cursor),
							 .dir(direccion), 		
                      .fecha_d(XLXN_59[3:0]), 
                      .fecha_u(XLXN_60[3:0]), 
                      .H_hora_d(XLXN_65[3:0]), 
                      .H_hora_u(XLXN_66[3:0]), 
                      .H_min_d(XLXN_67[3:0]), 
                      .H_min_u(XLXN_69[3:0]), 
                      .H_seg_d(XLXN_70[3:0]), 
                      .H_seg_u(XLXN_71[3:0]), 
                      .mes_d(XLXN_61[3:0]), 
                      .mes_u(XLXN_62[3:0]), 
                      .pix_x(XLXN_15[9:0]), 
                      .pix_y(XLXN_36[9:0]), 
                      .rsw(rsw), 
                      .T_hora_d(Thoradec), 
                      .T_hora_u(Thorauni), 
                      .T_min_d(Tmindec), 
                      .T_min_u(Tminuni), 
                      .T_seg_d(Tsegdec), 
                      .T_seg_u(Tseguni), 
                      .text_rgb(rgb_o[2:0]));
							 
							 
							 
	Decoinv_dec Inv1_Tsegdec(.reset(reset),.clk(reloj),.code_i(XLXN_76[3:0]),.out_o(Tsegdec));
	Decoinv_uni Inv2_Tseguni(.reset(reset),.clk(reloj),.code_i(XLXN_77[3:0]),.out_o(Tseguni));	
	
	Decoinv_dec Inv1_Tmindec(.reset(reset),.clk(reloj),.code_i(XLXN_74[3:0]),.out_o(Tmindec));
	Decoinv_uni Inv2_Tminuni(.reset(reset),.clk(reloj),.code_i(XLXN_75[3:0]),.out_o(Tminuni));
	
	Decoinv_Thora Inv_t_hora(.reset(reset),.clk(reloj),.code_dec(XLXN_72[3:0]),.code_uni(XLXN_73[3:0]),.outdec(Thoradec),.outuni(Thorauni));
	
	
							 
   DeMUX  Decenas (.clk_i(reloj), 
                 .data(decenas[3:0]), 
                 .sel(direccion[3:0]), 
                 .sal_0(XLXN_59[3:0]), 
                 .sal_1(XLXN_61[3:0]), 
                 .sal_2(XLXN_63[3:0]), 
                 .sal_3(XLXN_65[3:0]), 
                 .sal_4(XLXN_67[3:0]), 
                 .sal_5(XLXN_70[3:0]), 
                 .sal_6(XLXN_72[3:0]), 
                 .sal_7(XLXN_74[3:0]), 
                 .sal_8(XLXN_76[3:0]));
					  
   DeMUX  Unidades(.clk_i(reloj), 
                 .data(unidades[3:0]), 
                 .sel(direccion[3:0]), 
                 .sal_0(XLXN_60[3:0]), 
                 .sal_1(XLXN_62[3:0]), 
                 .sal_2(XLXN_64[3:0]), 
                 .sal_3(XLXN_66[3:0]), 
                 .sal_4(XLXN_69[3:0]), 
                 .sal_5(XLXN_71[3:0]), 
                 .sal_6(XLXN_73[3:0]), 
                 .sal_7(XLXN_75[3:0]), 
                 .sal_8(XLXN_77[3:0]));
					  
endmodule

