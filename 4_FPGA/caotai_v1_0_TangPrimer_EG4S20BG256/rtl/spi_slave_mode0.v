`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: spi_slave_mode0
// Project Name: caotai_v1_0
// Description: 
//   1.This module is only applicable to SPI mode 0 and works in slave mode.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/26 15:17:02
// 
//////////////////////////////////////////////////////////////////////////////////


module spi_slave_mode0
#(
  parameter                           WID_32         =  32 ,
  parameter                           WID_8          =   8
)
(
  input                               clk                  ,
  input                               scs0                 ,
  input                               sclk                 ,
  output                              miso                 ,
  input                               mosi                 ,
  // data
  input      [WID_32            -1:0] data_in              , // to miso
  output reg [WID_8             -1:0] data_out       = 'd0 , // from mosi
  output reg                          data_out_vld   = 'd0 ,
  output reg                          data_out_str   = 'd0 ,
  output reg                          data_out_end   = 'd0
);


// pipeline
reg                                   scs0_d1        = 'd0 ;
reg                                   scs0_d2        = 'd0 ;
reg                                   scs0_d3        = 'd0 ;
reg                                   scs0_pos       = 'd0 ;
reg                                   scs0_neg       = 'd0 ;
reg                                   sclk_d1        = 'd0 ;
reg                                   sclk_d2        = 'd0 ;
reg                                   sclk_pos       = 'd0 ;
reg                                   sclk_neg       = 'd0 ;
reg                                   miso_d1        = 'd0 ;
reg                                   miso_d2        = 'd0 ;
reg                                   miso_d3        = 'd0 ;
reg                                   mosi_d1        = 'd0 ;
reg                                   mosi_d2        = 'd0 ;
reg                                   mosi_d3        = 'd0 ;
// miso
reg          [WID_32            -1:0] data_in_reg    = 'd0 ;
// recv
localparam                            BIT_PER_BYTE   =   8 ;
reg          [WID_8             -1:0] data_recv      = 'd0 ;
reg          [WID_8             -1:0] recv_cnt       = 'd0 ;


// out
always @(posedge clk)
begin
  data_out_str <= scs0_neg;
  data_out_end <= scs0_pos;
end

// recv
always @(posedge clk)
begin
  if (scs0_d3)
  begin
    data_recv <= 'd0;
    recv_cnt  <= 'd0;
    data_out     <= 'd0;
    data_out_vld <= 'd0;
  end
  else if (sclk_pos)
  begin
    data_recv <= {data_recv[6:0], mosi_d3};
    if (recv_cnt < BIT_PER_BYTE-1)
    begin
      recv_cnt <= recv_cnt + 'd1;
      data_out     <= 'd0;
      data_out_vld <= 'd0;
    end
    else
    begin
      recv_cnt <= 'd0;
      data_out     <= {data_recv[6:0], mosi_d3};
      data_out_vld <= 'd1;
    end
  end
  else
  begin
    data_recv <= data_recv;
    recv_cnt  <= recv_cnt;
    data_out     <= 'd0;
    data_out_vld <= 'd0;
  end
end

// miso
always @(posedge clk)
begin
  if (scs0_neg)
  begin
    data_in_reg <= data_in;
  end
  else if (scs0_d3)
  begin
    data_in_reg <= 'd0;
  end
  else if (sclk_neg)
  begin
    data_in_reg <= {data_in_reg[WID_32-2:0], data_in_reg[WID_32-1]};
  end
  else
  begin
    data_in_reg <= data_in_reg;
  end
end

assign miso = data_in_reg[WID_32-1];

always @(posedge clk)
begin
  scs0_d1  <= scs0;
  scs0_d2  <= scs0_d1;
  scs0_d3  <= scs0_d2;
  scs0_pos <= ~scs0_d2 & scs0_d1;
  scs0_neg <= ~scs0_d1 & scs0_d2;
  sclk_d1  <= sclk;
  sclk_d2  <= sclk_d1;
  sclk_pos <= ~sclk_d2 & sclk_d1;
  sclk_neg <= ~sclk_d1 & sclk_d2;
  miso_d1  <= miso;
  miso_d2  <= miso_d1;
  miso_d3  <= miso_d2;
  mosi_d1  <= mosi;
  mosi_d2  <= mosi_d1;
  mosi_d3  <= mosi_d2;
end

endmodule
