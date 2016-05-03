`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    15:57:56 03/29/2016 
// Design Name: 
// Module Name:    gentexto 
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
module gentexto(
    
	 input wire [3:0] fecha_d,fecha_u,mes_d,mes_u,ano_d,ano_u,H_hora_d,H_hora_u,H_min_d,
	 H_min_u,H_seg_d,H_seg_u,T_hora_d,T_hora_u,T_min_d,T_min_u,T_seg_d,T_seg_u,dir,
    input wire [9:0] pix_x, pix_y,
	 input clk_i,input rsw,cursor,
    output reg [2:0] text_rgb
   );
	
	
	//variables de uso interno							
	reg [25:0]cont = 26'b0;//variable de contador para generar 1Hz
	reg clk1_o=1'b0;//senal cambiante de 1Hz
	reg k=1'b0;
	
	
   // signal declaration
   wire [10:0] rom_addr;//direccion de ROM
		
	//signal de direccion de caracter en memoria ROM de objetos
   reg [6:0] char_addr,char_addr_fecha_alf,char_addr_fecha_fecha,
	char_addr_fecha_mes,char_addr_fecha_ano,char_addr_hora_alf,char_addr_hora_hora,char_addr_hora_min,
	char_addr_hora_seg,char_addr_timer_alf,char_addr_timer_hora,char_addr_timer_min,char_addr_timer_seg;
	
   reg [3:0] row_addr;//direccion de fila en la memoria ROM 
	
   //signals de direcciode fila en la ROM de objetos	
   wire [3:0] row_addr_fecha_alf,row_addr_fecha_fecha,
	row_addr_fecha_mes,row_addr_fecha_ano,row_addr_hora_alf,row_addr_hora_hora,row_addr_hora_min,
	row_addr_hora_seg,row_addr_timer_alf,row_addr_timer_hora,row_addr_timer_min,row_addr_timer_seg;
	
   reg [2:0] bit_addr;//direccion de bit en fila de ROM
	
	//direccion de bit de en memoria ROM de objetos	
   wire [2:0] bit_addr_fecha_alf,bit_addr_fecha_fecha,
	bit_addr_fecha_mes,bit_addr_fecha_ano,bit_addr_hora_alf,bit_addr_hora_hora,bit_addr_hora_min,
	bit_addr_hora_seg,bit_addr_timer_alf,bit_addr_timer_hora,bit_addr_timer_min,bit_addr_timer_seg;
	
   wire [7:0] font_word;//Salida de datos en memoria ROM
	
	//signals de activacion de objetos
   wire font_bit, fecha_alf_on,fecha_fecha_on,fecha_mes_on,fecha_ano_on,
	hora_alf_on,hora_hora_on,hora_min_on,hora_seg_on,timer_alf_on,timer_hora_on,timer_min_on,timer_seg_on,ring_on;
	
   	

   // instantiate font ROM
   font_rom font_unit
      (.addr(rom_addr), .data(font_word),.clk(clk_i));
		
		
   //-------------------------------------------
   // Tablero de Fecha literal
	//-----------------------------------------
   assign fecha_alf_on = (pix_y[9:6]==0) &&(0<=pix_x[9:5]) && (pix_x[9:5]<=13);
   assign row_addr_fecha_alf = pix_y[5:2];
   assign bit_addr_fecha_alf = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h0: char_addr_fecha_alf = 7'h00; //  
         4'h1: char_addr_fecha_alf = 7'h46; // F
         4'h2: char_addr_fecha_alf = 7'h45; // E
         4'h3: char_addr_fecha_alf = 7'h43; // C
			4'h4: char_addr_fecha_alf = 7'h48; // H
			4'h5: char_addr_fecha_alf = 7'h41; // A
         4'h6: char_addr_fecha_alf = 7'h00; // 
         4'h7: char_addr_fecha_alf = 7'h4d; // M
			4'h8: char_addr_fecha_alf = 7'h45; // E
         4'h9: char_addr_fecha_alf = 7'h53; // S
         4'ha: char_addr_fecha_alf = 7'h00; //  
			4'hb: char_addr_fecha_alf = 7'h41; // A
			4'hc: char_addr_fecha_alf = 7'h40; // @
			default: char_addr_fecha_alf = 7'h4f; // O
			
      endcase
		
			
   //-------------------------------------------
   // Tablero de Fecha fecha numerico
	//-----------------------------------------
   assign fecha_fecha_on = (pix_y[9:6]==1'b1) &&(5'd2<=pix_x[9:5]) && (pix_x[9:5]<=5'd3);
   assign row_addr_fecha_fecha = pix_y[5:2];
   assign bit_addr_fecha_fecha = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h2: char_addr_fecha_fecha = {3'b011, fecha_d};//Decenas de fecha
			default: char_addr_fecha_fecha = {3'b011, fecha_u};//Unidades de fecha
      endcase
	

	//-----------------------------------------
   // Tablero de Fecha mes numerico
	//-----------------------------------------
   assign fecha_mes_on = (pix_y[9:6]==1) &&(7<=pix_x[9:5]) && (pix_x[9:5]<=8);
   assign row_addr_fecha_mes = pix_y[5:2];
   assign bit_addr_fecha_mes = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h7: char_addr_fecha_mes = {3'b011, mes_d};// Decenas de numero de mes 
         default: char_addr_fecha_mes = {3'b011,mes_u};// Unidades de numero de mes
					
      endcase
		
		
	//-------------------------------------------
   // Tablero de Fecha ano numerico
	//-----------------------------------------
   assign fecha_ano_on = (pix_y[9:6]==1) &&(11<=pix_x[9:5]) && (pix_x[9:5]<=14);
   assign row_addr_fecha_ano = pix_y[5:2];
   assign bit_addr_fecha_ano = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'hb: char_addr_fecha_ano = 7'h32;// 2 de 2016
         4'hc: char_addr_fecha_ano = 7'h30;// 0 de 2016  
			4'hd: char_addr_fecha_ano = {3'b011, ano_d};// Decenas de ano
			default: char_addr_fecha_ano = {3'b011, ano_u};// unidades de ano
		
      endcase		
		
			
	//-------------------------------------------
   // Tablero de Hora literal
	//-----------------------------------------
   assign hora_alf_on = (pix_y[9:6]==2)  && (3<=pix_x[9:5]) && (pix_x[9:5]<=6);
   assign row_addr_hora_alf = pix_y[5:2];
   assign bit_addr_hora_alf = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h3: char_addr_hora_alf = 7'h48; // H
         4'h4: char_addr_hora_alf = 7'h4f; // O
         4'h5: char_addr_hora_alf = 7'h52; // R
         default: char_addr_hora_alf = 7'h41; // A
			
      endcase
		
	//-------------------------------------------
   // Tablero de Hora hora numerico 
	//-----------------------------------------
   assign hora_hora_on = (pix_y[9:6]==3) &&(2<=pix_x[9:5]) && (pix_x[9:5]<=4);
   assign row_addr_hora_hora = pix_y[5:2];
   assign bit_addr_hora_hora = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h2: char_addr_hora_hora = {3'b011, H_hora_d};//decenas de horas
			4'h3: char_addr_hora_hora = {3'b011, H_hora_u};//unidades de horas
			default: char_addr_hora_hora = 7'h3a; // :
         		
      endcase
		
	
	
	//-------------------------------------------
   // Tablero de Hora  minutos numericos 
	//-----------------------------------------
   assign hora_min_on = (pix_y[9:6]==3) &&(5<=pix_x[9:5]) && (pix_x[9:5]<=7);
   assign row_addr_hora_min = pix_y[5:2];
   assign bit_addr_hora_min = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h5: char_addr_hora_min = {3'b011, H_min_d};// Decenas de minutos 
         4'h6: char_addr_hora_min = {3'b011, H_min_u};// Unidades de minutos
			default: char_addr_hora_min = 7'h3a; //   :
      		
      endcase
	
	
	
	//-------------------------------------------
   // Tablero de Hora segundos numericos 
	//-----------------------------------------
   assign hora_seg_on = (pix_y[9:6]==3) &&(8<=pix_x[9:5]) && (pix_x[9:5]<=9);
   assign row_addr_hora_seg = pix_y[5:2];
   assign bit_addr_hora_seg = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h8: char_addr_hora_seg = {3'b011, H_seg_d};// Decenas de segundos 
        	default: char_addr_hora_seg = {3'b011,H_seg_u};// Unidaes de segundos
		
      endcase
	
	
	
	//-------------------------------------------
   // Tablero de Timer literal
	//-------------------------------------------
   assign timer_alf_on = (pix_y[9:6]==4)  && (3<=pix_x[9:5]) && (pix_x[9:5]<=7);
   assign row_addr_timer_alf = pix_y[5:2];
   assign bit_addr_timer_alf = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h3: char_addr_timer_alf = 7'h54; // T
         4'h4: char_addr_timer_alf = 7'h49; // I
         4'h5: char_addr_timer_alf = 7'h4d; // M
			4'h6: char_addr_timer_alf = 7'h45; // E			
         default: char_addr_timer_alf = 7'h52; // R
			
      endcase
		
			
			
			
   
		
		
		//-------------------------------------------
   // Tablero de Timer horas numerico 1
	//-----------------------------------------
   assign timer_hora_on = (pix_y[9:6]==5) &&(2<=pix_x[9:5]) && (pix_x[9:5]<=4);
   assign row_addr_timer_hora = pix_y[5:2];
   assign bit_addr_timer_hora = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h2: char_addr_timer_hora = {3'b011, T_hora_d};//decenas de horas
			4'h3: char_addr_timer_hora = {3'b011, T_hora_u};//unidades de horas
         default: char_addr_timer_hora = 7'h3a; // :
       
		
      endcase
		
		
	
	//-------------------------------------------
   // Tablero de Timer  minutos numerico
	//-----------------------------------------
   assign timer_min_on = (pix_y[9:6]==5) &&(5<=pix_x[9:5]) && (pix_x[9:5]<=7);
   assign row_addr_timer_min = pix_y[5:2];
   assign bit_addr_timer_min = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h5: char_addr_timer_min = {3'b011, T_min_d};// Decenas de minutos 
         4'h6: char_addr_timer_min = {3'b011, T_min_u};// Unidades de minutos
			default: char_addr_timer_min = 7'h3a; //   :
         
		
      endcase
	
		
		
	//-------------------------------------------
   // Tablero de Timer segundos numerico 
	//-----------------------------------------
   assign timer_seg_on = (pix_y[9:6]==5) &&(8<=pix_x[9:5]) && (pix_x[9:5]<=9);
   assign row_addr_timer_seg = pix_y[5:2];
   assign bit_addr_timer_seg = pix_x[4:2];
	always @*
      case(pix_x[8:5])
			4'h8: char_addr_timer_seg = {3'b011, T_seg_d};// Decenas de segundos 
        	default: char_addr_timer_seg = {3'b011, T_seg_u};// Unidaes de segundos
		
      endcase
		
	
	
		
		
		
		
			
	//-------------------------------------------
   // RING
	//-----------------------------------------
   assign ring_on = (pix_y[9:6]==4)  && (4==pix_x[9:6]);
   	
	
always @(posedge clk_i)
		begin
			if(cont == 26'd49999999 && pix_x < 800 && pix_y <525) 
				begin
					cont = 26'b0;
					clk1_o=~clk1_o;
			end
			else
		cont=cont+1'b1; 
		end	
		

				
   //-------------------------------------------
   // mux for font ROM addresses and rgb
   //-------------------------------------------
   always @(posedge clk_i)
	begin
      text_rgb = 3'b000;
		
		//Objeto fecha literal 
      if (fecha_alf_on)
         begin
            char_addr = char_addr_fecha_alf;
				row_addr = row_addr_fecha_alf;
            bit_addr = bit_addr_fecha_alf;
            if (font_bit)
               text_rgb = 3'b001;
				else 
					text_rgb=3'b010;
      end
		
		//Objeto fecha fecha numerico 
		else if (fecha_fecha_on)
         begin
            char_addr = char_addr_fecha_fecha;
				row_addr = row_addr_fecha_fecha;
            bit_addr = bit_addr_fecha_fecha;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0000 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;
						
					
      end
		
		//Objeto fecha mes numerico
		else if (fecha_mes_on)
         begin
            char_addr = char_addr_fecha_mes;
				row_addr = row_addr_fecha_mes;
            bit_addr = bit_addr_fecha_mes;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0001 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;	
      end
		
		
		//Objeto fecha ano numerico
		else if (fecha_ano_on)
         begin
            char_addr = char_addr_fecha_ano;
				row_addr = row_addr_fecha_ano;
            bit_addr = bit_addr_fecha_ano;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0010 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;	
      end
		
		
		//Objeto hora literal
		else if (hora_alf_on)
         begin
            char_addr = char_addr_hora_alf;
				row_addr = row_addr_hora_alf;
            bit_addr = bit_addr_hora_alf;
            if (font_bit)
               text_rgb = 3'b001;
				else
					text_rgb=3'b010;
      end
		
		//Objeto hora hora numerico
		else if (hora_hora_on)
         begin
            char_addr = char_addr_hora_hora;
				row_addr = row_addr_hora_hora;
            bit_addr = bit_addr_hora_hora;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0011 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;	
      end
			
			
		//Objeto hora minutos numerico	
		else if (hora_min_on)
         begin
            char_addr = char_addr_hora_min;
				row_addr = row_addr_hora_min;
            bit_addr = bit_addr_hora_min;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0100 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;
      end
		
		//Objeto hora segundos numerico
		else if (hora_seg_on)
         begin
            char_addr = char_addr_hora_seg;
				row_addr = row_addr_hora_seg;
            bit_addr = bit_addr_hora_seg;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0101 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;	
      end		
			
		//Objeto timer literal	
		else if (timer_alf_on)
         begin
            char_addr = char_addr_timer_alf;
				row_addr = row_addr_timer_alf;
            bit_addr = bit_addr_timer_alf;
            if (font_bit)
               text_rgb = 3'b001;
				else 
					text_rgb=3'b010;
      end
		
		//Objeto timer hora numerico
		else if (timer_hora_on)
         begin
            char_addr = char_addr_timer_hora;
				row_addr = row_addr_timer_hora;
            bit_addr = bit_addr_timer_hora;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0110 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;	
         end
		
		//Objeto timer minutos numerico
		else if (timer_min_on)
         begin
            char_addr = char_addr_timer_min;
				row_addr = row_addr_timer_min;
            bit_addr = bit_addr_timer_min;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b0111 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;
         end
		
		//Objeto timer segundos numerico
		else if (timer_seg_on)
         begin
            char_addr = char_addr_timer_seg;
				row_addr = row_addr_timer_seg;
            bit_addr = bit_addr_timer_seg;
            if (font_bit)
               text_rgb = 3'b100;
				else if(~font_bit && dir==4'b1000 && cursor)
					if(clk1_o)
							text_rgb = 3'b101;
						else
							text_rgb = 3'b000;	
         end	
		
		else if (ring_on)
         begin
				if(T_hora_d==0 && T_hora_u==0 && T_min_d==0 && T_min_u==0 && T_seg_d==0 && T_seg_u==0 && ~rsw)
					begin
						
						if(clk1_o)
							text_rgb = 3'b010;
						else
							text_rgb = 3'b100;
							
							
					end
				else
					text_rgb = 3'b110;
					
         end	
		
				 
   end

   
   //-------------------------------------------
   // font rom interface
   //-------------------------------------------
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];
	
	
endmodule