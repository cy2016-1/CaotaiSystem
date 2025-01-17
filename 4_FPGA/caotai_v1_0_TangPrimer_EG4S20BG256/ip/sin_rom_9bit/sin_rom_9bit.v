/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	G:/caotai_code/td_prj/caotai_v1_0/ip/sin_rom_9bit/sin_rom_9bit.v
 ** Date	:	2023 10 30
 ** TD version	:	4.6.18154
\************************************************************/

`timescale 1ns / 1ps

module sin_rom_9bit ( doa, addra, clka, rsta );

	output [8:0] doa;

	input  [9:0] addra;
	input  clka;
	input  rsta;




	EG_LOGIC_BRAM #( .DATA_WIDTH_A(9),
				.ADDR_WIDTH_A(10),
				.DATA_DEPTH_A(1024),
				.DATA_WIDTH_B(9),
				.ADDR_WIDTH_B(10),
				.DATA_DEPTH_B(1024),
				.MODE("SP"),
				.REGMODE_A("OUTREG"),
				.RESETMODE("SYNC"),
				.IMPLEMENT("9K"),
				.DEBUGGABLE("NO"),
				.PACKABLE("NO"),
				.INIT_FILE("../../rtl/sin.mif"),
				.FILL_ALL("NONE"))
			inst(
				.dia({9{1'b0}}),
				.dib({9{1'b0}}),
				.addra(addra),
				.addrb({10{1'b0}}),
				.cea(1'b1),
				.ceb(1'b0),
				.ocea(1'b1),
				.oceb(1'b0),
				.clka(clka),
				.clkb(1'b0),
				.wea(1'b0),
				.web(1'b0),
				.bea(1'b0),
				.beb(1'b0),
				.rsta(rsta),
				.rstb(1'b0),
				.doa(doa),
				.dob());


endmodule