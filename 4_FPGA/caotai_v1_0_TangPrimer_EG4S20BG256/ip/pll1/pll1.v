/************************************************************\
 **  Copyright (c) 2011-2021 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	G:/caotai_code/td_prj/caotai_v1_0/ip/pll1/pll1.v
 ** Date	:	2024 01 13
 ** TD version	:	4.6.18154
\************************************************************/

///////////////////////////////////////////////////////////////////////////////
//	Input frequency:             24.000Mhz
//	Clock multiplication factor: 2
//	Clock division factor:       1
//	Clock information:
//		Clock name	| Frequency 	| Phase shift
//		C0        	| 48.000000 MHZ	| 0  DEG     
//		C1        	| 72.000000 MHZ	| 0  DEG     
//		C2        	| 4.000000  MHZ	| 0  DEG     
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 100 fs

module pll1(refclk,
		reset,
		extlock,
		clk0_out,
		clk1_out,
		clk2_out);

	input refclk;
	input reset;
	output extlock;
	output clk0_out;
	output clk1_out;
	output clk2_out;

	wire clk0_buf;

	EG_LOGIC_BUFG bufg_feedback( .i(clk0_buf), .o(clk0_out) );

	EG_PHY_PLL #(.DPHASE_SOURCE("DISABLE"),
		.DYNCFG("DISABLE"),
		.FIN("24.000"),
		.FEEDBK_MODE("NORMAL"),
		.FEEDBK_PATH("CLKC0_EXT"),
		.STDBY_ENABLE("DISABLE"),
		.PLLRST_ENA("ENABLE"),
		.SYNC_ENABLE("DISABLE"),
		.DERIVE_PLL_CLOCKS("DISABLE"),
		.GEN_BASIC_CLOCK("DISABLE"),
		.GMC_GAIN(2),
		.ICP_CURRENT(9),
		.KVCO(2),
		.LPF_CAPACITOR(1),
		.LPF_RESISTOR(8),
		.REFCLK_DIV(1),
		.FBCLK_DIV(2),
		.CLKC0_ENABLE("ENABLE"),
		.CLKC0_DIV(9),
		.CLKC0_CPHASE(8),
		.CLKC0_FPHASE(0),
		.CLKC1_ENABLE("ENABLE"),
		.CLKC1_DIV(6),
		.CLKC1_CPHASE(5),
		.CLKC1_FPHASE(0),
		.CLKC2_ENABLE("ENABLE"),
		.CLKC2_DIV(108),
		.CLKC2_CPHASE(107),
		.CLKC2_FPHASE(0)	)
	pll_inst (.refclk(refclk),
		.reset(reset),
		.stdby(1'b0),
		.extlock(extlock),
		.psclk(1'b0),
		.psdown(1'b0),
		.psstep(1'b0),
		.psclksel(3'b000),
		.psdone(open),
		.dclk(1'b0),
		.dcs(1'b0),
		.dwe(1'b0),
		.di(8'b00000000),
		.daddr(6'b000000),
		.do({open, open, open, open, open, open, open, open}),
		.fbclk(clk0_out),
		.clkc({open, open, clk2_out, clk1_out, clk0_buf}));

endmodule
