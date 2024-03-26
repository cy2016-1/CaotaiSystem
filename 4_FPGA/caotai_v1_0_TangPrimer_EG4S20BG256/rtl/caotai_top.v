`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: caotai_top
// Project Name: caotai_v1_0
// Description: 
//   1.This module make instance of protocol_top & algorithm_top & foot_ctrl_top.
//   2.This module contains 3 clock domains, which are 48MHz, 96MHz, and 4MHz.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/28 13:42:18
// 
//////////////////////////////////////////////////////////////////////////////////


module caotai_top
(
  input                               sys_clk              ,
  input                               soft_rstn            ,
  input                               scs0                 ,
  input                               sclk                 ,
  output                              miso                 ,
  input                               mosi                 ,
  // servo out
  output                              servo_1a             ,
  output                              servo_1b             ,
  output                              servo_1c             ,
  output                              servo_1d             ,
  output                              servo_2a             ,
  output                              servo_2b             ,
  output                              servo_2c             ,
  output                              servo_2d             ,
  output                              servo_3a             ,
  output                              servo_3b             ,
  output                              servo_3c             ,
  output                              servo_3d             ,
  output                              servo_4a             ,
  output                              servo_4b             ,
  output                              servo_4c             ,
  output                              servo_4d             ,
  // ila
  output                              foot_backpress       ,
  output                              foot_busystate       ,
  output                              ila_keep1            ,
  output                              ila_keep2
);


// clk & rst
localparam                            WID_32         =  32 ;
localparam                            WID_16         =  16 ;
localparam                            WID_8          =   8 ;
wire                                  extlock              ;
wire                                  clk_48m              ;
wire                                  clk_72m              ;
wire                                  clk_4m               ;
wire                                  rst_48m              ;
wire                                  rst_72m              ;
wire                                  rst_4m               ;
// cmd out
wire         [WID_16            -1:0] cmd_err_num          ;
wire                                  cmd_end_flag         ;
wire                                  cmd_out_vld          ;
wire         [WID_8             -1:0] cmd_out_type         ;
wire         [WID_16            -1:0] cmd_out_data0        ;
wire         [WID_16            -1:0] cmd_out_data1        ;
wire         [WID_16            -1:0] cmd_out_data2        ;
wire         [WID_16            -1:0] cmd_out_data3        ;
// algorithm out
wire         [WID_8             -1:0] algorithm_out_vld    ;
wire         [WID_16            -1:0] algorithm_out_data0  ;
wire         [WID_16            -1:0] algorithm_out_data1  ;
wire         [WID_16            -1:0] algorithm_out_data2  ;
wire         [WID_16            -1:0] algorithm_out_data3  ;
// dfx
localparam                            FIFO_PG_FULL   = 256 ;
wire                                  foot1_wr_fifo        ;
wire                                  foot1_rd_fifo        ;
wire         [WID_16            -1:0] foot1_cmd_num        ;
reg                                   foot1_pg_full  = 'd0 ;
reg                                   foot1_empty    = 'd0 ;
wire                                  foot2_wr_fifo        ;
wire                                  foot2_rd_fifo        ;
wire         [WID_16            -1:0] foot2_cmd_num        ;
reg                                   foot2_pg_full  = 'd0 ;
reg                                   foot2_empty    = 'd0 ;
wire                                  foot3_wr_fifo        ;
wire                                  foot3_rd_fifo        ;
wire         [WID_16            -1:0] foot3_cmd_num        ;
reg                                   foot3_pg_full  = 'd0 ;
reg                                   foot3_empty    = 'd0 ;
wire                                  foot4_wr_fifo        ;
wire                                  foot4_rd_fifo        ;
wire         [WID_16            -1:0] foot4_cmd_num        ;
reg                                   foot4_pg_full  = 'd0 ;
reg                                   foot4_empty    = 'd0 ;
wire         [WID_32            -1:0] spi_back_string      ;
// bias
localparam                            BIAS_1A        =   70 ;
localparam                            BIAS_1B        = - 25 ;
localparam                            BIAS_1C        = - 10 ;
localparam                            BIAS_2A        = -110 ;
localparam                            BIAS_2B        = - 40 ;
localparam                            BIAS_2C        = - 75 ;
localparam                            BIAS_3A        = - 75 ;
localparam                            BIAS_3B        = - 20 ;
localparam                            BIAS_3C        = - 35 ;
localparam                            BIAS_4A        = -  5 ;
localparam                            BIAS_4B        = - 55 ;
localparam                            BIAS_4C        = - 45 ;
localparam                            GAIN_1A        =    0 ;
localparam                            GAIN_1B        =    0 ;
localparam                            GAIN_1C        =    0 ;
localparam                            GAIN_2A        =    0 ;
localparam                            GAIN_2B        =    0 ;
localparam                            GAIN_2C        =    0 ;
localparam                            GAIN_3A        =    0 ;
localparam                            GAIN_3B        =    0 ;
localparam                            GAIN_3C        =    0 ;
localparam                            GAIN_4A        =    0 ;
localparam                            GAIN_4B        =    0 ;
localparam                            GAIN_4C        =    0 ;


assign ila_keep1 = (|cmd_err_num) & (|cmd_end_flag) & (|cmd_out_vld) & (|cmd_out_type) &
                   (|cmd_out_data0) & (|cmd_out_data1) & (|cmd_out_data2) & (|cmd_out_data3);

assign ila_keep2 = (ila_keep3) &
                   (|algorithm_out_data0) & (|algorithm_out_data1) &
                   (|algorithm_out_data2) & (|algorithm_out_data3);

reg ila_keep3 = 'd0;
always @(posedge clk_72m)
begin
  ila_keep3 <= |algorithm_out_vld;
end

//******************************************************************
//*************************** clk & rst ****************************
//******************************************************************
pll1
pll_inst1
(
  .refclk                   (sys_clk            ), // input  24MHz
  .reset                    ('d0                ),
  .extlock                  (extlock            ), // output lock
  .clk0_out                 (clk_48m            ), // output 48MHz
  .clk1_out                 (clk_72m            ), // output 72MHz
  .clk2_out                 (clk_4m             )  // output  4MHz
);

reset_sync
reset_sync_48m
(
  .clk                      (clk_48m            ), // input     
  .pll_lock                 (extlock            ), // input     
  .rst                      (rst_48m            )  // output reg
);

reset_sync
reset_sync_96m
(
  .clk                      (clk_72m            ), // input     
  .pll_lock                 (extlock            ), // input     
  .rst                      (rst_72m            )  // output reg
);

reset_sync
reset_sync_4m
(
  .clk                      (clk_4m             ), // input     
  .pll_lock                 (extlock            ), // input     
  .rst                      (rst_4m             )  // output reg
);

//******************************************************************
//**************************** instance ****************************
//******************************************************************
protocol_top
#(
  .WID_32                   (WID_32             ),
  .WID_16                   (WID_16             ),
  .WID_8                    (WID_8              )
)
protocol_top_inst1
(
  .clk_48m                  (clk_48m            ), // input                              
  .rst_48m                  (rst_48m            ), // input                              
  .scs0                     (scs0               ), // input                              
  .sclk                     (sclk               ), // input                              
  .miso                     (miso               ), // output                             
  .mosi                     (mosi               ), // input                              
  .data_in                  (spi_back_string    ), // input      [WID_32            -1:0]
  // cmd out
  .cmd_err_num              (cmd_err_num        ), // output     [WID_16            -1:0]
  .cmd_end_flag             (cmd_end_flag       ), // output                             
  .cmd_out_vld              (cmd_out_vld        ), // output                             
  .cmd_out_type             (cmd_out_type       ), // output     [WID_8             -1:0]
  .cmd_out_data0            (cmd_out_data0      ), // output     [WID_16            -1:0]
  .cmd_out_data1            (cmd_out_data1      ), // output     [WID_16            -1:0]
  .cmd_out_data2            (cmd_out_data2      ), // output     [WID_16            -1:0]
  .cmd_out_data3            (cmd_out_data3      )  // output     [WID_16            -1:0]
);

algorithm_top
#(
  .WID_16                   (WID_16             ),
  .WID_8                    (WID_8              )
)
algorithm_top_inst1
(
  .clk_48m                  (clk_48m            ), // input                              
  .rst_48m                  (rst_48m            ), // input                              
  .cmd_in_vld               (cmd_out_vld        ), // input                              
  .cmd_in_type              (cmd_out_type       ), // input      [WID_8             -1:0]
  .cmd_in_data0             (cmd_out_data0      ), // input      [WID_16            -1:0]
  .cmd_in_data1             (cmd_out_data1      ), // input      [WID_16            -1:0]
  .cmd_in_data2             (cmd_out_data2      ), // input      [WID_16            -1:0]
  .cmd_in_data3             (cmd_out_data3      ), // input      [WID_16            -1:0]
  // 96MHz clock domain
  .clk                      (clk_72m            ), // input                              
  .rst                      (rst_72m            ), // input                              
  .cmd_out_vld              (algorithm_out_vld  ), // output     [WID_8             -1:0]
  .cmd_out_data0            (algorithm_out_data0), // output     [WID_16            -1:0]
  .cmd_out_data1            (algorithm_out_data1), // output     [WID_16            -1:0]
  .cmd_out_data2            (algorithm_out_data2), // output     [WID_16            -1:0]
  .cmd_out_data3            (algorithm_out_data3)  // output     [WID_16            -1:0]
);

foot_ctrl_top
#(
  .WID_16                   (WID_16             ),
  .SERVO1_BIAS              (BIAS_1A            ),
  .SERVO2_BIAS              (BIAS_1B            ),
  .SERVO3_BIAS              (BIAS_1C            ),
  .SERVO1_GAIN              (GAIN_1A            ),
  .SERVO2_GAIN              (GAIN_1B            ),
  .SERVO3_GAIN              (GAIN_1C            )
)
foot_ctrl_top_inst1
(
  .clk                      (clk_72m            ), // input                              
  .rst                      (rst_72m            ), // input                              
  .cmd_in_vld               (algorithm_out_vld[0]), // input                              
  .cmd_in_data0             (algorithm_out_data0), // input      [WID_16            -1:0]
  .cmd_in_data1             (algorithm_out_data1), // input      [WID_16            -1:0]
  .cmd_in_data2             (algorithm_out_data2), // input      [WID_16            -1:0]
  .cmd_in_data3             (algorithm_out_data3), // input      [WID_16            -1:0]
  // 4MHz clk domain
  .clk_4mhz                 (clk_4m             ), // input                              
  .rst_4mhz                 (rst_4m             ), // input                              
  .servo_1                  (servo_1a           ), // output reg                         
  .servo_2                  (servo_1b           ), // output reg                         
  .servo_3                  (servo_1c           ), // output reg                         
  .servo_4                  (servo_1d           ), // output reg                         
  // dfx
  .dfx_wr_fifo              (foot1_wr_fifo      ), // output  
  .dfx_rd_fifo              (foot1_rd_fifo      )  // output  
);

foot_ctrl_top
#(
  .WID_16                   (WID_16             ),
  .SERVO1_BIAS              (BIAS_2A            ),
  .SERVO2_BIAS              (BIAS_2B            ),
  .SERVO3_BIAS              (BIAS_2C            ),
  .SERVO1_GAIN              (GAIN_2A            ),
  .SERVO2_GAIN              (GAIN_2B            ),
  .SERVO3_GAIN              (GAIN_2C            )
)
foot_ctrl_top_inst2
(
  .clk                      (clk_72m            ), // input                              
  .rst                      (rst_72m            ), // input                              
  .cmd_in_vld               (algorithm_out_vld[1]), // input                              
  .cmd_in_data0             (algorithm_out_data0), // input      [WID_16            -1:0]
  .cmd_in_data1             (algorithm_out_data1), // input      [WID_16            -1:0]
  .cmd_in_data2             (algorithm_out_data2), // input      [WID_16            -1:0]
  .cmd_in_data3             (algorithm_out_data3), // input      [WID_16            -1:0]
  // 4MHz clk domain
  .clk_4mhz                 (clk_4m             ), // input                              
  .rst_4mhz                 (rst_4m             ), // input                              
  .servo_1                  (servo_2a           ), // output reg                         
  .servo_2                  (servo_2b           ), // output reg                         
  .servo_3                  (servo_2c           ), // output reg                         
  .servo_4                  (servo_2d           ), // output reg                         
  // dfx
  .dfx_wr_fifo              (foot2_wr_fifo      ), // output  
  .dfx_rd_fifo              (foot2_rd_fifo      )  // output  
);

foot_ctrl_top
#(
  .WID_16                   (WID_16             ),
  .SERVO1_BIAS              (BIAS_3A            ),
  .SERVO2_BIAS              (BIAS_3B            ),
  .SERVO3_BIAS              (BIAS_3C            ),
  .SERVO1_GAIN              (GAIN_3A            ),
  .SERVO2_GAIN              (GAIN_3B            ),
  .SERVO3_GAIN              (GAIN_3C            )
)
foot_ctrl_top_inst3
(
  .clk                      (clk_72m            ), // input                              
  .rst                      (rst_72m            ), // input                              
  .cmd_in_vld               (algorithm_out_vld[2]), // input                              
  .cmd_in_data0             (algorithm_out_data0), // input      [WID_16            -1:0]
  .cmd_in_data1             (algorithm_out_data1), // input      [WID_16            -1:0]
  .cmd_in_data2             (algorithm_out_data2), // input      [WID_16            -1:0]
  .cmd_in_data3             (algorithm_out_data3), // input      [WID_16            -1:0]
  // 4MHz clk domain
  .clk_4mhz                 (clk_4m             ), // input                              
  .rst_4mhz                 (rst_4m             ), // input                              
  .servo_1                  (servo_3a           ), // output reg                         
  .servo_2                  (servo_3b           ), // output reg                         
  .servo_3                  (servo_3c           ), // output reg                         
  .servo_4                  (servo_3d           ), // output reg                         
  // dfx
  .dfx_wr_fifo              (foot3_wr_fifo      ), // output  
  .dfx_rd_fifo              (foot3_rd_fifo      )  // output  
);

foot_ctrl_top
#(
  .WID_16                   (WID_16             ),
  .SERVO1_BIAS              (BIAS_4A            ),
  .SERVO2_BIAS              (BIAS_4B            ),
  .SERVO3_BIAS              (BIAS_4C            ),
  .SERVO1_GAIN              (GAIN_4A            ),
  .SERVO2_GAIN              (GAIN_4B            ),
  .SERVO3_GAIN              (GAIN_4C            )
)
foot_ctrl_top_inst4
(
  .clk                      (clk_72m            ), // input                              
  .rst                      (rst_72m            ), // input                              
  .cmd_in_vld               (algorithm_out_vld[3]), // input                              
  .cmd_in_data0             (algorithm_out_data0), // input      [WID_16            -1:0]
  .cmd_in_data1             (algorithm_out_data1), // input      [WID_16            -1:0]
  .cmd_in_data2             (algorithm_out_data2), // input      [WID_16            -1:0]
  .cmd_in_data3             (algorithm_out_data3), // input      [WID_16            -1:0]
  // 4MHz clk domain
  .clk_4mhz                 (clk_4m             ), // input                              
  .rst_4mhz                 (rst_4m             ), // input                              
  .servo_1                  (servo_4a           ), // output reg                         
  .servo_2                  (servo_4b           ), // output reg                         
  .servo_3                  (servo_4c           ), // output reg                         
  .servo_4                  (servo_4d           ), // output reg                         
  // dfx
  .dfx_wr_fifo              (foot4_wr_fifo      ), // output  
  .dfx_rd_fifo              (foot4_rd_fifo      )  // output  
);

//******************************************************************
//****************************** dfx *******************************
//******************************************************************
async_pulse_counter
async_counter_inst1
(
  // dst clk domain
  .dst_clk                  (clk_72m            ),
  .dst_rst                  (rst_72m            ),
  .pulse_num                (foot1_cmd_num      ),
  // wr clk domain
  .wr_clk                   (clk_72m            ),
  .wr_rst                   (rst_72m            ),
  .wr_pulse                 (foot1_wr_fifo      ),
  // rd clk domain
  .rd_clk                   (clk_4m             ),
  .rd_rst                   (rst_4m             ),
  .rd_pulse                 (foot1_rd_fifo      )
);

async_pulse_counter
async_counter_inst2
(
  // dst clk domain
  .dst_clk                  (clk_72m            ),
  .dst_rst                  (rst_72m            ),
  .pulse_num                (foot2_cmd_num      ),
  // wr clk domain
  .wr_clk                   (clk_72m            ),
  .wr_rst                   (rst_72m            ),
  .wr_pulse                 (foot2_wr_fifo      ),
  // rd clk domain
  .rd_clk                   (clk_4m             ),
  .rd_rst                   (rst_4m             ),
  .rd_pulse                 (foot2_rd_fifo      )
);

async_pulse_counter
async_counter_inst3
(
  // dst clk domain
  .dst_clk                  (clk_72m            ),
  .dst_rst                  (rst_72m            ),
  .pulse_num                (foot3_cmd_num      ),
  // wr clk domain
  .wr_clk                   (clk_72m            ),
  .wr_rst                   (rst_72m            ),
  .wr_pulse                 (foot3_wr_fifo      ),
  // rd clk domain
  .rd_clk                   (clk_4m             ),
  .rd_rst                   (rst_4m             ),
  .rd_pulse                 (foot3_rd_fifo      )
);

async_pulse_counter
async_counter_inst4
(
  // dst clk domain
  .dst_clk                  (clk_72m            ),
  .dst_rst                  (rst_72m            ),
  .pulse_num                (foot4_cmd_num      ),
  // wr clk domain
  .wr_clk                   (clk_72m            ),
  .wr_rst                   (rst_72m            ),
  .wr_pulse                 (foot4_wr_fifo      ),
  // rd clk domain
  .rd_clk                   (clk_4m             ),
  .rd_rst                   (rst_4m             ),
  .rd_pulse                 (foot4_rd_fifo      )
);

always @(posedge clk_72m)
begin
  foot1_pg_full <= (foot1_cmd_num >= FIFO_PG_FULL) ? 'd1 : 'd0;
  foot2_pg_full <= (foot2_cmd_num >= FIFO_PG_FULL) ? 'd1 : 'd0;
  foot3_pg_full <= (foot3_cmd_num >= FIFO_PG_FULL) ? 'd1 : 'd0;
  foot4_pg_full <= (foot4_cmd_num >= FIFO_PG_FULL) ? 'd1 : 'd0;
  foot1_empty   <= (foot1_cmd_num == 'd0         ) ? 'd1 : 'd0;
  foot2_empty   <= (foot2_cmd_num == 'd0         ) ? 'd1 : 'd0;
  foot3_empty   <= (foot3_cmd_num == 'd0         ) ? 'd1 : 'd0;
  foot4_empty   <= (foot4_cmd_num == 'd0         ) ? 'd1 : 'd0;
end

assign foot_backpress = foot1_pg_full | foot2_pg_full | foot3_pg_full | foot4_pg_full;
assign spi_back_string = {cmd_err_num[7:0], cmd_err_num[7:0], cmd_err_num[7:0], cmd_err_num[7:0]};
assign foot_busystate = ~(foot1_empty & foot2_empty & foot3_empty & foot4_empty);

endmodule
