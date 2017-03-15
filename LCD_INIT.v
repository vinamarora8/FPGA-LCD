`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:50 02/28/2017 
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
module LCD_INIT(
	input CLK,
	output reg [11:8] SF_D,
	output reg LCD_E,
	output reg LCD_RS,
	output reg LCD_RW,
	output reg DONE
    );
	
	// Registers required for initialization
	reg [3:0] init_stage_counter;
	reg [19:0] init_counter;
	
	initial
	begin
			init_stage_counter = 0;
			init_counter = 0;
			LCD_E = 0;
			SF_D = 0;
			LCD_RS = 0;
			LCD_RW = 0;
			DONE = 0;
	end
	
	// Initializing block
	always @(posedge CLK)
	begin
			if (init_stage_counter == 0 && init_counter >= 750000)
			begin
				init_stage_counter = 1;
				init_counter = 0;
				LCD_E = 1;
				SF_D = 4'h3;
			end
			if (init_stage_counter == 1 && init_counter >= 12)
			begin
				init_stage_counter = 2;
				init_counter = 0;
				LCD_E = 0;
				SF_D = 4'h0;
			end
			if (init_stage_counter == 2 && init_counter >= 205000)
			begin
				init_stage_counter = 3;
				init_counter = 0;
				LCD_E = 1;
				SF_D = 4'h3;
			end
			if (init_stage_counter == 3 && init_counter >= 12)
			begin
				init_stage_counter = 4;
				init_counter = 0;
				LCD_E = 0;
				SF_D = 4'h0;
			end
			if (init_stage_counter == 4 && init_counter >= 5000)
			begin
				init_stage_counter = 5;
				init_counter = 0;
				LCD_E = 1;
				SF_D = 4'h3;
			end
			if (init_stage_counter == 5 && init_counter >= 12)
			begin
				init_stage_counter = 6;
				init_counter = 0;
				LCD_E = 0;
				SF_D = 4'h0;
			end
			if (init_stage_counter == 6 && init_counter >= 2000)
			begin
				init_stage_counter = 7;
				init_counter = 0;
				LCD_E = 1;
				SF_D = 4'h2;
			end
			if (init_stage_counter == 7 && init_counter >= 12)
			begin
				init_stage_counter = 8;
				init_counter = 0;
				LCD_E = 0;
			end
			if (init_stage_counter == 8 && init_counter >= 2000)
			begin
				init_stage_counter = 9;
				init_counter = 0;
			end
			
			// Starting Function Set
			if (init_stage_counter == 9)
			begin
				
				if (init_counter == 1)
				begin
					LCD_E = 0;
					SF_D = 4'b0010;
				end
				
				if (init_counter == 6)
					LCD_E = 1;
					
				if (init_counter == 26)
				begin
					LCD_E = 0;
					SF_D = 4'h8;
				end
				
				if (init_counter == 76)
				begin
					LCD_E = 1;
				end
				
				if (init_counter == 101)
				begin
					LCD_E = 0;
				end
				
				if (init_counter >= 3005)
				begin
					init_counter = 0;
					init_stage_counter = 10;
				end
			end
			
			// Entry Mode Set
			if (init_stage_counter == 10)
			begin
				
				if (init_counter == 1)
				begin
					LCD_E = 0;
					SF_D = 4'h0;
				end
				
				if (init_counter == 6)
					LCD_E = 1;
					
				if (init_counter == 26)
				begin
					LCD_E = 0;
					SF_D = 4'h6;
				end
				
				if (init_counter == 76)
				begin
					LCD_E = 1;
				end
				
				if (init_counter == 101)
				begin
					LCD_E = 0;
				end
				
				if (init_counter >= 3005)
				begin
					init_counter = 0;
					init_stage_counter = 11;
				end
			end
			
			// Display On
			if (init_stage_counter == 11)
			begin
				
				if (init_counter == 1)
				begin
					LCD_E = 0;
					SF_D = 4'h0;
				end
				
				if (init_counter == 6)
					LCD_E = 1;
					
				if (init_counter == 26)
				begin
					LCD_E = 0;
					SF_D = 4'hc;
				end
				
				if (init_counter == 76)
				begin
					LCD_E = 1;
				end
				
				if (init_counter == 101)
				begin
					LCD_E = 0;
				end
				
				if (init_counter >= 3005)
				begin
					init_counter = 0;
					init_stage_counter = 12;
				end
			end
			
			// Clear Display
			if (init_stage_counter == 12)
			begin
				
				if (init_counter == 1)
				begin
					LCD_E = 0;
					SF_D = 4'h0;
				end
				
				if (init_counter == 6)
					LCD_E = 1;
					
				if (init_counter == 26)
				begin
					LCD_E = 0;
					SF_D = 4'h1;
				end
				
				if (init_counter == 76)
				begin
					LCD_E = 1;
				end
				
				if (init_counter == 101)
				begin
					LCD_E = 0;
				end
				
				if (init_counter >= 100000)
				begin
					init_counter = 0;
					init_stage_counter = 15;
					DONE = 1;
				end
			end
			
			// Counting the init_counter
			if (init_stage_counter != 15)
				init_counter = init_counter + 1;
	end	
endmodule
