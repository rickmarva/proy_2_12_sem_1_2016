`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Martinez Vallejos
// 
// Create Date:    00:14:25 04/18/2016 
// Design Name: 
// Module Name:    maquinalectura1 
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
module maquinalectura1(clk_i,enable,reset,direccion,AD_o,state,WR,RD,CS);
	
	input clk_i,reset;
	input wire enable;
	
	output reg [7:0]direccion=8'bzzzzzzzz;//esta es la linea que va a BUS
	output reg AD_o=1'b1;
	output reg [3:0] state=a;
	output reg WR=1'bz;
	output reg RD=1'bz;
	output reg CS=1'bz;
	
   parameter a = 4'b0000;
   parameter b = 4'b0001;
   parameter c = 4'b0010;
   parameter d = 4'b0011;
   parameter e = 4'b0100;
   parameter f = 4'b0101;
   parameter g = 4'b0110;
   parameter h = 4'b0111;
	parameter i = 4'b1000;
	parameter j = 4'b1001;
	

   //(* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="NO" *) 
	
	reg [4:0] conta=5'b11111;
	reg [7:0] valor;
//always@(posedge clk_i)
//begin
	//conta=conta+1'b1;
//end

always@(posedge clk_i)
begin
	if(enable==1'b1)
		begin
		conta=conta+1'b1;
		if(reset)
			begin
			state=a;
			end
		else
			begin
				(* FULL_CASE, PARALLEL_CASE *) 
				case (state)
						a : begin// comado F0
						if(conta==5'b00000)
							begin
							direccion = 8'hF0;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = a;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = a;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=a;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					
					b : begin// lee SEG
						if(conta==5'b0000)
							begin
							direccion = 8'h21;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio un valor de alta impedancia
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = b;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = b;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=b;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					c : begin//lee min 
						if(conta==5'b00000)
							begin
							direccion = 8'h22;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = c;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = c;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=c;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					d : begin// lee hora
						if(conta==5'b00000)
							begin
							direccion = 8'h23;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = d;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = d;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=d;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					e : begin// lee fecha
						if(conta==5'b00000)
							begin
							direccion = 8'h24;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = e;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = e;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=e;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					f : begin// lee mes
						if(conta==5'b00000)
							begin
							direccion = 8'h25;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = f;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = f;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=f;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					g : begin// lee año
						if(conta==5'b00000)
							begin
							direccion = 8'h26;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = g;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = g;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=g;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					h : begin// Thora
						if(conta==5'b00000)
							begin
							direccion = 8'h43;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = h;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = h;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=h;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					i : begin// tmin
						if(conta==5'b00000)
							begin
							direccion = 8'h42;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = i;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = i;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=i;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
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
					
					
					j : begin// tseg
						if(conta==5'b00000)
							begin
							direccion = 8'h41;//indico la direccion a la cual voy a enviar la información
							valor = 8'hzz;// envio la instruccion en hexadecimal de zz
							RD=1'b1;
							WR=1'b0;
							CS=1'b0;
							AD_o = 1'b0;
							state = j;
							end
						else if(conta==5'b00111)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = j;
							end
						else if(conta==5'b01110)
							begin
							RD=1'b0;
							WR=1'b1;
							CS=1'b0;
							AD_o = 1'b1;
							state=j;
							end
						else if(conta==5'b10101)
							begin
							RD=1'b1;
							WR=1'b1;
							CS=1'b1;
							state = j;
							end
						else if(conta==5'b11011)
							begin
							conta=5'b11111;
							state=a;
							end
						else
							state=j;		
					end
					
					
				endcase
			end
		end
end	

	
endmodule
