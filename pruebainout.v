`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ricardo Martinez Vallejos
// 
// Create Date:    00:24:21 04/18/2016 
// Design Name: 
// Module Name:    pruebainout 
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
module pruebainout(clk,leerdato,escribirdato,AD,direccion,datoescribir,datoleer,salient);

input wire clk,leerdato;
input wire escribirdato,AD;
input wire [7:0] direccion,datoescribir;
output reg [7:0] datoleer;
inout wire [7:0]salient;
 
wire [7:0]datodireccion;
assign datodireccion= AD ? datoescribir:direccion;
assign salient=~escribirdato ? datodireccion:8'hzz;
  
always @(posedge clk)
      if (~leerdato)
         datoleer  <= salient;
      else
         datoleer <= datoleer;// datoleer es el dato que se lee del rtc

endmodule


