`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bernardo Rodriguez Hall
// 
// Create Date:    15:33:11 04/18/2016 
// Design Name: 
// Module Name:    Decoinv_Thora 
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
module Decoinv_Thora(reset,clk,code_dec,code_uni,outdec,outuni);

input clk,reset;
output reg [3:0] outdec,outuni;
   
input [3:0] code_uni;
input [3:0] code_dec;

			

always @(posedge clk)
begin
		if (reset)
		begin
         outuni <= 4'h0;
			outdec <= 4'h0;
      end
		
		else 
			begin
				
				case ({code_dec,code_uni})
					8'h00  : 
					begin
					outdec <=4'h2;
					outuni <=4'h3;
					end
					
					8'h01  : 
					begin
					outdec <=4'h2;
					outuni <=4'h2;
					end
					
					8'h02  :
					begin
					outdec <=4'h2;
					outuni <=4'h1;
					end	
					
					
					8'h03  :
					begin
					outdec <=4'h2;
					outuni <=4'h0;
					end
					
					8'h04  :
					begin
					outdec <=4'h1;
					outuni <=4'h9;
					end

					8'h05  : 
					begin
					outdec <=4'h1;
					outuni <=4'h8;
					end
					
					
					8'h06  : 
					begin
					outdec <=4'h1;
					outuni <=4'h7;
					end
					
					8'h07  : 
					begin
					outdec <=4'h1;
					outuni <= 4'h6;
					end
					
					8'h08  : 
					begin
					outdec <=4'h1;
					outuni <= 4'h5;
					end
					
					8'h09  : 
					begin
					outdec <=4'h1;
					outuni <= 4'h4;
					end
					
					8'h10  : 
					begin
					outdec <=4'h1;
					outuni <= 4'h3;
					end
					
					8'h11  : 
					begin
					outdec <=4'h1;
					outuni <= 4'h2;
					end
					
					8'h12  : 
					begin
					outdec <=4'h1;
					outuni <= 4'h1;
					end
					
					8'h13  : 
					begin
					outdec <=4'h1;
					outuni <= 4'h0;
					end
					
					8'h14  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h9;
					end
					
					8'h15  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h8;
					end
					
					8'h16  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h7;
					end
					
					8'h17  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h6;
					end
					
					8'h18  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h5;
					end
					
					8'h19  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h4;
					end
					
					8'h20  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h3;
					end
					
					8'h21  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h2;
					end
					
					8'h22  : 
					begin
					outdec <=4'h0;
					outuni <= 4'h1;
					end
					
					default :
					begin
					outdec <=4'h0;
					outuni <= 4'h0;
					end					
				endcase
				
			
			end
			
			
end							
				

endmodule