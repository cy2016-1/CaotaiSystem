// Verilog netlist created by TD v4.6.18154
// Mon Oct 30 20:23:29 2023

`timescale 1ns / 1ps
module mult_16_16bit_signed  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(14)
  (
  a,
  b,
  cea,
  ceb,
  cepd,
  clk,
  rstan,
  rstbn,
  rstpdn,
  p
  );

  input [15:0] a;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(18)
  input [15:0] b;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(19)
  input cea;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(20)
  input ceb;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(21)
  input cepd;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(22)
  input clk;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(23)
  input rstan;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(24)
  input rstbn;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(25)
  input rstpdn;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(26)
  output [31:0] p;  // ../ip/mult_16_16bit_signed/mult_16_16bit_signed.v(16)


  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_MULT18 #(
    .CEAMUX("SIG"),
    .CEBMUX("SIG"),
    .CEPDMUX("SIG"),
    .CLKMUX("SIG"),
    .INPUTREGA("ENABLE"),
    .INPUTREGB("ENABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("ENABLE"),
    .RSTANMUX("SIG"),
    .RSTBNMUX("SIG"),
    .RSTPDNMUX("SIG"),
    .SIGNEDAMUX("1"),
    .SIGNEDBMUX("1"),
    .SRMODE("SYNC"))
    inst_ (
    .a({a[15],a[15],a}),
    .b({b[15],b[15],b}),
    .cea(cea),
    .ceb(ceb),
    .cepd(cepd),
    .clk(clk),
    .rstan(rstan),
    .rstbn(rstbn),
    .rstpdn(rstpdn),
    .p({open_n123,open_n124,open_n125,open_n126,p}));

endmodule 

