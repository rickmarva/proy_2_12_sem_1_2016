`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Martinez Vallejos
// 
// Create Date:    00:12:08 04/18/2016 
// Design Name: 
// Module Name:    maquinainicializacion1 
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
module maquinainicializacion1(clk_i,enable,reset,horario,direccion,AD_o,valor,RD,WR,CS);
	input clk_i,reset;
	
	input wire horario;
	input wire enable;
	
	output reg [7:0]direccion=8'bzzzzzzzz;//esta es la linea que va a BUS
	output reg AD_o=1'bz;
	output reg [7:0]valor=8'bzzzzzzzz;	
	output reg RD=1'b0;
	output reg WR=1'b1;
	output reg CS=1'b1;

   parameter a = 5'b00000;
   parameter b = 5'b00001;
   parameter c = 5'b00010;
   parameter d = 5'b00011;
   parameter e = 5'b00100;
   parameter f = 5'b00101;
   parameter g = 5'b00110;
   parameter h = 5'b00111;
	parameter i = 5'b01000;
	parameter j = 5'b01001;
	parameter k = 5'b01010;
	parameter l = 5'b01011;
	parameter m = 5'b01100;
	parameter n = 5'b01101;
	parameter o = 5'b01110;
	parameter p = 5'b01111;
	parameter q = 5'b00000;

   //(* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *) 
	
	reg [4:0] state = a;
	reg [4:0] conta=5'b11111;
	reg fin=1'b0;
	
//always @(posedge clk_i)
//begin
//conta=conta+1'b1;
//end	
	


always@(posedge clk_i)
begin
	if(enable==1'b1&& fin==1'b0)
		begin
		conta=conta+1'b1;
		if(reset)
			begin
			state=a;
			end
		else
			(* FULL_CASE, PARALLEL_CASE *) 
			case (state)
					
					a : begin// programo en status 2 el bit de inicializacion en 1
						if(conta==5'b0000)
							begin
							direccion = 8'h02;//indico la direccion a la cual voy a enviar la información
							valor = 8'h10;// envio la instruccion en hexadecimal de 10
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = a;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = a;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=a;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = a;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=b;
							end
						else
							state=a;		
					end
					
					b : begin// programo en status el bit de inicializacion en 0
						if(conta==5'b0000)
							begin
							direccion = 8'h02;//indico la direccion a la cual voy a enviar la información
							valor = 8'h00;// envio la instruccion en hexadecimal de 10
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = b;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = b;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=b;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = b;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=c;
							end
						else
							state=b;		
					
					end
					
					
					c : begin//Digital trimming
						if(conta==5'b0000)
							begin
							direccion = 8'h10;//indico la direccion a la cual voy a enviar la información
							valor = 8'hD2;// envio la instruccion en hexadecimal de 10*********************************************************cambie 2D por D2
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = c;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = c;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=c;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = c;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=d;
							end
						else
							state=c;		
					end
					
					
					
					d : begin//status 0 frecuency tunning
						if(conta==5'b0000)
							begin
							direccion = 8'h00;//indico la direccion a la cual voy a enviar la información
							if (horario==1'b1)
								begin
								valor=8'b00001010;// envio las instrucciones para un reloj de 24 horas, esta desactivado el set time lock
								end
							else
								begin
								valor=8'b00011010;// envio las instrucciones para un reloj de 12 horas,esta desactivado el set time lock
								end
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = d;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = d;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=d;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = d;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=e;
							end
						else
							state=d;		
					end
					
					e : begin//seg
						if(conta==5'b0000)
							begin
							direccion = 8'h21;//indico la direccion a la cual voy a enviar la información
							valor = 8'h00;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = e;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = e;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=e;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = e;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=f;
							end
						else
							state=e;		
					end
					
					
					f : begin//min
						if(conta==5'b0000)
							begin
							direccion = 8'h22;//indico la direccion a la cual voy a enviar la información
							valor = 8'h00;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = f;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = f;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=f;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = f;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=g;
							end
						else
							state=f;		
					end
					
					g : begin//horas
						if(conta==5'b0000)
							begin
							direccion = 8'h23;//indico la direccion a la cual voy a enviar la información
							valor = 8'h03;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = g;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = g;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=g;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = g;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=h;
							end
						else
							state=g;		
					end
					
					h : begin//fecha
						if(conta==5'b0000)
							begin
							direccion = 8'h24;//indico la direccion a la cual voy a enviar la información
							valor = 8'h26;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = h;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = h;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=h;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = h;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=i;
							end
						else
							state=h;		
					end
					
					i : begin//mes
						if(conta==5'b0000)
							begin
							direccion = 8'h25;//indico la direccion a la cual voy a enviar la información
							valor = 8'h04;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = i;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = i;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=i;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = i;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=j;
							end
						else
							state=i;		
					end
					
					
					j : begin//año
						if(conta==5'b0000)
							begin
							direccion = 8'h26;//indico la direccion a la cual voy a enviar la información
							valor = 8'h16;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = j;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = j;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=j;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = j;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=k;
							end
						else
							state=j;		
					end
					
					k : begin//Thoraas
						if(conta==5'b0000)
							begin
							direccion = 8'h43;//indico la direccion a la cual voy a enviar la información
							valor = 8'h23;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = k;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = k;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=k;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = k;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=l;
							end
						else
							state=k;		
					end
					
					l : begin//Tmin
						if(conta==5'b0000)
							begin
							direccion = 8'h42;//indico la direccion a la cual voy a enviar la información
							valor = 8'h58;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = l;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = l;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=l;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = l;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=m;
							end
						else
							state=l;		
					end
					
					m : begin//Tseg
						if(conta==5'b0000)
							begin
							direccion = 8'h41;//indico la direccion a la cual voy a enviar la información
							valor = 8'h59;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = m;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = m;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=m;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = m;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=n;
							end
						else
							state=m;		
					end
					
					n : begin//comando F2
						if(conta==5'b0000)
							begin
							direccion = 8'hF2;//indico la direccion a la cual voy a enviar la información
							valor = 8'hF2;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = n;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = n;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=n;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = n;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=o;
							end
						else
							state=n;		
					end
					
					o : begin//status 1
						if(conta==5'b0000)
							begin
							direccion = 8'h01;//indico la direccion a la cual voy a enviar la información
							valor = 8'h00;// envio la instruccion en hexadecimal de 10
							
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = o;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = o;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=o;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = o;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=p;
							end
						else
							state=o;		
					end
					
					
					p : begin///F1
						if(conta==5'b0000)
							begin
							direccion = 8'hF1;//indico la direccion a la cual voy a enviar la información
							valor = 8'hF1;// envio la instruccion en hexadecimal de 10
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = p;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = p;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b1;
							state=p;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b1;
							state = p;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							direccion = 8'hzz;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							
							fin<=1'b1;
							///state=q;--------------------------------------------------------término maquina de estados
							end
						else
							state=p;		
					end
					
					
					
		
			endcase
		end
	
		
end


endmodule
