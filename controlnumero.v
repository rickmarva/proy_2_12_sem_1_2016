`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Martinez Vallejos
// 
// Create Date:    00:07:06 04/18/2016 
// Design Name: 
// Module Name:    controlnumero 
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
module controlnumero(clk_i,aumenta,cambio,out_o);

input aumenta,clk_i;
input wire [3:0] cambio;

output reg[7:0]out_o;


reg clkinterno=1'b0;
reg [23:0]conta=24'b0;
reg [3:0] decenas=4'b0000;
reg [3:0] unidades=4'b0000;
reg [7:0] limite=8'b0;
reg [3:0] cambioanterior=4'b1111;


always@(posedge clk_i)
	begin
		if (conta==25'd3)//9999999
			begin
				conta=25'b0;
				clkinterno=~clkinterno;
			end
		else
			conta=conta+1'b1;
	end
	
	
always@(posedge clkinterno)//clkinterno
	begin
		
			if (cambioanterior==cambio && cambio!=4'b0000)
				begin
					cambioanterior=cambio;
					if(aumenta && out_o<limite)
						begin
						unidades=unidades+1'b1;
						if(unidades==4'd10)
							begin
							decenas=decenas+1'b1;
							unidades=4'b0;
							end
						end			
				
				end
			else
				begin
				cambioanterior=cambio;
				unidades=4'b0;
				decenas=4'b0;
				end
			 
	end	

always@(posedge clk_i)
begin
out_o={decenas,unidades};
case(cambio)
		
		4'b0001: begin 
					limite=8'h59;
					//limitedec =4'd5;
					//limiteuni =4'd9;
					end
		4'b0010: begin 
					limite=8'h59;
					//limitedec =4'd5;
					//limiteuni =4'd9;
					end
		4'b0011: begin 
					limite=8'h23;
					//limitedec =4'd2;
					//limiteuni =4'd3;
					end
		4'b0100: begin 
					limite=8'h31;
					//limitedec =4'd3 ;
					//limiteuni =4'd1 ;
					end
      4'b0101: begin 
					limite=8'h12;
					//limitedec =4'd1 ;
					//limiteuni =4'd2 ;
					end
      4'b0110: begin 
					limite=8'h99;
					//limitedec =4'd9 ;
					//limiteuni =4'd9 ;
					end
      4'b0111: begin 
					limite=8'h23;
					//limitedec =4'd2 ;
					//limiteuni =4'd3 ;
					end
		4'b1000: begin 
					limite=8'h59;
					//limitedec =4'd5 ;
					//limiteuni =4'd9 ;
					end
		4'b1001: begin 
					limite=8'h59;
					//limitedec =4'd5 ;
					//limiteuni =4'd9 ;
					end
	endcase
end


		
endmodule
