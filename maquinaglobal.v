`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Martinez Vallejos
// 
// Create Date:    00:05:02 04/18/2016 
// Design Name: 
// Module Name:    maquinaglobal 
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
module maquinaglobal(clk_i,aumenta_i,cambio_i,reset_i,estado_i,horario_i,AD_o,graba_i,pulsoprogramo,salient,RD,WR,chipselecc_o,state,regseg,regmin,reghora,regdate,regmes,regano,regThora,regTmin,regTseg);

input clk_i,aumenta_i,reset_i;
input horario_i;
input wire pulsoprogramo;
input wire graba_i;
input wire [3:0]cambio_i;
input wire [1:0]estado_i;//1 escribe,0 lee

output wire [3:0]state;
output reg AD_o;
output reg [7:0] regseg,regmin,reghora,regdate,regmes,regano,regThora,regTmin,regTseg;
output reg RD=1'bz;
output reg WR=1'bz;
output reg chipselecc_o=1'bz;

inout tri [7:0] salient;

//wires y registros de la maquina global
reg [2:0]enables;
reg [7:0] direccion;
reg [7:0] datoescribir;
reg leerdato;
reg escribirdato;
reg ADatrasado;
reg programo=1'b0;
wire [7:0]datoleer;
reg [3:0]estadob;

//wires y registros de las maquinas de estados
//-----------------Máquina inicialización****************
wire [7:0]direccionini;
wire ADINI;
wire [7:0]datoescribirini;
wire RDi;
wire WRi;
wire CSi;
wire leerdatoini;
wire escribirdatoini;
wire ADatrasadoini;
parameter ini=3'b100;
parameter lee=3'b010;
parameter esc=3'b001;

//-----------------Máquina Lectura*********************
wire [7:0]direccionL;
wire ADL;
wire [3:0]estadolee;
wire RDL;
wire WRL;
wire CSL;
wire ADatrasadoL;


parameter seg=4'b0001;
parameter min=4'b0010;
parameter hora=4'b0011;
parameter fecha=4'b0100;
parameter mes=4'b0101;
parameter ano=4'b0110;
parameter Thora=4'b0111;
parameter Tmin=4'b1000;
parameter Tseg=4'b1001;

//-------------------Máquina escribe*******************
 wire [7:0]numero;
 wire ADE;
 wire [7:0]direccionE;
 wire [7:0]datoescribirE;
 //wire [3:0]estadoescribe;
 wire RDE;
 wire WRE;
 wire CSE;
 wire leerdatoE;
 wire escribirdatoE;
 wire ADatrasadoE; 

//reg conta=2'b00;
//registros para manejar el botón programo
reg [25:0]cont = 26'b0;//variable de contador para generar 1Hz
reg clk1=1'b0;//senal cambiante de 1Hz
//divisor de frecuencia para el botón programo
always @(posedge clk_i)
		begin
			if(cont == 26'd49999999) 
				begin
					cont = 26'b0;
					clk1=~clk1;
			end
			else
		cont=cont+1'b1; 
		end	
//genero un pulso programo en alto durante un tiempo para que pase de estado		
always@(posedge clk1)
 begin
	if(pulsoprogramo)
	begin
		programo=1'b1;
	end
	else
		programo=1'b0;
		
 end
 

 
always @(posedge clk_i)
begin
	if(estado_i==2'b00)
		begin
		enables=3'b100;
		end
	else if(estado_i==2'b01)
		begin
		enables=3'b010;
		end

	else if(estado_i==2'b10)
		begin
		enables=3'b001;
		end
	else
		begin
		enables=3'b000;
		estadob=4'b0001;
		end
	case(enables)
	
			ini :begin
						chipselecc_o=CSi;
						RD=RDi;
						WR=WRi;
						AD_o=ADINI;
						direccion=direccionini;
						datoescribir=datoescribirini;
						leerdato=leerdatoini;
						escribirdato=escribirdatoini;
						ADatrasado=ADatrasadoini;
			end
			
			lee :begin
						chipselecc_o=CSL;
						RD=RDL;
						WR=WRL;
						AD_o=ADL;
						direccion=direccionL;
						datoescribir=8'bz;
						leerdato=leerdatolee;
						escribirdato=escribirdatolee;
						ADatrasado=ADatrasadoL;
						estadob=estadolee;
						case(estadob)
									seg:regseg=datoleer;
									min:regmin=datoleer;
									hora:reghora=datoleer;
									fecha:regdate=datoleer;
									mes:regmes=datoleer;
									ano:regano=datoleer;
									Thora:regThora=datoleer;
									Tmin:regTmin=datoleer;
									Tseg:regTseg=datoleer;
						endcase
			end
			
			esc: begin
						chipselecc_o=CSE;
						RD=RDE;
						WR=WRE;
						AD_o=ADE;
						direccion=direccionE;
						datoescribir=datoescribirE;
						leerdato=leerdatoE;
						escribirdato=escribirdatoE;
						ADatrasado=ADatrasadoE;
						estadob=cambio_i;
						case(estadob)
									seg:regseg=numero;
									min:regmin=numero;
									hora:reghora=numero;
									fecha:regdate=numero;
									mes:regmes=numero;
									ano:regano=numero;
									Thora:regThora=numero;
									Tmin:regTmin=numero;
									Tseg:regTseg=numero;
						endcase
			end
	endcase		
end

decostate decoestados(clk_i,estadob,state);
controlnumero controlanum(clk_i,aumenta_i,cambio_i,numero);
maquinainicializacion1 maquinaini(clk_i,enables[2],reset_i,horario_i,direccionini,ADINI,datoescribirini,RDi,WRi,CSi);//******************************************************
retrasoTaccAD retrasoini1(clk_i,enables[2],ADINI,ADatrasadoini);
retrasotacc2 retrasoini2(clk_i,enables[2],~CSi,leerdatoini);
retrasotacc2 retrasoini3(clk_i,enables[2],CSi,escribirdatoini);
maquinalectura1 maquinalee(clk_i,enables[1],reset_i,direccionL,ADL,estadolee,WRL,RDL,CSL);//ADTL es AD de lectura// cambie de posicion entre RDL Y WRL
retrasoTaccAD retrasolee1(clk_i,enables[1],ADL,ADatrasadoL);
retrasotacc2 retrasolee2(clk_i,enables[1],~CSL,leerdatolee);
retrasotacc2 retrasolee3(clk_i,enables[1],CSL,escribirdatolee);
maquinaescritura3 maquinaescribe(clk_i,enables[0],graba_i,programo,numero,cambio_i,direccionE,ADE,datoescribirE,RDE,WRE,CSE);
retrasoTaccAD retrasoescribe1(clk_i,enables[0],ADE,ADatrasadoE);
retrasotacc2 retrasoescribe2(clk_i,enables[0],~CSE,leerdatoE);
retrasotacc2 retrasoescribe3(clk_i,enables[0],CSE,escribirdatoE);
//pruebainout controlbus(clk_i,leerdatoini,escribirdatoini,ADINI,direccionini,datoescribirini,datoleer,salient);
pruebainout controlbus(clk_i,leerdato,escribirdato,ADatrasado,direccion,datoescribir,datoleer,salient);
//pruebainout controlbus(clk_i,leerdato,escribirdato,AD_o,direccion,datoescribir,datoleer,salient);


endmodule