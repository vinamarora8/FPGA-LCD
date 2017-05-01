`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:29 02/14/2017 
// Design Name: 
// Module Name:    fulladder 
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
module fulladder(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );
	
	wire s0, c0, c1;
	halfadder half1(
		.A(A),
		.B(B),
		.S(s0),
		.C(c0)
		);
	halfadder half2(
		s0,
		Cin,
		S,
		c1
		);
	or o1(Cout,c0,c1);

endmodule
