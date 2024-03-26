`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: reset_sync
// Project Name: caotai_v1_0
// Description: 
//   1.This module converts asynchronous low-level reset to synchronous high-level reset.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/28 13:58:22
// 
//////////////////////////////////////////////////////////////////////////////////


module reset_sync
(
  input                               clk                  ,
  input                               pll_lock             ,
  output reg                          rst            = 'd0
);


reg                                   q1             = 'd0 ;
reg                                   q2             = 'd0 ;
reg                                   q3             = 'd0 ;


always @(posedge clk or negedge pll_lock)
begin
  if (~pll_lock)
  begin
    q1 <= 'd1;
    q2 <= 'd1;
  end
  else
  begin
    q1 <= 'd0;
    q2 <=  q1;
  end
end

always @(posedge clk)
begin
  q3  <= q2;
  rst <= q3;
end

endmodule
