`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:40:16 02/28/2017 
// Design Name: 
// Module Name:    lcd_vala 
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
module lcd_vala(
	input [2:0] DATA,
	input CLK,
	output tri [11:8] SF_D,
	output tri LCD_E,
	output tri LCD_RS,
	output tri LCD_RW
	);
	
	// Registers
	reg [3:0] D;
	reg Enable, RS, RW;
	
	initial
	begin
		D = 4'b0000;
		Enable = 1'b0;
		RS = 1'b0;
		RW = 1'b0;
	end
	
	// Assign outputs
	wire [3:0] init_D;
	wire init_E, init_RS, init_RW;
	wire init_done;

	LCD_INIT Init_Module(CLK, init_D, init_E, init_RS, init_RW, init_done);
	
	assign SF_D[11:8] = (init_done) ? D[3:0] : init_D[3:0];
	assign LCD_E = (init_done) ? Enable : init_E;
	assign LCD_RS = (init_done) ? RS : init_RS;
	assign LCD_RW = (init_done) ? RW : init_RW;
	
	
	// Counters
	reg stage_counter;
	reg [11:0] counter;
	
	initial
	begin
		stage_counter = 0;
		counter = 0;
	end
	
	always @(posedge CLK)
	begin
		if (init_done == 1)
		begin
			
			// Set DD RAM Address to 0x00
			if (stage_counter == 1'b0)
			begin
				if (counter == 1)
				begin
					RS = 0;
					RW = 0;
					Enable = 0;
					D = 4'h8;
				end
				
				if (counter == 6)
					Enable = 1;
					
				if (counter == 26)
				begin
					Enable = 0;
					D = 4'h0;
				end
				
				if (counter == 76)
				begin
					Enable = 1;
				end
				
				if (counter == 101)
				begin
					Enable = 0;
				end
				
				if (counter >= 3005)
				begin
					counter = 0;
					stage_counter = 1'b1;
				end
			end
			
			// Write DATA to LCD
			if (stage_counter == 1'b1)
			begin
				
				if (counter == 1)
				begin
					RS = 1;
					RW = 0;
					Enable = 0;
					D = 4'b0011;
				end
				
				if (counter == 6)
					Enable = 1;
					
				if (counter == 26)
				begin
					Enable = 0;
					D = {1'b0, DATA};
				end
				
				if (counter == 76)
				begin
					Enable = 1;
				end
				
				if (counter == 101)
				begin
					Enable = 0;
				end
				
				if (counter >= 3005)
				begin
					counter = 0;
					stage_counter = 1'b0;
				end
			end
		
		counter = counter + 1;
			
		end
	end
	
endmodule
