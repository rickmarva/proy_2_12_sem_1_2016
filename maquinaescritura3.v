`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:53:46 04/26/2016 
// Design Name: 
// Module Name:    maquinaescritura3 
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
module maquinaescritura3(clk_i,enable,reset,programo,numero,cambio,direccion,AD_o,valor,RD,WR,CS);
	
	input clk_i,reset,programo;
	input wire [3:0]cambio;
	input wire [7:0]numero;
	
	input wire enable;
	
	output reg [7:0]direccion=8'bzzzzzzzz;//esta es la linea que va a BUS
	output reg AD_o=1'bz;
	output reg [7:0]valor=8'bzzzzzzzz;	
	output reg RD=1'b0;
	output reg WR=1'b1;
	output reg CS=1'b1;
	
	reg [3:0]state=a;

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
	
	parameter bb = 4'b0001;//seg
   parameter cc = 4'b0010;//min
   parameter dd = 4'b0011;//hora
   parameter ee = 4'b0100;//fecha
   parameter ff = 4'b0101;//mes
   parameter gg = 4'b0110;//año
   parameter hh = 4'b0111;//Thora
	parameter ii = 4'b1000;//Tmin
	parameter jj = 4'b1001;//Tseg

   //(* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *) 
	
	//reg [4:0] state = a;
	reg [4:0] conta=5'b11111;
	reg fin=1'b0;
//always @(posedge clk_i)
//begin
//conta=conta+1'b1;
//end	
	


always@(posedge clk_i)
begin
if(reset)
			begin
			state=a;
			fin=1'b0;
			end
else if(programo)
	begin
	if(enable==1'b1 && fin==1'b0)//&& fin==1'b0
		begin
		conta=conta+1'b1;
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
							valor=8'b00001010;// envio las instrucciones para un reloj de 24 horas, esta desactivado el set time lock
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
							case(cambio)
									bb: state=e;//seg
									cc: state=f;//min
									dd: state=g;//hora
									ee: state=h;//fecha
									ff: state=i;//mes
									gg: state=j;//año
									ii: state=k;//Thora
									//ii: state=l;//Tmin
									//jj: state=m;//Tseg
							
							endcase
							end
						else
							state=d;		
					end
					
					e : begin//seg
						if(conta==5'b0000)
							begin
							direccion = 8'h21;//indico la direccion a la cual voy a enviar la información
							valor = numero;// envio la instruccion en hexadecimal de 10
							
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
							state=o;
							end
						else
							state=e;		
					end
					
					
					f : begin//min
						if(conta==5'b0000)
							begin
							direccion = 8'h22;//indico la direccion a la cual voy a enviar la información
							valor = numero;// envio la instruccion en hexadecimal de 10
							
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
							state=o;
							end
						else
							state=f;		
					end
					
					g : begin//horas
						if(conta==5'b0000)
							begin
							direccion = 8'h23;//indico la direccion a la cual voy a enviar la información
							valor = numero;// envio la instruccion en hexadecimal de 10
							
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
							state=o;
							end
						else
							state=g;		
					end
					
					h : begin//fecha
						if(conta==5'b0000)
							begin
							direccion = 8'h24;//indico la direccion a la cual voy a enviar la información
							valor = numero;// envio la instruccion en hexadecimal de 10
							
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
							state=o;
							end
						else
							state=h;		
					end
					
					i : begin//mes
						if(conta==5'b0000)
							begin
							direccion = 8'h25;//indico la direccion a la cual voy a enviar la información
							valor = numero;// envio la instruccion en hexadecimal de 10
							
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
							state=o;
							end
						else
							state=i;		
					end
					
					
					j : begin//año
						if(conta==5'b0000)
							begin
							direccion = 8'h26;//indico la direccion a la cual voy a enviar la información
							valor = numero;// envio la instruccion en hexadecimal de 10
							
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
							state=o;
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
							valor = numero;// envio la instruccion en hexadecimal de 10
							
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
							fin=1'b1;
							///state=q;--------------------------------------------------------término maquina de estados
							end
						else
							state=p;		
					end
					
					
					
		
			endcase
		end
	
	end	
end

endmodule
