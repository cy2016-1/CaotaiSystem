`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: https://b23.tv/rHM8ZGk
// Module Name: process_element, aka PE
// Project Name: caotai_v1_0
// Description: 
//   1.The multiplier in process_element has a delay of 2 clk, 
//       and the addition calculation takes 1 clk. Therefore, 
//       the output of this submodule is delayed by 3 clk relative to the input.
// 
// Revision:
// Revision 0.01 - File Created, 2023/10/13 09:36:10
// 
//////////////////////////////////////////////////////////////////////////////////


module process_element
#(
  parameter                           COFF_W      =   16 ,
  parameter                           NNIN_W      =   16 ,
  parameter                           NOUT_W      =   COFF_W + NNIN_W
)
(
  input                               clk                ,
  input                               set                ,
  input      [COFF_W            -1:0] bias               ,
  input                               en                 ,
  input      [COFF_W            -1:0] coff1              ,
  input      [NNIN_W            -1:0] nnin1              ,
  input      [COFF_W            -1:0] coff2              ,
  input      [NNIN_W            -1:0] nnin2              ,
  output     [NNIN_W            -1:0] nnout
);


localparam                            FL_IN       =    7 ;
localparam                            FL_WE       =   12 ;
wire [NOUT_W                    -1:0] res_1              ;
wire [NOUT_W                    -1:0] res_2              ;
reg                                   set_d1      =  'd0 ;
reg                                   set_d2      =  'd0 ;
reg  [COFF_W                    -1:0] bias_d1     =  'd0 ;
reg  [COFF_W                    -1:0] bias_d2     =  'd0 ;
reg                                   en_d1       =  'd0 ;
reg                                   en_d2       =  'd0 ;
reg  [NOUT_W                    -1:0] nout_data   =  'd0 ;


assign nnout = nout_data[NNIN_W+FL_WE-1 : FL_WE];

always @(posedge clk)
begin
  set_d1  <= set ;
  set_d2  <= set_d1 ;
  bias_d1 <= bias;
  bias_d2 <= bias_d1;
  en_d1   <= en  ;
  en_d2   <= en_d1  ;
end

always @(posedge clk)
begin
  if (set_d2)
  begin
    nout_data <= {{(NNIN_W-FL_IN){bias_d2[COFF_W-1]}}, bias_d2, {FL_IN{1'b0}}};
  end
  else if (en_d2)
  begin
    nout_data <= nout_data + res_1 + res_2;
  end
  else
  begin
    nout_data <= 'd0;
  end
end


mult_16_16bit_signed
mult_inst1
(
  .p            (res_1        ), // output wire [31 : 0]
  .a            (coff1        ), // input  wire [15 : 0]
  .b            (nnin1        ), // input  wire [15 : 0]
  .cea          ('d1          ),
  .ceb          ('d1          ),
  .cepd         ('d1          ),
  .clk          (clk          ),
  .rstan        ('d1          ),
  .rstbn        ('d1          ),
  .rstpdn       ('d1          )
);

mult_16_16bit_signed
mult_inst2
(
  .p            (res_2        ), // output wire [31 : 0]
  .a            (coff2        ), // input  wire [15 : 0]
  .b            (nnin2        ), // input  wire [15 : 0]
  .cea          ('d1          ),
  .ceb          ('d1          ),
  .cepd         ('d1          ),
  .clk          (clk          ),
  .rstan        ('d1          ),
  .rstbn        ('d1          ),
  .rstpdn       ('d1          )
);

endmodule
