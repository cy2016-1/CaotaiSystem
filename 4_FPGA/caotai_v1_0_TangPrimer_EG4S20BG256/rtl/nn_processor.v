`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: nn_processor
// Project Name: caotai_v1_0
// Description: 
//   1.This module starts different neural network computations by setting req_type to 1 or 2.
//   2.If you want to modify the depth of model 1, you need to modify the value of localparam NN_TYPE1_DEP.
//   3.If you want to modify the number of neurons per layer, you need to modify the other localparam values defined next.
//   4.If you want to add a new neural network, you need to add code at the place with the comment "add more net here".
//   5.Remember to modify the corresponding parameters whenever you modify the neural network.
//       The parameters of the neural network are stored in the para_rom IP core, 
//       and you can modify the model parameters by modifying the initialization file.
//   6.The multiplier in process_element has a delay of 2 clk, 
//       and the addition calculation takes 1 clk. Therefore, 
//       the output of this submodule is delayed by 3 clk relative to the input.
//   7.The delay from para_addr to para_data is 2 clk. The delay from fm_rd_addr to fm_rd_data is 2 clk.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/19 18:52:00
// 
//////////////////////////////////////////////////////////////////////////////////


module nn_processor
#(
  parameter                           WID_16         =  16 ,
  parameter                           WID_8          =   8
)
(
  input                               clk                  ,
  input                               rst                  ,
  input                               nnp_req              ,
  output reg                          nnp_ack        = 'd0 ,
  input      [WID_8             -1:0] nnp_type             ,
  input      [WID_16            -1:0] data_in1             ,
  input      [WID_16            -1:0] data_in2             ,
  input      [WID_16            -1:0] data_in3             ,
  output reg                          nnp_vld        = 'd0 ,
  output reg [WID_16            -1:0] data_out1      = 'd0 ,
  output reg [WID_16            -1:0] data_out2      = 'd0 ,
  output reg [WID_16            -1:0] data_out3      = 'd0
);


// other
reg          [WID_8             -1:0] type_lock      = 'd0 ;
reg          [WID_16            -1:0] data_in1_lock  = 'd0 ;
reg          [WID_16            -1:0] data_in2_lock  = 'd0 ;
reg          [WID_16            -1:0] data_in3_lock  = 'd0 ;
reg                                   nnp_req_work   = 'd0 ;
// nn para
localparam                            PE_NUM         =  16 ;
localparam                            NN_TYPE1       =   1 ;
localparam                            NN_TYPE1_DEP   =   3 ;
localparam                            NN_TYPE1_ADDR  =   0 ;
localparam                            FIN_LEN_01_01  =   2 ;
localparam                            FIN_LEN_01_02  =  64 ;
localparam                            FIN_LEN_01_03  =  64 ;
localparam                            FOUT_LEN_01    =   2 ;
localparam                            NN_TYPE2       =   2 ;
localparam                            NN_TYPE2_DEP   =   4 ;
localparam                            NN_TYPE2_ADDR  = 173 ;
localparam                            FIN_LEN_02_01  =   3 ;
localparam                            FIN_LEN_02_02  =  64 ;
localparam                            FIN_LEN_02_03  =  64 ;
localparam                            FIN_LEN_02_04  =  64 ;
localparam                            FOUT_LEN_02    =   3 ;
localparam                            ADDR_W         =   9 ;
localparam                            LAYER_W        =   3 ;
reg          [ADDR_W            -1:0] wnum_remain    = 'd0 ;
reg                                   wnum_enough    = 'd0 ; // sum(rnum) = FIN_LEN, use for switch layer
reg          [ADDR_W            -1:0] rnum           = 'd0 ;
reg                                   rnum_eq2       = 'd0 ; // rnum = 2
reg          [ADDR_W            -1:0] coff_cnt       = 'd0 ;
reg                                   coff_enough    = 'd0 ; // coff_cnt = rnum - 2
reg          [LAYER_W           -1:0] layer_cnt      = 'd0 ;
reg                                   layer_enough   = 'd0 ; 
reg          [ADDR_W            -1:0] para_addr      = 'd0 ;
// FSM
localparam                            STATE_W        =   2 ;
reg          [STATE_W           -1:0] curr_state     = 'd0 ;
reg          [STATE_W           -1:0] next_state     = 'd0 ;
localparam                            IDLE           =   0 ;
localparam                            BIAS           =   1 ;
localparam                            COFF           =   2 ;
localparam                            END            =   3 ;
// fmap buffer
localparam                            FM_WD_AW       =   4 ;
localparam                            FM_RD_AW       =   7 ;
reg                                   pp_rd_flag     = 'd0 ;
reg                                   pp_wr_flag     = 'd0 ;
wire    [WID_16*PE_NUM          -1:0] nout_data            ;
reg     [WID_16*PE_NUM          -1:0] fm_wr_data     = 'd0 ;
reg     [FM_WD_AW               -1:0] fm_wr_addr     = 'd0 ;
reg                                   fm_wr_en       = 'd0 ;
reg     [FM_RD_AW               -1:0] fm_rd_addr     = 'd0 ;
reg     [WID_16*2               -1:0] fm_rd_data     = 'd0 ;
reg     [WID_16                 -1:0] fmap_in1       = 'd0 ;
reg     [WID_16                 -1:0] fmap_in2       = 'd0 ;
reg     [ADDR_W                 -1:0] coff_cnt_d1    = 'd0 ;
reg     [STATE_W                -1:0] curr_state_d1  = 'd0 ;
reg     [STATE_W                -1:0] curr_state_d2  = 'd0 ;
reg     [STATE_W                -1:0] curr_state_d3  = 'd0 ;
reg     [STATE_W                -1:0] curr_state_d4  = 'd0 ;
reg     [LAYER_W                -1:0] layer_cnt_d1   = 'd0 ;
reg                                   coff_end       = 'd0 ;
reg                                   coff_end_d1    = 'd0 ;
reg                                   coff_end_d2    = 'd0 ;
reg                                   coff_end_d3    = 'd0 ;
reg                                   coff_end_d4    = 'd0 ;
reg                                   layer_end      = 'd0 ;
reg                                   layer_end_d1   = 'd0 ;
reg                                   layer_end_d2   = 'd0 ;
reg                                   layer_end_d3   = 'd0 ;
reg                                   layer_end_d4   = 'd0 ;
reg                                   layer_end_d5   = 'd0 ;
// PE & para buffer
localparam                            COFF_W         =  16 ;
localparam                            NNIN_W         =  16 ;
localparam                            NOUT_W         =  COFF_W + NNIN_W;
wire    [PE_NUM*2*WID_16        -1:0] para_data            ;
reg                                   rd_bias_d1     = 'd0 ;
reg                                   rd_coff_d1     = 'd0 ;
reg                                   rd_bias_d2     = 'd0 ;
reg                                   rd_coff_d2     = 'd0 ;


//******************************************************************
//****************************** FSM *******************************
//******************************************************************
always @(posedge clk)
begin
  if ((curr_state==IDLE) && (nnp_req=='d1))
  begin
    nnp_req_work <= ((nnp_type=='d1) || (nnp_type=='d2));
    type_lock <= nnp_type;
    data_in1_lock <= data_in1;
    data_in2_lock <= data_in2;
    data_in3_lock <= data_in3;
  end
  else if (curr_state==IDLE)
  begin
    nnp_req_work <= 'd0;
    type_lock <= 'd0;
    data_in1_lock <= 'd0;
    data_in2_lock <= 'd0;
    data_in3_lock <= 'd0;
  end
  else
  begin
    nnp_req_work <= 'd0;
    type_lock <= type_lock;
    data_in1_lock <= data_in1_lock;
    data_in2_lock <= data_in2_lock;
    data_in3_lock <= data_in3_lock;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) && (nnp_req_work=='d1) && (type_lock=='d1))
  begin
    para_addr <= NN_TYPE1_ADDR;
  end
  else if ((curr_state==IDLE) && (nnp_req_work=='d1) && (type_lock=='d2))
  begin
    para_addr <= NN_TYPE2_ADDR;
  end // add more net here
  else if ((curr_state==BIAS) || (curr_state==COFF))
  begin
    para_addr <= para_addr + 'd1;
  end
  else
  begin
    para_addr <= 'd0;
  end
end

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
  case(curr_state)
    IDLE :
    begin
      next_state = nnp_req_work ? BIAS : IDLE;
    end
    BIAS :
    begin
      next_state = COFF;
    end
    COFF :
    begin
      next_state = (rnum_eq2 || coff_enough) ? (layer_enough ? END : BIAS) : COFF;
    end
    END :
    begin
      next_state = IDLE;
    end
    default :
    begin
      next_state = IDLE;
    end
  endcase
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) && (nnp_req_work=='d1))
  begin
    nnp_ack <= 'd1;
  end
  else
  begin
    nnp_ack <= 'd0;
  end
end

always @(posedge clk)
begin
  if ((curr_state==IDLE) && (nnp_req_work=='d1))
  begin
    if (type_lock==NN_TYPE1)
    begin
      wnum_remain <= FIN_LEN_01_02;
    end
    else if (type_lock==NN_TYPE2)
    begin
      wnum_remain <= FIN_LEN_02_02;
    end // add more net here
    else
    begin
      wnum_remain <= 'd0;
    end
  end
  else if ((curr_state==COFF) && ((rnum_eq2 || coff_enough)=='d1) && (wnum_enough=='d1))
  begin
    if ((type_lock==NN_TYPE1) && (layer_cnt=='d0))
    begin
      wnum_remain <= FIN_LEN_01_03;
    end
    else if ((type_lock==NN_TYPE1) && (layer_cnt=='d1))
    begin
      wnum_remain <= FOUT_LEN_01;
    end
    else if ((type_lock==NN_TYPE2) && (layer_cnt=='d0))
    begin
      wnum_remain <= FIN_LEN_02_03;
    end
    else if ((type_lock==NN_TYPE2) && (layer_cnt=='d1))
    begin
      wnum_remain <= FIN_LEN_02_04;
    end
    else if ((type_lock==NN_TYPE2) && (layer_cnt=='d2))
    begin
      wnum_remain <= FOUT_LEN_02;
    end // add more net here
    else
    begin
      wnum_remain <= 'd0;
    end
  end
  else if ((curr_state==BIAS) && (wnum_remain>PE_NUM))
  begin
    wnum_remain <= wnum_remain - PE_NUM;
  end
  else if ((curr_state==BIAS) && (wnum_remain<=PE_NUM))
  begin
    wnum_remain <= 'd0;
  end
  else if (curr_state==IDLE)
  begin
    wnum_remain <= 'd0;
  end
  else
  begin
    wnum_remain <= wnum_remain;
  end
end

always @(posedge clk)
begin
  if (curr_state==IDLE)
  begin
    wnum_enough <= 'd0;
  end
  else if ((curr_state==BIAS) && (wnum_remain>PE_NUM))
  begin
    wnum_enough <= 'd0;
  end
  else if ((curr_state==BIAS) && (wnum_remain<=PE_NUM))
  begin
    wnum_enough <= 'd1;
  end
  else
  begin
    wnum_enough <= wnum_enough;
  end
end

always @(posedge clk)
begin
  if (curr_state==IDLE)
  begin
    rnum <= 'd0;
    rnum_eq2 <= 'd0;
  end
  else if (curr_state==BIAS)
  begin
    if ((type_lock==NN_TYPE1) && (layer_cnt=='d0))
    begin
      rnum <= FIN_LEN_01_01;
      rnum_eq2 <= (FIN_LEN_01_01)==2 ? 'd1 : 'd0;
    end
    else if ((type_lock==NN_TYPE1) && (layer_cnt=='d1))
    begin
      rnum <= FIN_LEN_01_02;
      rnum_eq2 <= (FIN_LEN_01_02)==2 ? 'd1 : 'd0;
    end
    else if ((type_lock==NN_TYPE1) && (layer_cnt=='d2))
    begin
      rnum <= FIN_LEN_01_03;
      rnum_eq2 <= (FIN_LEN_01_03)==2 ? 'd1 : 'd0;
    end
    else if ((type_lock==NN_TYPE2) && (layer_cnt=='d0))
    begin
      rnum <= FIN_LEN_02_01;
      rnum_eq2 <= (FIN_LEN_02_01)==2 ? 'd1 : 'd0;
    end
    else if ((type_lock==NN_TYPE2) && (layer_cnt=='d1))
    begin
      rnum <= FIN_LEN_02_02;
      rnum_eq2 <= (FIN_LEN_02_02)==2 ? 'd1 : 'd0;
    end
    else if ((type_lock==NN_TYPE2) && (layer_cnt=='d2))
    begin
      rnum <= FIN_LEN_02_03;
      rnum_eq2 <= (FIN_LEN_02_03)==2 ? 'd1 : 'd0;
    end
    else if ((type_lock==NN_TYPE2) && (layer_cnt=='d3))
    begin
      rnum <= FIN_LEN_02_04;
      rnum_eq2 <= (FIN_LEN_02_04)==2 ? 'd1 : 'd0;
    end // add more net here
    else
    begin
      rnum <= 'd0;
      rnum_eq2 <= 'd0;
    end
  end
  else
  begin
    rnum <= rnum;
    rnum_eq2 <= rnum_eq2;
  end
end

always @(posedge clk)
begin
  if (curr_state==COFF)
  begin
    coff_cnt <= coff_cnt + 'd2;
    coff_enough <= ((coff_cnt+4) >= rnum) ? 'd1 : 'd0;
  end
  else
  begin
    coff_cnt <= 'd0;
    coff_enough <= 'd0;
  end
end

always @(posedge clk)
begin
  if (curr_state==IDLE)
  begin
    layer_cnt <= 'd0;
  end
  else if ((curr_state==COFF) && ((rnum_eq2 || coff_enough)=='d1) && (wnum_enough=='d1))
  begin
    layer_cnt <= layer_cnt + 'd1;
  end
  else
  begin
    layer_cnt <= layer_cnt;
  end
end

always @(posedge clk)
begin
  if ((type_lock==NN_TYPE1) && (layer_cnt==NN_TYPE1_DEP-1) && (wnum_enough=='d1))
  begin
    layer_enough <= 'd1;
  end
  else if ((type_lock==NN_TYPE2) && (layer_cnt==NN_TYPE2_DEP-1) && (wnum_enough=='d1))
  begin
    layer_enough <= 'd1;
  end // add more net here
  else
  begin
    layer_enough <= 'd0;
  end
end

//******************************************************************
//************************** fmap buffer ***************************
//******************************************************************
always @(posedge clk)
begin
  if (curr_state==IDLE)
  begin
    fm_wr_addr <= 'd0;
    pp_wr_flag <= 'd0;
  end
  else if ( layer_end_d5 && fm_wr_en)
  begin
    fm_wr_addr <= 'd0;
    pp_wr_flag <= ~pp_wr_flag;
  end
  else if (~layer_end_d5 && fm_wr_en)
  begin
    fm_wr_addr <= fm_wr_addr + 'd1;
    pp_wr_flag <=  pp_wr_flag;
  end
  else
  begin
    fm_wr_addr <= fm_wr_addr;
    pp_wr_flag <=  pp_wr_flag;
  end
end

always @(posedge clk)
begin
  fm_wr_en   <= coff_end_d4;
end

always @(posedge clk)
begin
  nnp_vld     <= (curr_state_d4==END) ? 'd1 : 'd0;
  data_out1   <= nout_data[PE_NUM*1*WID_16-1-WID_16* 0 : PE_NUM*1*WID_16-WID_16-WID_16* 0];
  data_out2   <= nout_data[PE_NUM*1*WID_16-1-WID_16* 1 : PE_NUM*1*WID_16-WID_16-WID_16* 1];
  data_out3   <= nout_data[PE_NUM*1*WID_16-1-WID_16* 2 : PE_NUM*1*WID_16-WID_16-WID_16* 2];
end

always @(posedge clk)
begin
  if ((curr_state==COFF) && ((rnum_eq2 || coff_enough)=='d1))
  begin
    fm_rd_addr <= 'd0;
    pp_rd_flag <= wnum_enough ? (~pp_rd_flag) : pp_rd_flag;
  end
  else if ((curr_state==BIAS) || (curr_state==COFF))
  begin
    fm_rd_addr <= fm_rd_addr + 'd1;
    pp_rd_flag <= pp_rd_flag;
  end
  else
  begin
    fm_rd_addr <= 'd0;
    pp_rd_flag <= 'd1;
  end
end

always @(posedge clk)
begin
  if ((layer_cnt_d1=='d0) && (curr_state_d1==COFF) && (coff_cnt_d1[1:0]=='d0))
  begin
    fmap_in1 <= data_in1_lock;
    fmap_in2 <= data_in2_lock;
  end
  else if ((layer_cnt_d1=='d0) && (curr_state_d1==COFF) && (coff_cnt_d1[1:0]=='d1))
  begin
    fmap_in1 <= data_in3_lock;
    fmap_in2 <= 'd0;
  end
  else
  begin
    fmap_in1 <= fm_rd_data[15] ? 'd0 : fm_rd_data[15: 0];
    fmap_in2 <= fm_rd_data[31] ? 'd0 : fm_rd_data[31:16];
  end
end

wire    [WID_16*PE_NUM          -1:0] dout_dram_s2         ;
reg     [WID_16*PE_NUM          -1:0] dout_dram_s1   = 'd0 ;
reg     [FM_RD_AW               -1:0] fm_rd_addr_d1  = 'd0 ;

always @(posedge clk)
begin
  fm_rd_addr_d1 <= fm_rd_addr;
  dout_dram_s1  <= dout_dram_s2;
end

always @(posedge clk)
begin
  if (fm_rd_addr_d1[2:0]=='d0)
  begin
    fm_rd_data <= dout_dram_s1[ 31:  0];
  end
  else if (fm_rd_addr_d1[2:0]=='d1)
  begin
    fm_rd_data <= dout_dram_s1[ 63: 32];
  end
  else if (fm_rd_addr_d1[2:0]=='d2)
  begin
    fm_rd_data <= dout_dram_s1[ 95: 64];
  end
  else if (fm_rd_addr_d1[2:0]=='d3)
  begin
    fm_rd_data <= dout_dram_s1[127: 96];
  end
  else if (fm_rd_addr_d1[2:0]=='d4)
  begin
    fm_rd_data <= dout_dram_s1[159:128];
  end
  else if (fm_rd_addr_d1[2:0]=='d5)
  begin
    fm_rd_data <= dout_dram_s1[191:160];
  end
  else if (fm_rd_addr_d1[2:0]=='d6)
  begin
    fm_rd_data <= dout_dram_s1[223:192];
  end
  else if (fm_rd_addr_d1[2:0]=='d7)
  begin
    fm_rd_data <= dout_dram_s1[255:224];
  end
  else
  begin
    fm_rd_data <= 'd0;
  end
end

fmap_dram_256bit
fmap_dram_inst1
(
  .di                  (fm_wr_data       ), // input wire [255 : 0] dina
  .waddr               ({pp_wr_flag, fm_wr_addr}), // input wire [4 : 0] addra
  .we                  (fm_wr_en         ), // input wire [0 : 0] wea
  .wclk                (clk              ),
  .do                  (dout_dram_s2     ), // output wire [255 : 0] doutb
  .raddr               ({pp_rd_flag, fm_rd_addr[6:3]}) // input wire [4 : 0] addrb
);

always @(posedge clk)
begin
  coff_cnt_d1   <= coff_cnt[ADDR_W-1:1];
  curr_state_d1 <= curr_state;
  curr_state_d2 <= curr_state_d1;
  curr_state_d3 <= curr_state_d2;
  curr_state_d4 <= curr_state_d3;
  layer_cnt_d1  <= layer_cnt ;
end

always @(posedge clk)
begin
  coff_end     <= ((curr_state==COFF) && ((rnum_eq2 || coff_enough)=='d1)) ? 'd1 : 'd0;
  coff_end_d1  <= coff_end   ;
  coff_end_d2  <= coff_end_d1;
  coff_end_d3  <= coff_end_d2;
  coff_end_d4  <= coff_end_d3;
  layer_end    <= ((curr_state==COFF) && ((rnum_eq2 || coff_enough)=='d1) && (wnum_enough=='d1)) ? 'd1 : 'd0;
  layer_end_d1 <= layer_end   ;
  layer_end_d2 <= layer_end_d1;
  layer_end_d3 <= layer_end_d2;
  layer_end_d4 <= layer_end_d3;
  layer_end_d5 <= layer_end_d4;
end

//******************************************************************
//*************************** PE & para ****************************
//******************************************************************
always @(posedge clk)
begin
  rd_bias_d1 <= (curr_state==BIAS) ? 'd1 : 'd0;
  rd_coff_d1 <= (curr_state==COFF) ? 'd1 : 'd0;
  rd_bias_d2 <= rd_bias_d1;
  rd_coff_d2 <= rd_coff_d1;
end

para_rom_512bit
para_rom_inst1
(
  .doa                 (para_data        ), // output wire [511 : 0] douta
  .addra               (para_addr        ), // input wire [8 : 0] addra
  .clka                (clk              ),
  .rsta                (rst              )
);

generate
begin
  genvar pe_i;
  for (pe_i=0;pe_i<PE_NUM;pe_i=pe_i+1)
  begin : pe
    process_element
    #(
      .COFF_W             (COFF_W          ),
      .NNIN_W             (NNIN_W          ),
      .NOUT_W             (NOUT_W          )
    )
    process_element_inst_pe_i
    (
      .clk                (clk             ),
      .set                (rd_bias_d2      ),
      .bias               (para_data[PE_NUM*2*WID_16-1-WID_16* pe_i : PE_NUM*2*WID_16-WID_16-WID_16* pe_i]),
      .en                 (rd_coff_d2      ),
      .coff1              (para_data[PE_NUM*2*WID_16-1-WID_16* pe_i : PE_NUM*2*WID_16-WID_16-WID_16* pe_i]),
      .nnin1              (fmap_in1        ),
      .coff2              (para_data[PE_NUM*1*WID_16-1-WID_16* pe_i : PE_NUM*1*WID_16-WID_16-WID_16* pe_i]),
      .nnin2              (fmap_in2        ),
      .nnout              (nout_data[PE_NUM*1*WID_16-1-WID_16* pe_i : PE_NUM*1*WID_16-WID_16-WID_16* pe_i])
    );
    
    always @(posedge clk)
    begin
      fm_wr_data[WID_16-1+WID_16* pe_i : WID_16* pe_i] <= nout_data[PE_NUM*1*WID_16-1-WID_16* pe_i : PE_NUM*1*WID_16-WID_16-WID_16* pe_i];
    end

  end
end
endgenerate

//******************************************************************
//***************************** debug ******************************
//******************************************************************
wire [15:0] para_00 = para_data[PE_NUM*2*WID_16-1-WID_16*  0 : PE_NUM*2*WID_16-WID_16-WID_16*  0];
wire [15:0] para_01 = para_data[PE_NUM*2*WID_16-1-WID_16*  1 : PE_NUM*2*WID_16-WID_16-WID_16*  1];
wire [15:0] para_02 = para_data[PE_NUM*2*WID_16-1-WID_16*  2 : PE_NUM*2*WID_16-WID_16-WID_16*  2];
wire [15:0] para_03 = para_data[PE_NUM*2*WID_16-1-WID_16*  3 : PE_NUM*2*WID_16-WID_16-WID_16*  3];
wire [15:0] para_04 = para_data[PE_NUM*2*WID_16-1-WID_16*  4 : PE_NUM*2*WID_16-WID_16-WID_16*  4];
wire [15:0] para_05 = para_data[PE_NUM*2*WID_16-1-WID_16*  5 : PE_NUM*2*WID_16-WID_16-WID_16*  5];
wire [15:0] para_06 = para_data[PE_NUM*2*WID_16-1-WID_16*  6 : PE_NUM*2*WID_16-WID_16-WID_16*  6];
wire [15:0] para_07 = para_data[PE_NUM*2*WID_16-1-WID_16*  7 : PE_NUM*2*WID_16-WID_16-WID_16*  7];
wire [15:0] para_08 = para_data[PE_NUM*2*WID_16-1-WID_16*  8 : PE_NUM*2*WID_16-WID_16-WID_16*  8];
wire [15:0] para_09 = para_data[PE_NUM*2*WID_16-1-WID_16*  9 : PE_NUM*2*WID_16-WID_16-WID_16*  9];
wire [15:0] para_10 = para_data[PE_NUM*2*WID_16-1-WID_16* 10 : PE_NUM*2*WID_16-WID_16-WID_16* 10];
wire [15:0] para_11 = para_data[PE_NUM*2*WID_16-1-WID_16* 11 : PE_NUM*2*WID_16-WID_16-WID_16* 11];
wire [15:0] para_12 = para_data[PE_NUM*2*WID_16-1-WID_16* 12 : PE_NUM*2*WID_16-WID_16-WID_16* 12];
wire [15:0] para_13 = para_data[PE_NUM*2*WID_16-1-WID_16* 13 : PE_NUM*2*WID_16-WID_16-WID_16* 13];
wire [15:0] para_14 = para_data[PE_NUM*2*WID_16-1-WID_16* 14 : PE_NUM*2*WID_16-WID_16-WID_16* 14];
wire [15:0] para_15 = para_data[PE_NUM*2*WID_16-1-WID_16* 15 : PE_NUM*2*WID_16-WID_16-WID_16* 15];
wire [15:0] para_16 = para_data[PE_NUM*2*WID_16-1-WID_16* 16 : PE_NUM*2*WID_16-WID_16-WID_16* 16];
wire [15:0] para_17 = para_data[PE_NUM*2*WID_16-1-WID_16* 17 : PE_NUM*2*WID_16-WID_16-WID_16* 17];
wire [15:0] para_18 = para_data[PE_NUM*2*WID_16-1-WID_16* 18 : PE_NUM*2*WID_16-WID_16-WID_16* 18];
wire [15:0] para_19 = para_data[PE_NUM*2*WID_16-1-WID_16* 19 : PE_NUM*2*WID_16-WID_16-WID_16* 19];
wire [15:0] para_20 = para_data[PE_NUM*2*WID_16-1-WID_16* 20 : PE_NUM*2*WID_16-WID_16-WID_16* 20];
wire [15:0] para_21 = para_data[PE_NUM*2*WID_16-1-WID_16* 21 : PE_NUM*2*WID_16-WID_16-WID_16* 21];
wire [15:0] para_22 = para_data[PE_NUM*2*WID_16-1-WID_16* 22 : PE_NUM*2*WID_16-WID_16-WID_16* 22];
wire [15:0] para_23 = para_data[PE_NUM*2*WID_16-1-WID_16* 23 : PE_NUM*2*WID_16-WID_16-WID_16* 23];
wire [15:0] para_24 = para_data[PE_NUM*2*WID_16-1-WID_16* 24 : PE_NUM*2*WID_16-WID_16-WID_16* 24];
wire [15:0] para_25 = para_data[PE_NUM*2*WID_16-1-WID_16* 25 : PE_NUM*2*WID_16-WID_16-WID_16* 25];
wire [15:0] para_26 = para_data[PE_NUM*2*WID_16-1-WID_16* 26 : PE_NUM*2*WID_16-WID_16-WID_16* 26];
wire [15:0] para_27 = para_data[PE_NUM*2*WID_16-1-WID_16* 27 : PE_NUM*2*WID_16-WID_16-WID_16* 27];
wire [15:0] para_28 = para_data[PE_NUM*2*WID_16-1-WID_16* 28 : PE_NUM*2*WID_16-WID_16-WID_16* 28];
wire [15:0] para_29 = para_data[PE_NUM*2*WID_16-1-WID_16* 29 : PE_NUM*2*WID_16-WID_16-WID_16* 29];
wire [15:0] para_30 = para_data[PE_NUM*2*WID_16-1-WID_16* 30 : PE_NUM*2*WID_16-WID_16-WID_16* 30];
wire [15:0] para_31 = para_data[PE_NUM*2*WID_16-1-WID_16* 31 : PE_NUM*2*WID_16-WID_16-WID_16* 31];

wire [15:0] nout_00 = nout_data[PE_NUM*1*WID_16-1-WID_16*  0 : PE_NUM*1*WID_16-WID_16-WID_16*  0];
wire [15:0] nout_01 = nout_data[PE_NUM*1*WID_16-1-WID_16*  1 : PE_NUM*1*WID_16-WID_16-WID_16*  1];
wire [15:0] nout_02 = nout_data[PE_NUM*1*WID_16-1-WID_16*  2 : PE_NUM*1*WID_16-WID_16-WID_16*  2];
wire [15:0] nout_03 = nout_data[PE_NUM*1*WID_16-1-WID_16*  3 : PE_NUM*1*WID_16-WID_16-WID_16*  3];
wire [15:0] nout_04 = nout_data[PE_NUM*1*WID_16-1-WID_16*  4 : PE_NUM*1*WID_16-WID_16-WID_16*  4];
wire [15:0] nout_05 = nout_data[PE_NUM*1*WID_16-1-WID_16*  5 : PE_NUM*1*WID_16-WID_16-WID_16*  5];
wire [15:0] nout_06 = nout_data[PE_NUM*1*WID_16-1-WID_16*  6 : PE_NUM*1*WID_16-WID_16-WID_16*  6];
wire [15:0] nout_07 = nout_data[PE_NUM*1*WID_16-1-WID_16*  7 : PE_NUM*1*WID_16-WID_16-WID_16*  7];
wire [15:0] nout_08 = nout_data[PE_NUM*1*WID_16-1-WID_16*  8 : PE_NUM*1*WID_16-WID_16-WID_16*  8];
wire [15:0] nout_09 = nout_data[PE_NUM*1*WID_16-1-WID_16*  9 : PE_NUM*1*WID_16-WID_16-WID_16*  9];
wire [15:0] nout_10 = nout_data[PE_NUM*1*WID_16-1-WID_16* 10 : PE_NUM*1*WID_16-WID_16-WID_16* 10];
wire [15:0] nout_11 = nout_data[PE_NUM*1*WID_16-1-WID_16* 11 : PE_NUM*1*WID_16-WID_16-WID_16* 11];
wire [15:0] nout_12 = nout_data[PE_NUM*1*WID_16-1-WID_16* 12 : PE_NUM*1*WID_16-WID_16-WID_16* 12];
wire [15:0] nout_13 = nout_data[PE_NUM*1*WID_16-1-WID_16* 13 : PE_NUM*1*WID_16-WID_16-WID_16* 13];
wire [15:0] nout_14 = nout_data[PE_NUM*1*WID_16-1-WID_16* 14 : PE_NUM*1*WID_16-WID_16-WID_16* 14];
wire [15:0] nout_15 = nout_data[PE_NUM*1*WID_16-1-WID_16* 15 : PE_NUM*1*WID_16-WID_16-WID_16* 15];

endmodule
