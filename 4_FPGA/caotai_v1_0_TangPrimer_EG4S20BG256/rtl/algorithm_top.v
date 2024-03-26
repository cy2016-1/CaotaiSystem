`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: algorithm_top
// Project Name: caotai_v1_0
// Description: 
//   1.This module make instances of algorithm_ctrl & nn_processor.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/29 14:04:07
// 
//////////////////////////////////////////////////////////////////////////////////


module algorithm_top
#(
  parameter                           WID_8          =   8 ,
  parameter                           WID_16         =  16
)
(
  input                               clk_48m              ,
  input                               rst_48m              ,
  input                               cmd_in_vld           ,
  input      [WID_8             -1:0] cmd_in_type          ,
  input      [WID_16            -1:0] cmd_in_data0         ,
  input      [WID_16            -1:0] cmd_in_data1         ,
  input      [WID_16            -1:0] cmd_in_data2         ,
  input      [WID_16            -1:0] cmd_in_data3         ,
  // 96MHz clock domain
  input                               clk                  ,
  input                               rst                  ,
  output     [WID_8             -1:0] cmd_out_vld          ,
  output     [WID_16            -1:0] cmd_out_data0        ,
  output     [WID_16            -1:0] cmd_out_data1        ,
  output     [WID_16            -1:0] cmd_out_data2        ,
  output     [WID_16            -1:0] cmd_out_data3
);


wire                                  nnp_req              ;
wire                                  nnp_ack              ;
wire         [WID_8             -1:0] nnp_type             ;
wire         [WID_16            -1:0] data_in1             ;
wire         [WID_16            -1:0] data_in2             ;
wire         [WID_16            -1:0] data_in3             ;
wire                                  nnp_vld              ;
wire         [WID_16            -1:0] data_out1            ;
wire         [WID_16            -1:0] data_out2            ;
wire         [WID_16            -1:0] data_out3            ;


nn_processor
#(
  .WID_8                    (WID_8              ),
  .WID_16                   (WID_16             )
)
nn_processor_inst1
(
  .clk                      (clk                ), // input                              
  .rst                      (rst                ), // input                              
  .nnp_req                  (nnp_req            ), // input                              
  .nnp_ack                  (nnp_ack            ), // output reg                         
  .nnp_type                 (nnp_type           ), // input      [WID_8             -1:0]
  .data_in1                 (data_in1           ), // input      [WID_16            -1:0]
  .data_in2                 (data_in2           ), // input      [WID_16            -1:0]
  .data_in3                 (data_in3           ), // input      [WID_16            -1:0]
  .nnp_vld                  (nnp_vld            ), // output reg                         
  .data_out1                (data_out1          ), // output reg [WID_16            -1:0]
  .data_out2                (data_out2          ), // output reg [WID_16            -1:0]
  .data_out3                (data_out3          )  // output reg [WID_16            -1:0]
);

algorithm_ctrl
#(
  .WID_8                    (WID_8              ),
  .WID_16                   (WID_16             )
)
algorithm_ctrl_inst1
(
  .clk_48m                  (clk_48m            ), // input                              
  .rst_48m                  (rst_48m            ), // input                              
  .cmd_in_vld               (cmd_in_vld         ), // input                              
  .cmd_in_type              (cmd_in_type        ), // input      [WID_8             -1:0]
  .cmd_in_data0             (cmd_in_data0       ), // input      [WID_16            -1:0]
  .cmd_in_data1             (cmd_in_data1       ), // input      [WID_16            -1:0]
  .cmd_in_data2             (cmd_in_data2       ), // input      [WID_16            -1:0]
  .cmd_in_data3             (cmd_in_data3       ), // input      [WID_16            -1:0]
  // 96MHz clock domain
  .clk                      (clk                ), // input                              
  .rst                      (rst                ), // input                              
  .nnp_req                  (nnp_req            ), // output reg                         
  .nnp_ack                  (nnp_ack            ), // input                              
  .nnp_type                 (nnp_type           ), // output reg [WID_8             -1:0]
  .data_out1                (data_in1           ), // output reg [WID_16            -1:0]
  .data_out2                (data_in2           ), // output reg [WID_16            -1:0]
  .data_out3                (data_in3           ), // output reg [WID_16            -1:0]
  .nnp_vld                  (nnp_vld            ), // input                              
  .data_in1                 (data_out1          ), // input      [WID_16            -1:0]
  .data_in2                 (data_out2          ), // input      [WID_16            -1:0]
  .data_in3                 (data_out3          ), // input      [WID_16            -1:0]
  // output
  .cmd_out_vld              (cmd_out_vld        ), // output reg [WID_8             -1:0]
  .cmd_out_data0            (cmd_out_data0      ), // output reg [WID_16            -1:0]
  .cmd_out_data1            (cmd_out_data1      ), // output reg [WID_16            -1:0]
  .cmd_out_data2            (cmd_out_data2      ), // output reg [WID_16            -1:0]
  .cmd_out_data3            (cmd_out_data3      )  // output reg [WID_16            -1:0]
);

endmodule
