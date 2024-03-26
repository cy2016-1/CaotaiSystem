// Verilog netlist created by TD v4.6.18154
// Mon Oct 30 21:06:56 2023

`timescale 1ns / 1ps
module algorithm_cmd_fifo_72bit  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(14)
  (
  clkr,
  clkw,
  di,
  re,
  rst,
  we,
  do,
  empty_flag,
  full_flag
  );

  input clkr;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(25)
  input clkw;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(24)
  input [71:0] di;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(23)
  input re;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(25)
  input rst;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(22)
  input we;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(24)
  output [71:0] do;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(27)
  output empty_flag;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(28)
  output full_flag;  // ../ip/algorithm_cmd_fifo_72bit/algorithm_cmd_fifo_72bit.v(29)

  wire empty_flag_neg;
  wire full_flag_neg;

  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  not empty_flag_inv (empty_flag_neg, empty_flag);
  not full_flag_inv (full_flag_neg, full_flag);
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000001100000),
    .AEP1(32'b00000000000000000000000001110000),
    .AF(32'b00000000000000000001111110100000),
    .AFM1(32'b00000000000000000001111110010000),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("18"),
    .DATA_WIDTH_B("18"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000010000),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111110000),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_0 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia(di[8:0]),
    .dib(di[17:9]),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .doa(do[8:0]),
    .dob(do[17:9]),
    .empty_flag(empty_flag),
    .full_flag(full_flag));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000001100000),
    .AEP1(32'b00000000000000000000000001110000),
    .AF(32'b00000000000000000001111110100000),
    .AFM1(32'b00000000000000000001111110010000),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("18"),
    .DATA_WIDTH_B("18"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000010000),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111110000),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_1 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia(di[26:18]),
    .dib(di[35:27]),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .doa(do[26:18]),
    .dob(do[35:27]));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000001100000),
    .AEP1(32'b00000000000000000000000001110000),
    .AF(32'b00000000000000000001111110100000),
    .AFM1(32'b00000000000000000001111110010000),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("18"),
    .DATA_WIDTH_B("18"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000010000),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111110000),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_2 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia(di[44:36]),
    .dib(di[53:45]),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .doa(do[44:36]),
    .dob(do[53:45]));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000001100000),
    .AEP1(32'b00000000000000000000000001110000),
    .AF(32'b00000000000000000001111110100000),
    .AFM1(32'b00000000000000000001111110010000),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("18"),
    .DATA_WIDTH_B("18"),
    .E(32'b00000000000000000000000000000000),
    .EP1(32'b00000000000000000000000000010000),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111110000),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("OUTREG"),
    .REGMODE_B("OUTREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_3 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia(di[62:54]),
    .dib(di[71:63]),
    .orea(1'b1),
    .oreb(1'b1),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .doa(do[62:54]),
    .dob(do[71:63]));

endmodule 

