`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: async_pulse_counter
// Project Name: caotai_v1_0
// Description: 
//   1.sync wr_clk & rd_clk to dst_clk.
//   2.wr->pulse_num++, rd->pulse_num--.
// 
// Revision:
// Revision 0.01 - File Created, 2023/12/14 21:20:33
// 
//////////////////////////////////////////////////////////////////////////////////


module async_pulse_counter
#(
  parameter                           WID_16             =   16
)
(
  // dst clk domain
  input                               dst_clk                   ,
  input                               dst_rst                   ,
  output reg [WID_16            -1:0] pulse_num          =  'd0 ,
  // wr clk domain
  input                               wr_clk                    ,
  input                               wr_rst                    ,
  input                               wr_pulse                  ,
  // rd clk domain
  input                               rd_clk                    ,
  input                               rd_rst                    ,
  input                               rd_pulse
);


reg                                   wr_q               =  'd0 ;
reg                                   wr_q_d1            =  'd0 ;
reg                                   wr_q_d2            =  'd0 ;
reg                                   wr_q_d3            =  'd0 ;
reg                                   rd_q               =  'd0 ;
reg                                   rd_q_d1            =  'd0 ;
reg                                   rd_q_d2            =  'd0 ;
reg                                   rd_q_d3            =  'd0 ;


always @(posedge dst_clk)
begin
  if (dst_rst)
  begin
    pulse_num <= 'd0;
  end
  else
  begin
    pulse_num <= pulse_num + (wr_q_d2^wr_q_d3) - (rd_q_d2^rd_q_d3);
  end
end

always @(posedge dst_clk)
begin
  wr_q_d1 <= wr_q   ;
  wr_q_d2 <= wr_q_d1;
  wr_q_d3 <= wr_q_d2;
  rd_q_d1 <= rd_q   ;
  rd_q_d2 <= rd_q_d1;
  rd_q_d3 <= rd_q_d2;
end

always @(posedge wr_clk)
begin
  if (wr_rst)
  begin
    wr_q <= 'd0;
  end
  else if (wr_pulse)
  begin
    wr_q <= ~wr_q;
  end
  else
  begin
    wr_q <=  wr_q;
  end
end

always @(posedge rd_clk)
begin
  if (rd_rst)
  begin
    rd_q <= 'd0;
  end
  else if (rd_pulse)
  begin
    rd_q <= ~rd_q;
  end
  else
  begin
    rd_q <=  rd_q;
  end
end

endmodule
