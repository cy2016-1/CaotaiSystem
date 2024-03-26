`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: foot_ctrl_top
// Project Name: caotai_v1_0
// Description: 
//   1.The delay from sin_addr to dout_sin is 2 clk. The delay from dout_sin to inc_speed_1 is 2 clk.
//       That's why we use curr_state_d4 to derive curr_speed_1
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/25 19:56:38
// 
//////////////////////////////////////////////////////////////////////////////////


module foot_ctrl_top
#(
  parameter                           WID_16         =  16 ,
  parameter                           SERVO1_BIAS    =   0 ,
  parameter                           SERVO2_BIAS    =   0 ,
  parameter                           SERVO3_BIAS    =   0 ,
  parameter                           SERVO1_GAIN    =   0 ,
  parameter                           SERVO2_GAIN    =   0 ,
  parameter                           SERVO3_GAIN    =   0
)
(
  input                               clk                  ,
  input                               rst                  ,
  input                               cmd_in_vld           ,
  input      [WID_16            -1:0] cmd_in_data0         ,
  input      [WID_16            -1:0] cmd_in_data1         ,
  input      [WID_16            -1:0] cmd_in_data2         ,
  input      [WID_16            -1:0] cmd_in_data3         ,
  // 4MHz clk domain
  input                               clk_4mhz             ,
  input                               rst_4mhz             ,
  output reg                          servo_1        = 'd0 ,
  output reg                          servo_2        = 'd0 ,
  output reg                          servo_3        = 'd0 ,
  output reg                          servo_4        = 'd0 ,
  // dfx
  output                              dfx_wr_fifo          ,
  output                              dfx_rd_fifo
);


reg                                   wr_fifo        = 'd0 ;
reg          [WID_16*4          -1:0] din_fifo       = 'd0 ;
reg                                   rd_fifo        = 'd0 ;
wire         [WID_16*4          -1:0] dout_fifo            ;
wire                                  full_fifo            ;
wire                                  empty_fifo           ;
reg                                   empty_fifo_d1  = 'd0 ;
reg                                   empty_fifo_d2  = 'd0 ;
// FSM
localparam                            STATE_W        =   3 ;
reg          [STATE_W           -1:0] curr_state     = 'd0 ;
reg          [STATE_W           -1:0] next_state     = 'd0 ;
localparam                            IDLE           =   0 ;
localparam                            WAIT_NEMPTY    =   1 ;
localparam                            CAL_DIFF       =   2 ;
localparam                            SPEED_INC      =   3 ;
localparam                            MOVE_UNI       =   4 ;
localparam                            WID_25         =  25 ;
localparam                            WID_9          =   9 ;
localparam                            IDLE_MAX       = 2048;
reg          [WID_16            -1:0] idle_cnt       = 'd0 ;
reg                                   idle_enough    = 'd0 ;
// speed ctrl
localparam                            RESET_SERVO    = 1500;
localparam                            MAX_SERVO      = 2500;
localparam                            MIN_SERVO      =  500;
reg          [WID_16            -1:0] time_limit     = 'd0 ;
reg                                   time_small     = 'd0 ;
reg          [WID_16            -1:0] next_speed_1   = 'd0 ;
reg          [WID_16            -1:0] next_speed_2   = 'd0 ;
reg          [WID_16            -1:0] next_speed_3   = 'd0 ;
reg          [WID_16            -1:0] last_speed_1   = 'd0 ;
reg          [WID_16            -1:0] last_speed_2   = 'd0 ;
reg          [WID_16            -1:0] last_speed_3   = 'd0 ;
reg          [WID_16            -1:0] curr_speed_1   = 'd0 ;
reg          [WID_16            -1:0] curr_speed_2   = 'd0 ;
reg          [WID_16            -1:0] curr_speed_3   = 'd0 ;
reg          [WID_16            -1:0] diff_speed_1   = 'd0 ;
reg          [WID_16            -1:0] diff_speed_2   = 'd0 ;
reg          [WID_16            -1:0] diff_speed_3   = 'd0 ;

// speed inc
localparam                            SIN_ADDR_MAX   = 1000;
reg          [WID_25            -1:0] ms_cnt         = 'd0 ;
reg                                   ms_enough      = 'd0 ;
reg          [WID_16            -1:0] sin_addr       = 'd0 ;
reg                                   sin_enough     = 'd0 ;
wire         [WID_9             -1:0] dout_sin             ;
wire         [WID_25            -1:0] inc_speed_1          ;
wire         [WID_25            -1:0] inc_speed_2          ;
wire         [WID_25            -1:0] inc_speed_3          ;
reg          [STATE_W           -1:0] curr_state_d1  = 'd0 ;
reg          [STATE_W           -1:0] curr_state_d2  = 'd0 ;
reg          [STATE_W           -1:0] curr_state_d3  = 'd0 ;
reg          [STATE_W           -1:0] curr_state_d4  = 'd0 ;
// servo
localparam                            TOTOL_TIME     =20000;
reg          [WID_25            -1:0] servo_cnt      = 'd0 ;
reg                                   servo_enough   = 'd0 ;
reg          [WID_16            -1:0] real_speed_1   = 'd0 ;
reg          [WID_16            -1:0] real_speed_2   = 'd0 ;
reg          [WID_16            -1:0] real_speed_3   = 'd0 ;
reg          [WID_16            -1:0] ssub_speed_1   = 'd0 ;
reg          [WID_16            -1:0] ssub_speed_2   = 'd0 ;
reg          [WID_16            -1:0] ssub_speed_3   = 'd0 ;
reg          [WID_16            -1:0] gain_speed_1   = 'd0 ;
reg          [WID_16            -1:0] gain_speed_2   = 'd0 ;
reg          [WID_16            -1:0] gain_speed_3   = 'd0 ;
reg          [WID_16            -1:0] thrd_speed_1   = 'd0 ;
reg          [WID_16            -1:0] thrd_speed_2   = 'd0 ;
reg          [WID_16            -1:0] thrd_speed_3   = 'd0 ;


assign dfx_wr_fifo = wr_fifo;
assign dfx_rd_fifo = rd_fifo;

//******************************************************************
//************************* servo control **************************
//******************************************************************
always @(posedge clk_4mhz)
begin
  ssub_speed_1 <= real_speed_1 - RESET_SERVO;
  ssub_speed_2 <= real_speed_2 - RESET_SERVO;
  ssub_speed_3 <= real_speed_3 - RESET_SERVO;
end

always @(posedge clk_4mhz)
begin
  if (SERVO1_GAIN==1)
  begin
    gain_speed_1 <= {{8{ssub_speed_1[15]}}, ssub_speed_1[14:7]};
  end
  else if (SERVO1_GAIN==2)
  begin
    gain_speed_1 <= {{8{ssub_speed_1[15]}}, ssub_speed_1[13:6]};
  end
  else if (SERVO1_GAIN==4)
  begin
    gain_speed_1 <= {{8{ssub_speed_1[15]}}, ssub_speed_1[12:5]};
  end
  else if (SERVO1_GAIN==6)
  begin
    gain_speed_1 <= {{8{ssub_speed_1[15]}}, ssub_speed_1[13:6]} + {{8{ssub_speed_1[15]}}, ssub_speed_1[12:5]};
  end
  else if (SERVO1_GAIN==8)
  begin
    gain_speed_1 <= {{8{ssub_speed_1[15]}}, ssub_speed_1[11:4]};
  end
  else if (SERVO1_GAIN==16)
  begin
    gain_speed_1 <= {{8{ssub_speed_1[15]}}, ssub_speed_1[10:3]};
  end
  else
  begin
    gain_speed_1 <= 'd0;
  end
end

always @(posedge clk_4mhz)
begin
  if (SERVO2_GAIN==1)
  begin
    gain_speed_2 <= {{8{ssub_speed_2[15]}}, ssub_speed_2[14:7]};
  end
  else if (SERVO2_GAIN==2)
  begin
    gain_speed_2 <= {{8{ssub_speed_2[15]}}, ssub_speed_2[13:6]};
  end
  else if (SERVO2_GAIN==4)
  begin
    gain_speed_2 <= {{8{ssub_speed_2[15]}}, ssub_speed_2[12:5]};
  end
  else if (SERVO2_GAIN==6)
  begin
    gain_speed_2 <= {{8{ssub_speed_2[15]}}, ssub_speed_2[13:6]} + {{8{ssub_speed_2[15]}}, ssub_speed_2[12:5]};
  end
  else if (SERVO2_GAIN==8)
  begin
    gain_speed_2 <= {{8{ssub_speed_2[15]}}, ssub_speed_2[11:4]};
  end
  else if (SERVO2_GAIN==16)
  begin
    gain_speed_2 <= {{8{ssub_speed_2[15]}}, ssub_speed_2[10:3]};
  end
  else
  begin
    gain_speed_2 <= 'd0;
  end
end

always @(posedge clk_4mhz)
begin
  if (SERVO3_GAIN==1)
  begin
    gain_speed_3 <= {{8{ssub_speed_3[15]}}, ssub_speed_3[14:7]};
  end
  else if (SERVO3_GAIN==2)
  begin
    gain_speed_3 <= {{8{ssub_speed_3[15]}}, ssub_speed_3[13:6]};
  end
  else if (SERVO3_GAIN==4)
  begin
    gain_speed_3 <= {{8{ssub_speed_3[15]}}, ssub_speed_3[12:5]};
  end
  else if (SERVO3_GAIN==6)
  begin
    gain_speed_3 <= {{8{ssub_speed_3[15]}}, ssub_speed_3[13:6]} + {{8{ssub_speed_3[15]}}, ssub_speed_3[12:5]};
  end
  else if (SERVO3_GAIN==8)
  begin
    gain_speed_3 <= {{8{ssub_speed_3[15]}}, ssub_speed_3[11:4]};
  end
  else if (SERVO3_GAIN==16)
  begin
    gain_speed_3 <= {{8{ssub_speed_3[15]}}, ssub_speed_3[10:3]};
  end
  else
  begin
    gain_speed_3 <= 'd0;
  end
end

always @(posedge clk_4mhz)
begin
  thrd_speed_1 <= real_speed_1 + gain_speed_1;
  thrd_speed_2 <= real_speed_2 + gain_speed_2;
  thrd_speed_3 <= real_speed_3 + gain_speed_3;
end

always @(posedge clk_4mhz)
begin
  servo_1 <= (servo_cnt < {thrd_speed_1, 2'b0}) ? 'd1 : 'd0;
  servo_2 <= (servo_cnt < {thrd_speed_2, 2'b0}) ? 'd1 : 'd0;
  servo_3 <= (servo_cnt < {thrd_speed_3, 2'b0}) ? 'd1 : 'd0;
  servo_4 <= (servo_cnt < {RESET_SERVO , 2'b0}) ? 'd1 : 'd0;
end

always @(posedge clk_4mhz)
begin
  if (curr_state==IDLE)
  begin
    servo_cnt <= TOTOL_TIME*4/2;
  end
  else if (servo_enough)
  begin
    servo_cnt <= 'd0;
  end
  else
  begin
    servo_cnt <= servo_cnt + 'd1;
  end
end

always @(posedge clk_4mhz)
begin
  servo_enough <= (servo_cnt == (TOTOL_TIME*4-2)) ? 'd1 : 'd0;
end

always @(posedge clk_4mhz)
begin
  if (curr_state==IDLE)
  begin
    real_speed_1 <= RESET_SERVO;
  end
  else if ((servo_enough) && ((curr_speed_1<MIN_SERVO) || (curr_speed_1[WID_16-1])))
  begin
    real_speed_1 <= MIN_SERVO;
  end
  else if ((servo_enough) && (curr_speed_1>MAX_SERVO))
  begin
    real_speed_1 <= MAX_SERVO;
  end
  else if (servo_enough)
  begin
    real_speed_1 <= curr_speed_1 + SERVO1_BIAS;
  end
  else
  begin
    real_speed_1 <= real_speed_1;
  end
end

always @(posedge clk_4mhz)
begin
  if (curr_state==IDLE)
  begin
    real_speed_2 <= RESET_SERVO;
  end
  else if ((servo_enough) && ((curr_speed_2<MIN_SERVO) || (curr_speed_2[WID_16-1])))
  begin
    real_speed_2 <= MIN_SERVO;
  end
  else if ((servo_enough) && (curr_speed_2>MAX_SERVO))
  begin
    real_speed_2 <= MAX_SERVO;
  end
  else if (servo_enough)
  begin
    real_speed_2 <= curr_speed_2 + SERVO2_BIAS;
  end
  else
  begin
    real_speed_2 <= real_speed_2;
  end
end

always @(posedge clk_4mhz)
begin
  if (curr_state==IDLE)
  begin
    real_speed_3 <= RESET_SERVO;
  end
  else if ((servo_enough) && ((curr_speed_3<MIN_SERVO) || (curr_speed_3[WID_16-1])))
  begin
    real_speed_3 <= MIN_SERVO;
  end
  else if ((servo_enough) && (curr_speed_3>MAX_SERVO))
  begin
    real_speed_3 <= MAX_SERVO;
  end
  else if (servo_enough)
  begin
    real_speed_3 <= curr_speed_3 + SERVO3_BIAS;
  end
  else
  begin
    real_speed_3 <= real_speed_3;
  end
end

//******************************************************************
//****************************** FSM *******************************
//******************************************************************
always @(posedge clk_4mhz)
begin
  if (curr_state_d4==IDLE)
  begin
    curr_speed_1 <= RESET_SERVO;
    curr_speed_2 <= RESET_SERVO;
    curr_speed_3 <= RESET_SERVO;
  end
  else if (curr_state_d4==MOVE_UNI)
  begin
    curr_speed_1 <= next_speed_1;
    curr_speed_2 <= next_speed_2;
    curr_speed_3 <= next_speed_3;
  end
  else if (curr_state_d4==SPEED_INC)
  begin
    curr_speed_1 <= last_speed_1 + inc_speed_1[23:8] + inc_speed_1[7];
    curr_speed_2 <= last_speed_2 + inc_speed_2[23:8] + inc_speed_2[7];
    curr_speed_3 <= last_speed_3 + inc_speed_3[23:8] + inc_speed_3[7];
  end
  else
  begin
    curr_speed_1 <= curr_speed_1;
    curr_speed_2 <= curr_speed_2;
    curr_speed_3 <= curr_speed_3;
  end
end

always @(posedge clk_4mhz)
begin
  if (curr_state_d4==IDLE)
  begin
    diff_speed_1 <= RESET_SERVO;
    diff_speed_2 <= RESET_SERVO;
    diff_speed_3 <= RESET_SERVO;
    next_speed_1 <= RESET_SERVO;
    next_speed_2 <= RESET_SERVO;
    next_speed_3 <= RESET_SERVO;
    last_speed_1 <= RESET_SERVO;
    last_speed_2 <= RESET_SERVO;
    last_speed_3 <= RESET_SERVO;
    time_limit   <= 'd0;
    time_small   <= 'd0;
  end
  else if (curr_state_d4==CAL_DIFF)
  begin
    diff_speed_1 <= dout_fifo[47:32] - curr_speed_1;
    diff_speed_2 <= dout_fifo[31:16] - curr_speed_2;
    diff_speed_3 <= dout_fifo[15: 0] - curr_speed_3;
    next_speed_1 <= dout_fifo[47:32];
    next_speed_2 <= dout_fifo[31:16];
    next_speed_3 <= dout_fifo[15: 0];
    last_speed_1 <= next_speed_1;
    last_speed_2 <= next_speed_2;
    last_speed_3 <= next_speed_3;
    time_limit   <= dout_fifo[63:48];
    time_small   <=((dout_fifo[63:48]<='d20) || (dout_fifo[63]=='d1)) ? 'd1 : 'd0;
  end
  else
  begin
    diff_speed_1 <= diff_speed_1;
    diff_speed_2 <= diff_speed_2;
    diff_speed_3 <= diff_speed_3;
    next_speed_1 <= next_speed_1;
    next_speed_2 <= next_speed_2;
    next_speed_3 <= next_speed_3;
    last_speed_1 <= last_speed_1;
    last_speed_2 <= last_speed_2;
    last_speed_3 <= last_speed_3;
    time_limit   <= time_limit;
    time_small   <= 'd0;
  end
end

always @(posedge clk_4mhz)
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

always @(posedge clk_4mhz)
begin
  if (curr_state==SPEED_INC)
  begin
    if (ms_enough)
    begin
      ms_cnt <= 'd0;
    end
    else
    begin
      ms_cnt <= ms_cnt + 'd1;
    end
  end
  else
  begin
    ms_cnt <= 'd0;
  end
end

always @(posedge clk_4mhz)
begin
  if (curr_state==SPEED_INC)
  begin
    sin_addr <= sin_addr + ms_enough;
  end
  else
  begin
    sin_addr <= 'd0;
  end
end

always @(posedge clk_4mhz)
begin
  idle_enough <=  (idle_cnt   == IDLE_MAX    -2) ? 'd1 : 'd0;
  ms_enough   <=  (ms_cnt     ==({time_limit,2'b0}-2)) ? 'd1 : 'd0;
  sin_enough  <=  (sin_addr   == SIN_ADDR_MAX-1) ? 'd1 : 'd0;
  rd_fifo     <= ((curr_state == WAIT_NEMPTY) && (empty_fifo_d2=='d0)) ? 'd1 : 'd0;
end

always @(posedge clk_4mhz)
begin
  if (rst_4mhz)
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
      next_state = (empty_fifo_d2=='d0) ? CAL_DIFF : WAIT_NEMPTY;
    end
    CAL_DIFF :
    begin
      next_state = SPEED_INC;
    end
    SPEED_INC :
    begin
      next_state = (time_small || (sin_enough && ms_enough)) ? MOVE_UNI : SPEED_INC;
    end
    MOVE_UNI :
    begin
      next_state = WAIT_NEMPTY;
    end
    default :
    begin
      next_state = IDLE;
    end
  endcase
end

always @(posedge clk_4mhz)
begin
  empty_fifo_d1 <= empty_fifo;
  empty_fifo_d2 <= empty_fifo_d1;
  curr_state_d1 <= curr_state;
  curr_state_d2 <= curr_state_d1;
  curr_state_d3 <= curr_state_d2;
  curr_state_d4 <= curr_state_d3;
end

sin_rom_9bit
sin_rom_inst1
(
  .doa                     (dout_sin               ), // output wire [8 : 0] douta
  .addra                   (sin_addr[9:0]          ), // input wire [9 : 0] addra
  .clka                    (clk_4mhz               ),
  .rsta                    (rst_4mhz               )
);

mult_16_9bit_signed
mult_inst1
(
  .p                       (inc_speed_1            ), // output wire [24 : 0] P
  .a                       (diff_speed_1           ), // input wire [15 : 0] A
  .b                       (dout_sin               ), // input wire [8 : 0] B
  .cea                     ('d1                    ),
  .ceb                     ('d1                    ),
  .cepd                    ('d1                    ),
  .clk                     (clk_4mhz               ),
  .rstan                   ('d1                    ),
  .rstbn                   ('d1                    ),
  .rstpdn                  ('d1                    )
);

mult_16_9bit_signed
mult_inst2
(
  .p                       (inc_speed_2            ), // output wire [24 : 0] P
  .a                       (diff_speed_2           ), // input wire [15 : 0] A
  .b                       (dout_sin               ), // input wire [8 : 0] B
  .cea                     ('d1                    ),
  .ceb                     ('d1                    ),
  .cepd                    ('d1                    ),
  .clk                     (clk_4mhz               ),
  .rstan                   ('d1                    ),
  .rstbn                   ('d1                    ),
  .rstpdn                  ('d1                    )
);

mult_16_9bit_signed
mult_inst3
(
  .p                       (inc_speed_3            ), // output wire [24 : 0] P
  .a                       (diff_speed_3           ), // input wire [15 : 0] A
  .b                       (dout_sin               ), // input wire [8 : 0] B
  .cea                     ('d1                    ),
  .ceb                     ('d1                    ),
  .cepd                    ('d1                    ),
  .clk                     (clk_4mhz               ),
  .rstan                   ('d1                    ),
  .rstbn                   ('d1                    ),
  .rstpdn                  ('d1                    )
);

//******************************************************************
//****************************** FIFO ******************************
//******************************************************************
always @(posedge clk)
begin
  wr_fifo  <= cmd_in_vld;
  din_fifo <= {cmd_in_data0, cmd_in_data1, cmd_in_data2, cmd_in_data3};
end

servo_cmd_fifo_64bit
servo_cmd_fifo_inst1
(
  .rst                     (rst                    ),
  .di                      (din_fifo               ), // input wire [63 : 0] din
  .clkw                    (clk                    ),
  .we                      (wr_fifo                ), // input wire wr_en
  .do                      (dout_fifo              ), // output wire [63 : 0] dout
  .clkr                    (clk_4mhz               ),
  .re                      (rd_fifo                ), // input wire rd_en
  .empty_flag              (empty_fifo             ), // output wire empty
  .full_flag               (full_fifo              )  // output wire full
);

endmodule
