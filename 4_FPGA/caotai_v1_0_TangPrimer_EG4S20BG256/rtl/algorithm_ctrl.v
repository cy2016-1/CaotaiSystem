`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: algorithm_ctrl
// Project Name: caotai_v1_0
// Description: 
//   1.The delay from rd_fifo to dout_fifo is 2 clk.
//   2.The delay from addr_rom to dout_rom is 2 clk.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/29 10:16:32
// 
//////////////////////////////////////////////////////////////////////////////////


module algorithm_ctrl
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
  output reg                          nnp_req        = 'd0 ,
  input                               nnp_ack              ,
  output reg [WID_8             -1:0] nnp_type       = 'd0 ,
  output reg [WID_16            -1:0] data_out1      = 'd0 ,
  output reg [WID_16            -1:0] data_out2      = 'd0 ,
  output reg [WID_16            -1:0] data_out3      = 'd0 ,
  input                               nnp_vld              ,
  input      [WID_16            -1:0] data_in1             ,
  input      [WID_16            -1:0] data_in2             ,
  input      [WID_16            -1:0] data_in3             ,
  // output
  output reg [WID_8             -1:0] cmd_out_vld    = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data0  = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data1  = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data2  = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data3  = 'd0
);


// FIFO
localparam                            WID_72         =  72 ;
reg                                   wr_fifo        = 'd0 ;
reg          [WID_72            -1:0] din_fifo       = 'd0 ;
reg                                   rd_fifo        = 'd0 ;
wire         [WID_72            -1:0] dout_fifo            ;
wire                                  full_fifo            ;
wire                                  empty_fifo           ;
reg                                   empty_fifo_d1  = 'd0 ;
reg                                   empty_fifo_d2  = 'd0 ;
reg                                   nnp_jump       = 'd0 ;
reg          [WID_16            -1:0] time_limit     = 'd0 ;
reg          [WID_8             -1:0] func_range     = 'd0 ;
// FSM
localparam                            STATE_W        =   3 ;
reg          [STATE_W           -1:0] curr_state     = 'd0 ;
reg          [STATE_W           -1:0] next_state     = 'd0 ;
localparam                            IDLE           =   0 ;
localparam                            WAIT_NEMPTY    =   1 ;
localparam                            REQ_NN         =   2 ;
localparam                            CAL_HEIGHT     =   3 ;
localparam                            CAL_TIME       =   4 ;
localparam                            WRITE_CMD      =   5 ;
reg          [STATE_W           -1:0] curr_state_d1  = 'd0 ;
reg          [STATE_W           -1:0] curr_state_d2  = 'd0 ;
localparam                            IDLE_MAX       = 2048;
reg          [WID_16            -1:0] idle_cnt       = 'd0 ;
reg                                   idle_enough    = 'd0 ;
reg          [WID_8             -1:0] time_cnt       = 'd0 ;
reg                                   time_enough    = 'd0 ;
reg          [WID_16            -1:0] height_a       = 'd0 ;
reg          [WID_16            -1:0] height_b       = 'd0 ;
reg          [WID_16            -1:0] height_c       = 'd0 ;
localparam                            WID_26         =  26 ;
reg                                   nnp_vld_d1     = 'd0 ;
reg                                   nnp_vld_d2     = 'd0 ;
reg          [WID_26            -1:0] nn_res1_5      = 'd0 ;
reg          [WID_26            -1:0] nn_res2_5      = 'd0 ;
reg          [WID_26            -1:0] nn_res1_256    = 'd0 ;
reg          [WID_26            -1:0] nn_res2_256    = 'd0 ;
reg          [WID_26            -1:0] nn_res1_341    = 'd0 ;
reg          [WID_26            -1:0] nn_res2_341    = 'd0 ;
reg          [WID_16            -1:0] type1_ha       = 'd0 ;
reg          [WID_16            -1:0] type1_hb       = 'd0 ;
reg          [WID_16            -1:0] type1_hc       = 'd0 ;
reg          [WID_16            -1:0] nn_res1        = 'd0 ;
reg          [WID_16            -1:0] nn_res2        = 'd0 ;
reg          [WID_16            -1:0] nn_res3        = 'd0 ;
reg                                   type1_res_vld  = 'd0 ;
reg                                   type2_res_vld  = 'd0 ;
// h2t
localparam                            WID_11         =  11 ;
reg          [WID_11   -1:0]          addr_a         = 'd0 ;
reg          [WID_11   -1:0]          addr_b         = 'd0 ;
reg          [WID_11   -1:0]          addr_c         = 'd0 ;
reg          [WID_11   -1:0]          addr_rom       = 'd0 ;
wire         [WID_16   -1:0]          dout_rom             ;
reg          [WID_16   -1:0]          dout_rom_d1    = 'd0 ;
reg          [WID_16   -1:0]          dout_rom_d2    = 'd0 ;


always @(posedge clk)
begin
  if (time_cnt=='d6)
  begin
    cmd_out_vld   <= func_range;
    cmd_out_data0 <= time_limit;
    cmd_out_data1 <= dout_rom_d2;
    cmd_out_data2 <= dout_rom_d1;
    cmd_out_data3 <= dout_rom;
  end
  else
  begin
    cmd_out_vld   <= 'd0;
    cmd_out_data0 <= 'd0;
    cmd_out_data1 <= 'd0;
    cmd_out_data2 <= 'd0;
    cmd_out_data3 <= 'd0;
  end
end

//******************************************************************
//****************************** FSM *******************************
//******************************************************************
always @(posedge clk)
begin
  if (rst)
  begin
    curr_state <= IDLE;
  end
  else
  begin
    curr_state <= next_state;
  end
end

always @(*)
begin
  case (curr_state)
    IDLE :
    begin
      next_state = idle_enough ? WAIT_NEMPTY : IDLE;
    end
    WAIT_NEMPTY :
    begin
      next_state = (empty_fifo_d2=='d0) ? REQ_NN : WAIT_NEMPTY;
    end
    REQ_NN :
    begin
      next_state = CAL_HEIGHT;
    end
    CAL_HEIGHT :
    begin
      next_state = (nnp_jump || type1_res_vld || type2_res_vld) ? CAL_TIME : CAL_HEIGHT;
    end
    CAL_TIME :
    begin
      next_state = time_enough ? WAIT_NEMPTY : CAL_TIME;
    end
    default :
    begin
      next_state = IDLE;
    end
  endcase
end

always @(posedge clk)
begin
  if (time_cnt=='d1)
  begin
    addr_rom <= addr_a;
  end
  else if (time_cnt=='d2)
  begin
    addr_rom <= addr_b;
  end
  else if (time_cnt=='d3)
  begin
    addr_rom <= addr_c;
  end
  else
  begin
    addr_rom <= 'd0;
  end
end

always @(posedge clk)
begin
  if (height_a[WID_16-1])
  begin
    addr_a <= 'd0;
  end
  else if (height_a[WID_16-1:2]>='d2048)
  begin
    addr_a <= 'd2047;
  end
  else
  begin
    addr_a <= height_a[WID_16-1:2];
  end
end

always @(posedge clk)
begin
  if (height_b[WID_16-1])
  begin
    addr_b <= 'd0;
  end
  else if (height_b[WID_16-1:2]>='d2048)
  begin
    addr_b <= 'd2047;
  end
  else
  begin
    addr_b <= height_b[WID_16-1:2];
  end
end

always @(posedge clk)
begin
  if (height_c[WID_16-1])
  begin
    addr_c <= 'd0;
  end
  else if (height_c[WID_16-1:2]>='d2048)
  begin
    addr_c <= 'd2047;
  end
  else
  begin
    addr_c <= height_c[WID_16-1:2];
  end
end

always @(posedge clk)
begin
  if (curr_state==IDLE)
  begin
    height_a <= 'd0;
    height_b <= 'd0;
    height_c <= 'd0;
  end
  else if (nnp_jump)
  begin
    height_a <= data_out1;
    height_b <= data_out2;
    height_c <= data_out3;
  end
  else if (type1_res_vld)
  begin
    height_a <= type1_ha;
    height_b <= type1_hb;
    height_c <= type1_hc;
  end
  else if (type2_res_vld)
  begin
    height_a <= nn_res1;
    height_b <= nn_res2;
    height_c <= nn_res3;
  end
  else
  begin
    height_a <= height_a;
    height_b <= height_b;
    height_c <= height_c;
  end
end

always @(posedge clk)
begin
  nnp_vld_d1  <= nnp_vld;
  nnp_vld_d2  <= nnp_vld_d1;
  nn_res1_5   <= {{(WID_26-WID_16-2){data_in1[WID_16-1]}}, data_in1, 2'b0} + {{(WID_26-WID_16){data_in1[WID_16-1]}}, data_in1};
  nn_res2_5   <= {{(WID_26-WID_16-2){data_in2[WID_16-1]}}, data_in2, 2'b0} + {{(WID_26-WID_16){data_in2[WID_16-1]}}, data_in2};
  nn_res1_256 <= {{(WID_26-WID_16-8){data_in1[WID_16-1]}}, data_in1, 8'b0};
  nn_res2_256 <= {{(WID_26-WID_16-8){data_in2[WID_16-1]}}, data_in2, 8'b0};
  nn_res1_341 <= nn_res1_256 + {nn_res1_5, 4'b0} + nn_res1_5;
  nn_res2_341 <= nn_res2_256 + {nn_res2_5, 4'b0} + nn_res2_5;
end

always @(posedge clk)
begin
  type1_res_vld <= ((nnp_vld_d2=='d1) && (nnp_type=='d1));
  type2_res_vld <= ((nnp_vld   =='d1) && (nnp_type=='d2));
  type1_ha <= data_out3 - nn_res1_341[WID_26-1:10] - nn_res2_341[WID_26-1:10];
  type1_hb <= data_out3 + nn_res1_341[WID_26-1: 9] - nn_res2_341[WID_26-1:10];
  type1_hc <= data_out3 - nn_res1_341[WID_26-1:10] + nn_res2_341[WID_26-1: 9];
  nn_res1 <= data_in1;
  nn_res2 <= data_in2;
  nn_res3 <= data_in3;
end

always @(posedge clk)
begin
  if (curr_state_d2==IDLE)
  begin
    nnp_jump  <= 'd0;
    nnp_req   <= 'd0;
    nnp_type  <= 'd0;
    func_range<= 'd0;
    time_limit<= 'd0;
    data_out1 <= 'd0;
    data_out2 <= 'd0;
    data_out3 <= 'd0;
  end
  else if (curr_state_d2==REQ_NN)
  begin
    nnp_jump  <= (dout_fifo[71:68]=='d0) ? 'd1 : 'd0;
    nnp_req   <= (dout_fifo[71:68]!='d0) ? 'd1 : 'd0;
    nnp_type  <= {4'b0, dout_fifo[71:68]};
    func_range<= {4'b0, dout_fifo[67:64]};
    time_limit<= dout_fifo[63:48];
    data_out1 <= dout_fifo[47:32];
    data_out2 <= dout_fifo[31:16];
    data_out3 <= dout_fifo[15: 0];
  end
  else
  begin
    nnp_jump  <= 'd0;
    nnp_req   <= nnp_ack ? 'd0 : nnp_req;
    nnp_type  <= nnp_type ;
    func_range<= func_range;
    time_limit<= time_limit;
    data_out1 <= data_out1;
    data_out2 <= data_out2;
    data_out3 <= data_out3;
  end
end

always @(posedge clk)
begin
  if (curr_state==IDLE)
  begin
    idle_cnt <= idle_cnt + 'd1;
  end
  else
  begin
    idle_cnt <= 'd0;
  end
end

always @(posedge clk)
begin
  if (curr_state==CAL_TIME)
  begin
    time_cnt <= time_cnt + 'd1;
  end
  else
  begin
    time_cnt <= 'd0;
  end
end

always @(posedge clk)
begin
  time_enough <=  (time_cnt   == 'd7) ? 'd1 : 'd0;
  idle_enough <=  (idle_cnt   == IDLE_MAX -2) ? 'd1 : 'd0;
  rd_fifo     <= ((curr_state == WAIT_NEMPTY) && (empty_fifo_d2=='d0)) ? 'd1 : 'd0;
end

always @(posedge clk)
begin
  empty_fifo_d1 <= empty_fifo;
  empty_fifo_d2 <= empty_fifo_d1;
  curr_state_d1 <= curr_state;
  curr_state_d2 <= curr_state_d1;
  dout_rom_d1   <= dout_rom;
  dout_rom_d2   <= dout_rom_d1;
end

//******************************************************************
//****************************** FIFO ******************************
//******************************************************************
always @(posedge clk_48m)
begin
  wr_fifo  <= cmd_in_vld;
  din_fifo <= {cmd_in_type, cmd_in_data0, cmd_in_data1, cmd_in_data2, cmd_in_data3};
end

algorithm_cmd_fifo_72bit
algorithm_cmd_fifo_inst1
(
  .rst                     (rst_48m                ),
  .di                      (din_fifo               ), // input wire [71 : 0] din
  .clkw                    (clk_48m                ),
  .we                      (wr_fifo                ), // input wire wr_en
  .do                      (dout_fifo              ), // output wire [71 : 0] dout
  .clkr                    (clk                    ),
  .re                      (rd_fifo                ), // input wire rd_en
  .empty_flag              (empty_fifo             ),
  .full_flag               (full_fifo              )
);

h2t_rom
h2t_rom_inst1
(
  .doa                     (dout_rom               ),
  .addra                   (addr_rom               ),
  .clka                    (clk                    ),
  .rsta                    (rst                    )
);

endmodule
