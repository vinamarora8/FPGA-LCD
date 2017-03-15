`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:45 02/14/2017 
// Design Name: 
// Module Name:    main 
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
module main(
    input [1:0] A,
    input [1:0] B,
    output [1:0] S,
    input Cin,
    output Cout,
	 input CLK,
	 output [11:8] SF_D,
	 output LCD_E,
	 output LCD_RS,
	 output LCD_RW,
	 output LCD_Enable
    );
	
	assign LCD_Enable = 1'b1;
	
	wire c0;
	fulladder full1(
		A[0],
		B[0],
		Cin,
		S[0],
		c0
		);
	fulladder full2(
		A[1],
		B[1],
		c0,
		S[1],
		Cout
		);
	
	lcd_vala yup(
		.DATA({Cout, S[1:0]}),
		.CLK(CLK),
		.SF_D(SF_D),
		.LCD_E(LCD_E),
		.LCD_RS(LCD_RS),
		.LCD_RW(LCD_RW)
	);
	
endmodule
