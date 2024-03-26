`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: gcode_analysis
// Project Name: caotai_v1_0
// Description: 
//   1.Suport G-CODE type: G0X, G1X, G2X.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/26 19:29:20
// 
//////////////////////////////////////////////////////////////////////////////////


module gcode_analysis
#(
  parameter                           WID_8          =   8 ,
  parameter                           WID_16         =  16
)
(
  input                               clk                  ,
  input                               rst                  ,
  input      [WID_8             -1:0] data_spi             ,
  input                               data_spi_vld         ,
  // cmd out
  output reg [WID_16            -1:0] cmd_err_num    = 'd0 ,
  output reg                          cmd_end_flag   = 'd0 ,
  output reg                          cmd_out_vld    = 'd0 ,
  output reg [WID_8             -1:0] cmd_out_type   = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data0  = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data1  = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data2  = 'd0 ,
  output reg [WID_16            -1:0] cmd_out_data3  = 'd0
);


localparam                            WID_24         =  24 ;
reg          [WID_8             -1:0] space_cnt      = 'd0 ;
reg          [WID_8             -1:0] data_spi_s0    = 'd0 ; // last data_spi
reg                                   dot_enable     = 'd0 ;
reg          [WID_8             -1:0] dot_cnt        = 'd0 ;
reg          [WID_24            -1:0] cmd_type       = 'd0 ; // 3byte ascii
reg          [WID_24            -1:0] cmd_data0      = 'd0 ; // =ori
reg          [WID_24            -1:0] cmd_data1      = 'd0 ; // =ori*10^(data1_dot)
reg          [WID_24            -1:0] cmd_data2      = 'd0 ;
reg          [WID_24            -1:0] cmd_data3      = 'd0 ;
reg          [WID_24            -1:0] cmd_data1_1024 = 'd0 ; // =ori*1024
reg          [WID_24            -1:0] cmd_data2_1024 = 'd0 ;
reg          [WID_24            -1:0] cmd_data3_1024 = 'd0 ;

reg          [WID_24            -1:0] data1_1_024    = 'd0 ; // =ori*1.024
reg          [WID_24            -1:0] data2_1_024    = 'd0 ;
reg          [WID_24            -1:0] data3_1_024    = 'd0 ;
reg          [WID_24            -1:0] data1_10_24    = 'd0 ; // =ori*1.024
reg          [WID_24            -1:0] data2_10_24    = 'd0 ;
reg          [WID_24            -1:0] data3_10_24    = 'd0 ;
reg          [WID_24            -1:0] data1_100      = 'd0 ; // =ori*1.024
reg          [WID_24            -1:0] data2_100      = 'd0 ;
reg          [WID_24            -1:0] data3_100      = 'd0 ;


reg          [WID_8             -1:0] data1_dot      = 'd0 ;
reg          [WID_8             -1:0] data2_dot      = 'd0 ;
reg          [WID_8             -1:0] data3_dot      = 'd0 ;
reg                                   data1_sign     = 'd0 ;
reg                                   data2_sign     = 'd0 ;
reg                                   data3_sign     = 'd0 ;
reg                                   semi_flag      = 'd0 ;
reg                                   innocent       = 'd0 ;
reg                                   cmd_type_err   = 'd0 ;
reg                                   cmd_char_err   = 'd0 ; // illegal characters
reg                                   cmd_end_err    = 'd0 ; // wrong of ";"
// FSM
localparam                            STATE_W        =   3 ;
reg          [STATE_W           -1:0] curr_state     = 'd0 ;
reg          [STATE_W           -1:0] next_state     = 'd0 ;
localparam                            IDLE           =   0 ;
localparam                            RECV           =   1 ;
localparam                            CHECK          =   2 ;
localparam                            SUCCESS        =   3 ;
localparam                            FAIL           =   4 ;


//******************************************************************
//************************** output data ***************************
//******************************************************************
always @(posedge clk)
begin
  if (rst)
  begin
    cmd_err_num <= 'd0;
  end
  else if (curr_state==FAIL)
  begin
    cmd_err_num <= cmd_err_num + 'd1;
  end
  else
  begin
    cmd_err_num <= cmd_err_num;
  end
end

always @(posedge clk)
begin
  cmd_end_flag <= ((curr_state==SUCCESS) || (curr_state==FAIL)) ? 'd1 : 'd0;
end

always @(posedge clk)
begin
  if (curr_state==SUCCESS)
  begin
    cmd_out_vld <= 'd1;
    cmd_out_type[7:4] <= cmd_type[15: 8] - "0";
    if (cmd_type[7:0]>="a" && cmd_type[7:0]<="f")
    begin
      cmd_out_type[3:0] <= cmd_type[7:0] - "a" + 'd10;
    end
    else if (cmd_type[7:0]>="A" && cmd_type[7:0]<="F")
    begin
      cmd_out_type[3:0] <= cmd_type[7:0] - "A" + 'd10;
    end
    else
    begin
      cmd_out_type[3:0] <= cmd_type[3:0];
    end
    cmd_out_data0 <= cmd_data0[15:0];
    cmd_out_data1 <= data1_sign ? (~cmd_data1_1024[18:3]+'d1) : cmd_data1_1024[18:3];
    cmd_out_data2 <= data2_sign ? (~cmd_data2_1024[18:3]+'d1) : cmd_data2_1024[18:3];
    cmd_out_data3 <= data3_sign ? (~cmd_data3_1024[18:3]+'d1) : cmd_data3_1024[18:3];
  end
  else
  begin
    cmd_out_vld <= 'd0;
    cmd_out_type <= 'd0;
    cmd_out_data0 <= 'd0;
    cmd_out_data1 <= 'd0;
    cmd_out_data2 <= 'd0;
    cmd_out_data3 <= 'd0;
  end
end

always @(posedge clk)
begin
  if (data1_dot=='d0)
  begin
    cmd_data1_1024 <= {cmd_data1,10'b0};
  end
  else if (data1_dot=='d1)
  begin
    cmd_data1_1024 <= data1_100 + {cmd_data1,1'b0} + cmd_data1[WID_24-1:1];
  end
  else if (data1_dot=='d2)
  begin
    cmd_data1_1024 <= data1_10_24;
  end
  else
  begin
    cmd_data1_1024 <= data1_1_024;
  end
end

always @(posedge clk)
begin
  if (data2_dot=='d0)
  begin
    cmd_data2_1024 <= {cmd_data2,10'b0};
  end
  else if (data2_dot=='d1)
  begin
    cmd_data2_1024 <= data2_100 + {cmd_data2,1'b0} + cmd_data2[WID_24-1:1];
  end
  else if (data2_dot=='d2)
  begin
    cmd_data2_1024 <= data2_10_24;
  end
  else
  begin
    cmd_data2_1024 <= data2_1_024;
  end
end

always @(posedge clk)
begin
  if (data3_dot=='d0)
  begin
    cmd_data3_1024 <= {cmd_data3,10'b0}; // *1024
  end
  else if (data3_dot=='d1)
  begin
    cmd_data3_1024 <= data3_100 + {cmd_data3,1'b0} + cmd_data3[WID_24-1:1]; // *102.5
  end
  else if (data3_dot=='d2)
  begin
    cmd_data3_1024 <= data3_10_24; // *10.25
  end
  else
  begin
    cmd_data3_1024 <= data3_1_024; // *1.0234375
  end
end

always @(posedge clk)
begin
  data1_1_024 <= cmd_data1 + cmd_data1[WID_24-1:6] + cmd_data1[WID_24-1:7];
  data2_1_024 <= cmd_data2 + cmd_data2[WID_24-1:6] + cmd_data2[WID_24-1:7];
  data3_1_024 <= cmd_data3 + cmd_data3[WID_24-1:6] + cmd_data3[WID_24-1:7];
  data1_10_24 <= {cmd_data1, 3'b0} + {cmd_data1,1'b0} + cmd_data1[WID_24-1:2];
  data2_10_24 <= {cmd_data2, 3'b0} + {cmd_data2,1'b0} + cmd_data2[WID_24-1:2];
  data3_10_24 <= {cmd_data3, 3'b0} + {cmd_data3,1'b0} + cmd_data3[WID_24-1:2];
  data1_100   <= {cmd_data1, 6'b0} + {cmd_data1,5'b0} + {cmd_data1,2'b0};
  data2_100   <= {cmd_data2, 6'b0} + {cmd_data2,5'b0} + {cmd_data2,2'b0};
  data3_100   <= {cmd_data3, 6'b0} + {cmd_data3,5'b0} + {cmd_data3,2'b0};
end

//******************************************************************
//************************** input cache ***************************
//******************************************************************
always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    semi_flag <= 'd0;
  end
  else if ((curr_state==RECV) && (data_spi_vld=='d1) && (data_spi==";"))
  begin
    semi_flag <= 'd1;
  end
  else
  begin
    semi_flag <= semi_flag;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    innocent <= 'd1;
  end
  else if (data_spi_vld=='d1)
  begin
    if ((data_spi>="0") && (data_spi<="9"))
    begin
      innocent <= 'd0;
    end
    else if ((data_spi>="a") && (data_spi<="z"))
    begin
      innocent <= 'd0;
    end
    else if ((data_spi>="A") && (data_spi<="Z"))
    begin
      innocent <= 'd0;
    end
    else
    begin
      innocent <= innocent;
    end
  end
  else
  begin
    innocent <= innocent;
  end
end

always @(posedge clk)
begin
  if (((cmd_type[23:16]=="G") || (cmd_type[23:16]=="g")) &&
      ((cmd_type[15: 8]=="0") || (cmd_type[15: 8]=="1") || (cmd_type[15: 8]=="2")))
  begin
    cmd_type_err <= 'd0;
  end
  else
  begin
    cmd_type_err <= 'd1;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    cmd_char_err <= 'd0;
  end
  else if ((data_spi_vld=='d1) && (space_cnt!='d0) && ((data_spi<"0") || (data_spi>"9")) &&
           (data_spi!=" ") && (data_spi!=";") && (data_spi!=".") && (data_spi!="-") && (data_spi!=8'h0d) && (data_spi!=8'h0a))
  begin
    cmd_char_err <= 'd1;
  end
  else
  begin
    cmd_char_err <= cmd_char_err;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    cmd_end_err <= 'd1;
  end
  else if ((curr_state==RECV) && (data_spi_vld=='d1) && (data_spi==";") && (space_cnt<4))
  begin
    cmd_end_err <= 'd1;
  end
  else if ((curr_state==RECV) && (data_spi_vld=='d1) && (data_spi==";"))
  begin
    cmd_end_err <= 'd0;
  end
  else
  begin
    cmd_end_err <= cmd_end_err;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    cmd_type <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d0) && (data_spi_vld=='d1) && (data_spi!=" "))
  begin
    cmd_type <= {cmd_type[WID_24-WID_8-1:0], data_spi};
  end
  else
  begin
    cmd_type <= cmd_type;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    cmd_data0 <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d1) && (data_spi_vld=='d1))
  begin
    if ((data_spi<"0") || (data_spi>"9"))
    begin
      cmd_data0 <=  cmd_data0;
    end
    else if (dot_enable=='d0)
    begin
      cmd_data0 <= {cmd_data0,3'b0} + {cmd_data0,1'b0} + data_spi[3:0];
    end
    else
    begin
      cmd_data0 <=  cmd_data0;
    end
  end
  else
  begin
    cmd_data0 <= cmd_data0;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    cmd_data1 <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d2) && (data_spi_vld=='d1))
  begin
    if ((data_spi<"0") || (data_spi>"9"))
    begin
      cmd_data1 <=  cmd_data1;
    end
    else if (dot_cnt<='d2) // 0,1,2
    begin
      cmd_data1 <= {cmd_data1,3'b0} + {cmd_data1,1'b0} + data_spi[3:0];
    end
    else
    begin
      cmd_data1 <=  cmd_data1;
    end
  end
  else
  begin
    cmd_data1 <= cmd_data1;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    cmd_data2 <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d3) && (data_spi_vld=='d1))
  begin
    if ((data_spi<"0") || (data_spi>"9"))
    begin
      cmd_data2 <=  cmd_data2;
    end
    else if (dot_cnt<='d2) // 0,1,2
    begin
      cmd_data2 <= {cmd_data2,3'b0} + {cmd_data2,1'b0} + data_spi[3:0];
    end
    else
    begin
      cmd_data2 <=  cmd_data2;
    end
  end
  else
  begin
    cmd_data2 <= cmd_data2;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    cmd_data3 <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d4) && (data_spi_vld=='d1))
  begin
    if ((data_spi<"0") || (data_spi>"9"))
    begin
      cmd_data3 <=  cmd_data3;
    end
    else if (dot_cnt<='d2) // 0,1,2
    begin
      cmd_data3 <= {cmd_data3,3'b0} + {cmd_data3,1'b0} + data_spi[3:0];
    end
    else
    begin
      cmd_data3 <=  cmd_data3;
    end
  end
  else
  begin
    cmd_data3 <= cmd_data3;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    data1_dot <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d2) && (data_spi_vld=='d1))
  begin
    if (((data_spi<"0") || (data_spi>"9")) && (data_spi!=".") && (data_spi!="-"))
    begin
      data1_dot <= dot_cnt;
    end
    else
    begin
      data1_dot <= data1_dot;
    end
  end
  else
  begin
    data1_dot <= data1_dot;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    data2_dot <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d3) && (data_spi_vld=='d1))
  begin
    if (((data_spi<"0") || (data_spi>"9")) && (data_spi!=".") && (data_spi!="-"))
    begin
      data2_dot <= dot_cnt;
    end
    else
    begin
      data2_dot <= data2_dot;
    end
  end
  else
  begin
    data2_dot <= data2_dot;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    data3_dot <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d4) && (data_spi_vld=='d1))
  begin
    if (((data_spi<"0") || (data_spi>"9")) && (data_spi!=".") && (data_spi!="-"))
    begin
      data3_dot <= dot_cnt;
    end
    else
    begin
      data3_dot <= data3_dot;
    end
  end
  else
  begin
    data3_dot <= data3_dot;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    data1_sign <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d2) && (data_spi_vld=='d1) && (data_spi=="-"))
  begin
    data1_sign <= 'd1;
  end
  else
  begin
    data1_sign <= data1_sign;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    data2_sign <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d3) && (data_spi_vld=='d1) && (data_spi=="-"))
  begin
    data2_sign <= 'd1;
  end
  else
  begin
    data2_sign <= data2_sign;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    data3_sign <= 'd0;
  end
  else if ((curr_state==RECV) && (space_cnt=='d4) && (data_spi_vld=='d1) && (data_spi=="-"))
  begin
    data3_sign <= 'd1;
  end
  else
  begin
    data3_sign <= data3_sign;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    space_cnt <= 'd0;
  end
  else if ((curr_state==RECV) && (data_spi_vld=='d1) && (data_spi==" ") && (data_spi_s0!=" "))
  begin
    space_cnt <= space_cnt + 'd1;
  end
  else
  begin
    space_cnt <= space_cnt;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) || (curr_state==SUCCESS) || (curr_state==FAIL))
  begin
    data_spi_s0 <= " ";
  end
  else if ((data_spi_vld=='d1) && (data_spi!='h0d) && (data_spi!='h0a))
  begin
    data_spi_s0 <= data_spi;
  end
  else
  begin
    data_spi_s0 <= data_spi_s0;
  end
end

always @(posedge clk)
begin
  if (space_cnt=='d0)
  begin
    dot_enable <= 'd0;
  end
  else if ((data_spi_vld=='d1) && (data_spi==" "))
  begin
    dot_enable <= 'd0;
  end
  else if ((data_spi_vld=='d1) && (data_spi=="."))
  begin
    dot_enable <= 'd1;
  end
  else
  begin
    dot_enable <= dot_enable;
  end
end

always @(posedge clk)
begin
  if (dot_enable=='d0)
  begin
    dot_cnt <= 'd0;
  end
  else if ((data_spi_vld) && (data_spi>="0") && (data_spi<="9"))
  begin
    dot_cnt <= dot_cnt + 'd1;
  end
  else
  begin
    dot_cnt <= dot_cnt;
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
      next_state = RECV;
    end
    RECV :
    begin
      next_state = semi_flag ? CHECK : RECV;
    end
    CHECK :
    begin
      next_state = innocent ? IDLE : ((cmd_char_err || cmd_type_err || cmd_end_err) ? FAIL : SUCCESS);
    end
    SUCCESS :
    begin
      next_state = RECV;
    end
    FAIL :
    begin
      next_state = RECV;
    end
    default :
    begin
      next_state = IDLE;
    end
  endcase
end

endmodule
