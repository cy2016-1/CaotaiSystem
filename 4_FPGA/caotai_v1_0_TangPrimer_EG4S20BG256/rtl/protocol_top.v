`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: protocol_top
// Project Name: caotai_v1_0
// Description: 
//   1.This module make instance of spi_slave_mode0 & gcode_analysis.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/28 13:20:08
// 
//////////////////////////////////////////////////////////////////////////////////


module protocol_top
#(
  parameter                           WID_32         =  32 ,
  parameter                           WID_16         =  16 ,
  parameter                           WID_8          =   8
)
(
  input                               clk_48m              ,
  input                               rst_48m              ,
  input                               scs0                 ,
  input                               sclk                 ,
  output                              miso                 ,
  input                               mosi                 ,
  input      [WID_32            -1:0] data_in              ,
  // cmd out
  output     [WID_16            -1:0] cmd_err_num          ,
  output                              cmd_end_flag         ,
  output                              cmd_out_vld          ,
  output     [WID_8             -1:0] cmd_out_type         ,
  output     [WID_16            -1:0] cmd_out_data0        ,
  output     [WID_16            -1:0] cmd_out_data1        ,
  output     [WID_16            -1:0] cmd_out_data2        ,
  output     [WID_16            -1:0] cmd_out_data3
);


wire         [WID_8             -1:0] data_spi             ;
wire                                  data_spi_vld         ;


spi_slave_mode0
#(
  .WID_32                    (WID_32               ),
  .WID_8                     (WID_8                )
)
spi_slave_mode0_inst1
(
  .clk                       (clk_48m              ), // input                              
  .scs0                      (scs0                 ), // input                              
  .sclk                      (sclk                 ), // input                              
  .miso                      (miso                 ), // output                             
  .mosi                      (mosi                 ), // input                              
  // data
  .data_in                   (data_in              ), // input      [WID_32            -1:0]
  .data_out                  (data_spi             ), // output reg [WID_8             -1:0]
  .data_out_vld              (data_spi_vld         ), // output reg                         
  .data_out_str              (                     ), // output reg                         
  .data_out_end              (                     )  // output reg                         
);

gcode_analysis
#(
  .WID_8                     (WID_8                ),
  .WID_16                    (WID_16               )
)
gcode_analysis_inst1
(
  .clk                       (clk_48m              ), // input                              
  .rst                       (rst_48m              ), // input                              
  .data_spi                  (data_spi             ), // input      [WID_8             -1:0]
  .data_spi_vld              (data_spi_vld         ), // input                              
  // cmd out
  .cmd_err_num               (cmd_err_num          ), // output reg [WID_16            -1:0]
  .cmd_end_flag              (cmd_end_flag         ), // output reg                         
  .cmd_out_vld               (cmd_out_vld          ), // output reg                         
  .cmd_out_type              (cmd_out_type         ), // output reg [WID_8             -1:0]
  .cmd_out_data0             (cmd_out_data0        ), // output reg [WID_16            -1:0]
  .cmd_out_data1             (cmd_out_data1        ), // output reg [WID_16            -1:0]
  .cmd_out_data2             (cmd_out_data2        ), // output reg [WID_16            -1:0]
  .cmd_out_data3             (cmd_out_data3        )  // output reg [WID_16            -1:0]
);

endmodule
