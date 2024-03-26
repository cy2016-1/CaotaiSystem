// Verilog netlist created by TD v4.6.18154
// Mon Oct 30 20:25:09 2023

`timescale 1ns / 1ps
module fmap_dram_256bit  // ../ip/fmap_dram_256bit/fmap_dram_256bit.v(14)
  (
  di,
  raddr,
  waddr,
  wclk,
  we,
  do
  );

  input [255:0] di;  // ../ip/fmap_dram_256bit/fmap_dram_256bit.v(23)
  input [4:0] raddr;  // ../ip/fmap_dram_256bit/fmap_dram_256bit.v(25)
  input [4:0] waddr;  // ../ip/fmap_dram_256bit/fmap_dram_256bit.v(24)
  input wclk;  // ../ip/fmap_dram_256bit/fmap_dram_256bit.v(26)
  input we;  // ../ip/fmap_dram_256bit/fmap_dram_256bit.v(26)
  output [255:0] do;  // ../ip/fmap_dram_256bit/fmap_dram_256bit.v(28)

  parameter ADDR_WIDTH_R = 5;
  parameter ADDR_WIDTH_W = 5;
  parameter DATA_DEPTH_R = 32;
  parameter DATA_DEPTH_W = 32;
  parameter DATA_WIDTH_R = 256;
  parameter DATA_WIDTH_W = 256;
  wire dram_do_i0_000;
  wire dram_do_i0_001;
  wire dram_do_i0_002;
  wire dram_do_i0_003;
  wire dram_do_i0_004;
  wire dram_do_i0_005;
  wire dram_do_i0_006;
  wire dram_do_i0_007;
  wire dram_do_i0_008;
  wire dram_do_i0_009;
  wire dram_do_i0_010;
  wire dram_do_i0_011;
  wire dram_do_i0_012;
  wire dram_do_i0_013;
  wire dram_do_i0_014;
  wire dram_do_i0_015;
  wire dram_do_i0_016;
  wire dram_do_i0_017;
  wire dram_do_i0_018;
  wire dram_do_i0_019;
  wire dram_do_i0_020;
  wire dram_do_i0_021;
  wire dram_do_i0_022;
  wire dram_do_i0_023;
  wire dram_do_i0_024;
  wire dram_do_i0_025;
  wire dram_do_i0_026;
  wire dram_do_i0_027;
  wire dram_do_i0_028;
  wire dram_do_i0_029;
  wire dram_do_i0_030;
  wire dram_do_i0_031;
  wire dram_do_i0_032;
  wire dram_do_i0_033;
  wire dram_do_i0_034;
  wire dram_do_i0_035;
  wire dram_do_i0_036;
  wire dram_do_i0_037;
  wire dram_do_i0_038;
  wire dram_do_i0_039;
  wire dram_do_i0_040;
  wire dram_do_i0_041;
  wire dram_do_i0_042;
  wire dram_do_i0_043;
  wire dram_do_i0_044;
  wire dram_do_i0_045;
  wire dram_do_i0_046;
  wire dram_do_i0_047;
  wire dram_do_i0_048;
  wire dram_do_i0_049;
  wire dram_do_i0_050;
  wire dram_do_i0_051;
  wire dram_do_i0_052;
  wire dram_do_i0_053;
  wire dram_do_i0_054;
  wire dram_do_i0_055;
  wire dram_do_i0_056;
  wire dram_do_i0_057;
  wire dram_do_i0_058;
  wire dram_do_i0_059;
  wire dram_do_i0_060;
  wire dram_do_i0_061;
  wire dram_do_i0_062;
  wire dram_do_i0_063;
  wire dram_do_i0_064;
  wire dram_do_i0_065;
  wire dram_do_i0_066;
  wire dram_do_i0_067;
  wire dram_do_i0_068;
  wire dram_do_i0_069;
  wire dram_do_i0_070;
  wire dram_do_i0_071;
  wire dram_do_i0_072;
  wire dram_do_i0_073;
  wire dram_do_i0_074;
  wire dram_do_i0_075;
  wire dram_do_i0_076;
  wire dram_do_i0_077;
  wire dram_do_i0_078;
  wire dram_do_i0_079;
  wire dram_do_i0_080;
  wire dram_do_i0_081;
  wire dram_do_i0_082;
  wire dram_do_i0_083;
  wire dram_do_i0_084;
  wire dram_do_i0_085;
  wire dram_do_i0_086;
  wire dram_do_i0_087;
  wire dram_do_i0_088;
  wire dram_do_i0_089;
  wire dram_do_i0_090;
  wire dram_do_i0_091;
  wire dram_do_i0_092;
  wire dram_do_i0_093;
  wire dram_do_i0_094;
  wire dram_do_i0_095;
  wire dram_do_i0_096;
  wire dram_do_i0_097;
  wire dram_do_i0_098;
  wire dram_do_i0_099;
  wire dram_do_i0_100;
  wire dram_do_i0_101;
  wire dram_do_i0_102;
  wire dram_do_i0_103;
  wire dram_do_i0_104;
  wire dram_do_i0_105;
  wire dram_do_i0_106;
  wire dram_do_i0_107;
  wire dram_do_i0_108;
  wire dram_do_i0_109;
  wire dram_do_i0_110;
  wire dram_do_i0_111;
  wire dram_do_i0_112;
  wire dram_do_i0_113;
  wire dram_do_i0_114;
  wire dram_do_i0_115;
  wire dram_do_i0_116;
  wire dram_do_i0_117;
  wire dram_do_i0_118;
  wire dram_do_i0_119;
  wire dram_do_i0_120;
  wire dram_do_i0_121;
  wire dram_do_i0_122;
  wire dram_do_i0_123;
  wire dram_do_i0_124;
  wire dram_do_i0_125;
  wire dram_do_i0_126;
  wire dram_do_i0_127;
  wire dram_do_i0_128;
  wire dram_do_i0_129;
  wire dram_do_i0_130;
  wire dram_do_i0_131;
  wire dram_do_i0_132;
  wire dram_do_i0_133;
  wire dram_do_i0_134;
  wire dram_do_i0_135;
  wire dram_do_i0_136;
  wire dram_do_i0_137;
  wire dram_do_i0_138;
  wire dram_do_i0_139;
  wire dram_do_i0_140;
  wire dram_do_i0_141;
  wire dram_do_i0_142;
  wire dram_do_i0_143;
  wire dram_do_i0_144;
  wire dram_do_i0_145;
  wire dram_do_i0_146;
  wire dram_do_i0_147;
  wire dram_do_i0_148;
  wire dram_do_i0_149;
  wire dram_do_i0_150;
  wire dram_do_i0_151;
  wire dram_do_i0_152;
  wire dram_do_i0_153;
  wire dram_do_i0_154;
  wire dram_do_i0_155;
  wire dram_do_i0_156;
  wire dram_do_i0_157;
  wire dram_do_i0_158;
  wire dram_do_i0_159;
  wire dram_do_i0_160;
  wire dram_do_i0_161;
  wire dram_do_i0_162;
  wire dram_do_i0_163;
  wire dram_do_i0_164;
  wire dram_do_i0_165;
  wire dram_do_i0_166;
  wire dram_do_i0_167;
  wire dram_do_i0_168;
  wire dram_do_i0_169;
  wire dram_do_i0_170;
  wire dram_do_i0_171;
  wire dram_do_i0_172;
  wire dram_do_i0_173;
  wire dram_do_i0_174;
  wire dram_do_i0_175;
  wire dram_do_i0_176;
  wire dram_do_i0_177;
  wire dram_do_i0_178;
  wire dram_do_i0_179;
  wire dram_do_i0_180;
  wire dram_do_i0_181;
  wire dram_do_i0_182;
  wire dram_do_i0_183;
  wire dram_do_i0_184;
  wire dram_do_i0_185;
  wire dram_do_i0_186;
  wire dram_do_i0_187;
  wire dram_do_i0_188;
  wire dram_do_i0_189;
  wire dram_do_i0_190;
  wire dram_do_i0_191;
  wire dram_do_i0_192;
  wire dram_do_i0_193;
  wire dram_do_i0_194;
  wire dram_do_i0_195;
  wire dram_do_i0_196;
  wire dram_do_i0_197;
  wire dram_do_i0_198;
  wire dram_do_i0_199;
  wire dram_do_i0_200;
  wire dram_do_i0_201;
  wire dram_do_i0_202;
  wire dram_do_i0_203;
  wire dram_do_i0_204;
  wire dram_do_i0_205;
  wire dram_do_i0_206;
  wire dram_do_i0_207;
  wire dram_do_i0_208;
  wire dram_do_i0_209;
  wire dram_do_i0_210;
  wire dram_do_i0_211;
  wire dram_do_i0_212;
  wire dram_do_i0_213;
  wire dram_do_i0_214;
  wire dram_do_i0_215;
  wire dram_do_i0_216;
  wire dram_do_i0_217;
  wire dram_do_i0_218;
  wire dram_do_i0_219;
  wire dram_do_i0_220;
  wire dram_do_i0_221;
  wire dram_do_i0_222;
  wire dram_do_i0_223;
  wire dram_do_i0_224;
  wire dram_do_i0_225;
  wire dram_do_i0_226;
  wire dram_do_i0_227;
  wire dram_do_i0_228;
  wire dram_do_i0_229;
  wire dram_do_i0_230;
  wire dram_do_i0_231;
  wire dram_do_i0_232;
  wire dram_do_i0_233;
  wire dram_do_i0_234;
  wire dram_do_i0_235;
  wire dram_do_i0_236;
  wire dram_do_i0_237;
  wire dram_do_i0_238;
  wire dram_do_i0_239;
  wire dram_do_i0_240;
  wire dram_do_i0_241;
  wire dram_do_i0_242;
  wire dram_do_i0_243;
  wire dram_do_i0_244;
  wire dram_do_i0_245;
  wire dram_do_i0_246;
  wire dram_do_i0_247;
  wire dram_do_i0_248;
  wire dram_do_i0_249;
  wire dram_do_i0_250;
  wire dram_do_i0_251;
  wire dram_do_i0_252;
  wire dram_do_i0_253;
  wire dram_do_i0_254;
  wire dram_do_i0_255;
  wire dram_do_i1_000;
  wire dram_do_i1_001;
  wire dram_do_i1_002;
  wire dram_do_i1_003;
  wire dram_do_i1_004;
  wire dram_do_i1_005;
  wire dram_do_i1_006;
  wire dram_do_i1_007;
  wire dram_do_i1_008;
  wire dram_do_i1_009;
  wire dram_do_i1_010;
  wire dram_do_i1_011;
  wire dram_do_i1_012;
  wire dram_do_i1_013;
  wire dram_do_i1_014;
  wire dram_do_i1_015;
  wire dram_do_i1_016;
  wire dram_do_i1_017;
  wire dram_do_i1_018;
  wire dram_do_i1_019;
  wire dram_do_i1_020;
  wire dram_do_i1_021;
  wire dram_do_i1_022;
  wire dram_do_i1_023;
  wire dram_do_i1_024;
  wire dram_do_i1_025;
  wire dram_do_i1_026;
  wire dram_do_i1_027;
  wire dram_do_i1_028;
  wire dram_do_i1_029;
  wire dram_do_i1_030;
  wire dram_do_i1_031;
  wire dram_do_i1_032;
  wire dram_do_i1_033;
  wire dram_do_i1_034;
  wire dram_do_i1_035;
  wire dram_do_i1_036;
  wire dram_do_i1_037;
  wire dram_do_i1_038;
  wire dram_do_i1_039;
  wire dram_do_i1_040;
  wire dram_do_i1_041;
  wire dram_do_i1_042;
  wire dram_do_i1_043;
  wire dram_do_i1_044;
  wire dram_do_i1_045;
  wire dram_do_i1_046;
  wire dram_do_i1_047;
  wire dram_do_i1_048;
  wire dram_do_i1_049;
  wire dram_do_i1_050;
  wire dram_do_i1_051;
  wire dram_do_i1_052;
  wire dram_do_i1_053;
  wire dram_do_i1_054;
  wire dram_do_i1_055;
  wire dram_do_i1_056;
  wire dram_do_i1_057;
  wire dram_do_i1_058;
  wire dram_do_i1_059;
  wire dram_do_i1_060;
  wire dram_do_i1_061;
  wire dram_do_i1_062;
  wire dram_do_i1_063;
  wire dram_do_i1_064;
  wire dram_do_i1_065;
  wire dram_do_i1_066;
  wire dram_do_i1_067;
  wire dram_do_i1_068;
  wire dram_do_i1_069;
  wire dram_do_i1_070;
  wire dram_do_i1_071;
  wire dram_do_i1_072;
  wire dram_do_i1_073;
  wire dram_do_i1_074;
  wire dram_do_i1_075;
  wire dram_do_i1_076;
  wire dram_do_i1_077;
  wire dram_do_i1_078;
  wire dram_do_i1_079;
  wire dram_do_i1_080;
  wire dram_do_i1_081;
  wire dram_do_i1_082;
  wire dram_do_i1_083;
  wire dram_do_i1_084;
  wire dram_do_i1_085;
  wire dram_do_i1_086;
  wire dram_do_i1_087;
  wire dram_do_i1_088;
  wire dram_do_i1_089;
  wire dram_do_i1_090;
  wire dram_do_i1_091;
  wire dram_do_i1_092;
  wire dram_do_i1_093;
  wire dram_do_i1_094;
  wire dram_do_i1_095;
  wire dram_do_i1_096;
  wire dram_do_i1_097;
  wire dram_do_i1_098;
  wire dram_do_i1_099;
  wire dram_do_i1_100;
  wire dram_do_i1_101;
  wire dram_do_i1_102;
  wire dram_do_i1_103;
  wire dram_do_i1_104;
  wire dram_do_i1_105;
  wire dram_do_i1_106;
  wire dram_do_i1_107;
  wire dram_do_i1_108;
  wire dram_do_i1_109;
  wire dram_do_i1_110;
  wire dram_do_i1_111;
  wire dram_do_i1_112;
  wire dram_do_i1_113;
  wire dram_do_i1_114;
  wire dram_do_i1_115;
  wire dram_do_i1_116;
  wire dram_do_i1_117;
  wire dram_do_i1_118;
  wire dram_do_i1_119;
  wire dram_do_i1_120;
  wire dram_do_i1_121;
  wire dram_do_i1_122;
  wire dram_do_i1_123;
  wire dram_do_i1_124;
  wire dram_do_i1_125;
  wire dram_do_i1_126;
  wire dram_do_i1_127;
  wire dram_do_i1_128;
  wire dram_do_i1_129;
  wire dram_do_i1_130;
  wire dram_do_i1_131;
  wire dram_do_i1_132;
  wire dram_do_i1_133;
  wire dram_do_i1_134;
  wire dram_do_i1_135;
  wire dram_do_i1_136;
  wire dram_do_i1_137;
  wire dram_do_i1_138;
  wire dram_do_i1_139;
  wire dram_do_i1_140;
  wire dram_do_i1_141;
  wire dram_do_i1_142;
  wire dram_do_i1_143;
  wire dram_do_i1_144;
  wire dram_do_i1_145;
  wire dram_do_i1_146;
  wire dram_do_i1_147;
  wire dram_do_i1_148;
  wire dram_do_i1_149;
  wire dram_do_i1_150;
  wire dram_do_i1_151;
  wire dram_do_i1_152;
  wire dram_do_i1_153;
  wire dram_do_i1_154;
  wire dram_do_i1_155;
  wire dram_do_i1_156;
  wire dram_do_i1_157;
  wire dram_do_i1_158;
  wire dram_do_i1_159;
  wire dram_do_i1_160;
  wire dram_do_i1_161;
  wire dram_do_i1_162;
  wire dram_do_i1_163;
  wire dram_do_i1_164;
  wire dram_do_i1_165;
  wire dram_do_i1_166;
  wire dram_do_i1_167;
  wire dram_do_i1_168;
  wire dram_do_i1_169;
  wire dram_do_i1_170;
  wire dram_do_i1_171;
  wire dram_do_i1_172;
  wire dram_do_i1_173;
  wire dram_do_i1_174;
  wire dram_do_i1_175;
  wire dram_do_i1_176;
  wire dram_do_i1_177;
  wire dram_do_i1_178;
  wire dram_do_i1_179;
  wire dram_do_i1_180;
  wire dram_do_i1_181;
  wire dram_do_i1_182;
  wire dram_do_i1_183;
  wire dram_do_i1_184;
  wire dram_do_i1_185;
  wire dram_do_i1_186;
  wire dram_do_i1_187;
  wire dram_do_i1_188;
  wire dram_do_i1_189;
  wire dram_do_i1_190;
  wire dram_do_i1_191;
  wire dram_do_i1_192;
  wire dram_do_i1_193;
  wire dram_do_i1_194;
  wire dram_do_i1_195;
  wire dram_do_i1_196;
  wire dram_do_i1_197;
  wire dram_do_i1_198;
  wire dram_do_i1_199;
  wire dram_do_i1_200;
  wire dram_do_i1_201;
  wire dram_do_i1_202;
  wire dram_do_i1_203;
  wire dram_do_i1_204;
  wire dram_do_i1_205;
  wire dram_do_i1_206;
  wire dram_do_i1_207;
  wire dram_do_i1_208;
  wire dram_do_i1_209;
  wire dram_do_i1_210;
  wire dram_do_i1_211;
  wire dram_do_i1_212;
  wire dram_do_i1_213;
  wire dram_do_i1_214;
  wire dram_do_i1_215;
  wire dram_do_i1_216;
  wire dram_do_i1_217;
  wire dram_do_i1_218;
  wire dram_do_i1_219;
  wire dram_do_i1_220;
  wire dram_do_i1_221;
  wire dram_do_i1_222;
  wire dram_do_i1_223;
  wire dram_do_i1_224;
  wire dram_do_i1_225;
  wire dram_do_i1_226;
  wire dram_do_i1_227;
  wire dram_do_i1_228;
  wire dram_do_i1_229;
  wire dram_do_i1_230;
  wire dram_do_i1_231;
  wire dram_do_i1_232;
  wire dram_do_i1_233;
  wire dram_do_i1_234;
  wire dram_do_i1_235;
  wire dram_do_i1_236;
  wire dram_do_i1_237;
  wire dram_do_i1_238;
  wire dram_do_i1_239;
  wire dram_do_i1_240;
  wire dram_do_i1_241;
  wire dram_do_i1_242;
  wire dram_do_i1_243;
  wire dram_do_i1_244;
  wire dram_do_i1_245;
  wire dram_do_i1_246;
  wire dram_do_i1_247;
  wire dram_do_i1_248;
  wire dram_do_i1_249;
  wire dram_do_i1_250;
  wire dram_do_i1_251;
  wire dram_do_i1_252;
  wire dram_do_i1_253;
  wire dram_do_i1_254;
  wire dram_do_i1_255;
  wire \waddr[4]_neg ;
  wire we_0;
  wire we_1;

  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_0  (
    .i0(dram_do_i0_000),
    .i1(dram_do_i1_000),
    .sel(raddr[4]),
    .o(do[0]));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_0  (
    .i0(dram_do_i0_001),
    .i1(dram_do_i1_001),
    .sel(raddr[4]),
    .o(do[1]));
  AL_MUX \dram_do_mux_b10/al_mux_b0_0_0  (
    .i0(dram_do_i0_010),
    .i1(dram_do_i1_010),
    .sel(raddr[4]),
    .o(do[10]));
  AL_MUX \dram_do_mux_b100/al_mux_b0_0_0  (
    .i0(dram_do_i0_100),
    .i1(dram_do_i1_100),
    .sel(raddr[4]),
    .o(do[100]));
  AL_MUX \dram_do_mux_b101/al_mux_b0_0_0  (
    .i0(dram_do_i0_101),
    .i1(dram_do_i1_101),
    .sel(raddr[4]),
    .o(do[101]));
  AL_MUX \dram_do_mux_b102/al_mux_b0_0_0  (
    .i0(dram_do_i0_102),
    .i1(dram_do_i1_102),
    .sel(raddr[4]),
    .o(do[102]));
  AL_MUX \dram_do_mux_b103/al_mux_b0_0_0  (
    .i0(dram_do_i0_103),
    .i1(dram_do_i1_103),
    .sel(raddr[4]),
    .o(do[103]));
  AL_MUX \dram_do_mux_b104/al_mux_b0_0_0  (
    .i0(dram_do_i0_104),
    .i1(dram_do_i1_104),
    .sel(raddr[4]),
    .o(do[104]));
  AL_MUX \dram_do_mux_b105/al_mux_b0_0_0  (
    .i0(dram_do_i0_105),
    .i1(dram_do_i1_105),
    .sel(raddr[4]),
    .o(do[105]));
  AL_MUX \dram_do_mux_b106/al_mux_b0_0_0  (
    .i0(dram_do_i0_106),
    .i1(dram_do_i1_106),
    .sel(raddr[4]),
    .o(do[106]));
  AL_MUX \dram_do_mux_b107/al_mux_b0_0_0  (
    .i0(dram_do_i0_107),
    .i1(dram_do_i1_107),
    .sel(raddr[4]),
    .o(do[107]));
  AL_MUX \dram_do_mux_b108/al_mux_b0_0_0  (
    .i0(dram_do_i0_108),
    .i1(dram_do_i1_108),
    .sel(raddr[4]),
    .o(do[108]));
  AL_MUX \dram_do_mux_b109/al_mux_b0_0_0  (
    .i0(dram_do_i0_109),
    .i1(dram_do_i1_109),
    .sel(raddr[4]),
    .o(do[109]));
  AL_MUX \dram_do_mux_b11/al_mux_b0_0_0  (
    .i0(dram_do_i0_011),
    .i1(dram_do_i1_011),
    .sel(raddr[4]),
    .o(do[11]));
  AL_MUX \dram_do_mux_b110/al_mux_b0_0_0  (
    .i0(dram_do_i0_110),
    .i1(dram_do_i1_110),
    .sel(raddr[4]),
    .o(do[110]));
  AL_MUX \dram_do_mux_b111/al_mux_b0_0_0  (
    .i0(dram_do_i0_111),
    .i1(dram_do_i1_111),
    .sel(raddr[4]),
    .o(do[111]));
  AL_MUX \dram_do_mux_b112/al_mux_b0_0_0  (
    .i0(dram_do_i0_112),
    .i1(dram_do_i1_112),
    .sel(raddr[4]),
    .o(do[112]));
  AL_MUX \dram_do_mux_b113/al_mux_b0_0_0  (
    .i0(dram_do_i0_113),
    .i1(dram_do_i1_113),
    .sel(raddr[4]),
    .o(do[113]));
  AL_MUX \dram_do_mux_b114/al_mux_b0_0_0  (
    .i0(dram_do_i0_114),
    .i1(dram_do_i1_114),
    .sel(raddr[4]),
    .o(do[114]));
  AL_MUX \dram_do_mux_b115/al_mux_b0_0_0  (
    .i0(dram_do_i0_115),
    .i1(dram_do_i1_115),
    .sel(raddr[4]),
    .o(do[115]));
  AL_MUX \dram_do_mux_b116/al_mux_b0_0_0  (
    .i0(dram_do_i0_116),
    .i1(dram_do_i1_116),
    .sel(raddr[4]),
    .o(do[116]));
  AL_MUX \dram_do_mux_b117/al_mux_b0_0_0  (
    .i0(dram_do_i0_117),
    .i1(dram_do_i1_117),
    .sel(raddr[4]),
    .o(do[117]));
  AL_MUX \dram_do_mux_b118/al_mux_b0_0_0  (
    .i0(dram_do_i0_118),
    .i1(dram_do_i1_118),
    .sel(raddr[4]),
    .o(do[118]));
  AL_MUX \dram_do_mux_b119/al_mux_b0_0_0  (
    .i0(dram_do_i0_119),
    .i1(dram_do_i1_119),
    .sel(raddr[4]),
    .o(do[119]));
  AL_MUX \dram_do_mux_b12/al_mux_b0_0_0  (
    .i0(dram_do_i0_012),
    .i1(dram_do_i1_012),
    .sel(raddr[4]),
    .o(do[12]));
  AL_MUX \dram_do_mux_b120/al_mux_b0_0_0  (
    .i0(dram_do_i0_120),
    .i1(dram_do_i1_120),
    .sel(raddr[4]),
    .o(do[120]));
  AL_MUX \dram_do_mux_b121/al_mux_b0_0_0  (
    .i0(dram_do_i0_121),
    .i1(dram_do_i1_121),
    .sel(raddr[4]),
    .o(do[121]));
  AL_MUX \dram_do_mux_b122/al_mux_b0_0_0  (
    .i0(dram_do_i0_122),
    .i1(dram_do_i1_122),
    .sel(raddr[4]),
    .o(do[122]));
  AL_MUX \dram_do_mux_b123/al_mux_b0_0_0  (
    .i0(dram_do_i0_123),
    .i1(dram_do_i1_123),
    .sel(raddr[4]),
    .o(do[123]));
  AL_MUX \dram_do_mux_b124/al_mux_b0_0_0  (
    .i0(dram_do_i0_124),
    .i1(dram_do_i1_124),
    .sel(raddr[4]),
    .o(do[124]));
  AL_MUX \dram_do_mux_b125/al_mux_b0_0_0  (
    .i0(dram_do_i0_125),
    .i1(dram_do_i1_125),
    .sel(raddr[4]),
    .o(do[125]));
  AL_MUX \dram_do_mux_b126/al_mux_b0_0_0  (
    .i0(dram_do_i0_126),
    .i1(dram_do_i1_126),
    .sel(raddr[4]),
    .o(do[126]));
  AL_MUX \dram_do_mux_b127/al_mux_b0_0_0  (
    .i0(dram_do_i0_127),
    .i1(dram_do_i1_127),
    .sel(raddr[4]),
    .o(do[127]));
  AL_MUX \dram_do_mux_b128/al_mux_b0_0_0  (
    .i0(dram_do_i0_128),
    .i1(dram_do_i1_128),
    .sel(raddr[4]),
    .o(do[128]));
  AL_MUX \dram_do_mux_b129/al_mux_b0_0_0  (
    .i0(dram_do_i0_129),
    .i1(dram_do_i1_129),
    .sel(raddr[4]),
    .o(do[129]));
  AL_MUX \dram_do_mux_b13/al_mux_b0_0_0  (
    .i0(dram_do_i0_013),
    .i1(dram_do_i1_013),
    .sel(raddr[4]),
    .o(do[13]));
  AL_MUX \dram_do_mux_b130/al_mux_b0_0_0  (
    .i0(dram_do_i0_130),
    .i1(dram_do_i1_130),
    .sel(raddr[4]),
    .o(do[130]));
  AL_MUX \dram_do_mux_b131/al_mux_b0_0_0  (
    .i0(dram_do_i0_131),
    .i1(dram_do_i1_131),
    .sel(raddr[4]),
    .o(do[131]));
  AL_MUX \dram_do_mux_b132/al_mux_b0_0_0  (
    .i0(dram_do_i0_132),
    .i1(dram_do_i1_132),
    .sel(raddr[4]),
    .o(do[132]));
  AL_MUX \dram_do_mux_b133/al_mux_b0_0_0  (
    .i0(dram_do_i0_133),
    .i1(dram_do_i1_133),
    .sel(raddr[4]),
    .o(do[133]));
  AL_MUX \dram_do_mux_b134/al_mux_b0_0_0  (
    .i0(dram_do_i0_134),
    .i1(dram_do_i1_134),
    .sel(raddr[4]),
    .o(do[134]));
  AL_MUX \dram_do_mux_b135/al_mux_b0_0_0  (
    .i0(dram_do_i0_135),
    .i1(dram_do_i1_135),
    .sel(raddr[4]),
    .o(do[135]));
  AL_MUX \dram_do_mux_b136/al_mux_b0_0_0  (
    .i0(dram_do_i0_136),
    .i1(dram_do_i1_136),
    .sel(raddr[4]),
    .o(do[136]));
  AL_MUX \dram_do_mux_b137/al_mux_b0_0_0  (
    .i0(dram_do_i0_137),
    .i1(dram_do_i1_137),
    .sel(raddr[4]),
    .o(do[137]));
  AL_MUX \dram_do_mux_b138/al_mux_b0_0_0  (
    .i0(dram_do_i0_138),
    .i1(dram_do_i1_138),
    .sel(raddr[4]),
    .o(do[138]));
  AL_MUX \dram_do_mux_b139/al_mux_b0_0_0  (
    .i0(dram_do_i0_139),
    .i1(dram_do_i1_139),
    .sel(raddr[4]),
    .o(do[139]));
  AL_MUX \dram_do_mux_b14/al_mux_b0_0_0  (
    .i0(dram_do_i0_014),
    .i1(dram_do_i1_014),
    .sel(raddr[4]),
    .o(do[14]));
  AL_MUX \dram_do_mux_b140/al_mux_b0_0_0  (
    .i0(dram_do_i0_140),
    .i1(dram_do_i1_140),
    .sel(raddr[4]),
    .o(do[140]));
  AL_MUX \dram_do_mux_b141/al_mux_b0_0_0  (
    .i0(dram_do_i0_141),
    .i1(dram_do_i1_141),
    .sel(raddr[4]),
    .o(do[141]));
  AL_MUX \dram_do_mux_b142/al_mux_b0_0_0  (
    .i0(dram_do_i0_142),
    .i1(dram_do_i1_142),
    .sel(raddr[4]),
    .o(do[142]));
  AL_MUX \dram_do_mux_b143/al_mux_b0_0_0  (
    .i0(dram_do_i0_143),
    .i1(dram_do_i1_143),
    .sel(raddr[4]),
    .o(do[143]));
  AL_MUX \dram_do_mux_b144/al_mux_b0_0_0  (
    .i0(dram_do_i0_144),
    .i1(dram_do_i1_144),
    .sel(raddr[4]),
    .o(do[144]));
  AL_MUX \dram_do_mux_b145/al_mux_b0_0_0  (
    .i0(dram_do_i0_145),
    .i1(dram_do_i1_145),
    .sel(raddr[4]),
    .o(do[145]));
  AL_MUX \dram_do_mux_b146/al_mux_b0_0_0  (
    .i0(dram_do_i0_146),
    .i1(dram_do_i1_146),
    .sel(raddr[4]),
    .o(do[146]));
  AL_MUX \dram_do_mux_b147/al_mux_b0_0_0  (
    .i0(dram_do_i0_147),
    .i1(dram_do_i1_147),
    .sel(raddr[4]),
    .o(do[147]));
  AL_MUX \dram_do_mux_b148/al_mux_b0_0_0  (
    .i0(dram_do_i0_148),
    .i1(dram_do_i1_148),
    .sel(raddr[4]),
    .o(do[148]));
  AL_MUX \dram_do_mux_b149/al_mux_b0_0_0  (
    .i0(dram_do_i0_149),
    .i1(dram_do_i1_149),
    .sel(raddr[4]),
    .o(do[149]));
  AL_MUX \dram_do_mux_b15/al_mux_b0_0_0  (
    .i0(dram_do_i0_015),
    .i1(dram_do_i1_015),
    .sel(raddr[4]),
    .o(do[15]));
  AL_MUX \dram_do_mux_b150/al_mux_b0_0_0  (
    .i0(dram_do_i0_150),
    .i1(dram_do_i1_150),
    .sel(raddr[4]),
    .o(do[150]));
  AL_MUX \dram_do_mux_b151/al_mux_b0_0_0  (
    .i0(dram_do_i0_151),
    .i1(dram_do_i1_151),
    .sel(raddr[4]),
    .o(do[151]));
  AL_MUX \dram_do_mux_b152/al_mux_b0_0_0  (
    .i0(dram_do_i0_152),
    .i1(dram_do_i1_152),
    .sel(raddr[4]),
    .o(do[152]));
  AL_MUX \dram_do_mux_b153/al_mux_b0_0_0  (
    .i0(dram_do_i0_153),
    .i1(dram_do_i1_153),
    .sel(raddr[4]),
    .o(do[153]));
  AL_MUX \dram_do_mux_b154/al_mux_b0_0_0  (
    .i0(dram_do_i0_154),
    .i1(dram_do_i1_154),
    .sel(raddr[4]),
    .o(do[154]));
  AL_MUX \dram_do_mux_b155/al_mux_b0_0_0  (
    .i0(dram_do_i0_155),
    .i1(dram_do_i1_155),
    .sel(raddr[4]),
    .o(do[155]));
  AL_MUX \dram_do_mux_b156/al_mux_b0_0_0  (
    .i0(dram_do_i0_156),
    .i1(dram_do_i1_156),
    .sel(raddr[4]),
    .o(do[156]));
  AL_MUX \dram_do_mux_b157/al_mux_b0_0_0  (
    .i0(dram_do_i0_157),
    .i1(dram_do_i1_157),
    .sel(raddr[4]),
    .o(do[157]));
  AL_MUX \dram_do_mux_b158/al_mux_b0_0_0  (
    .i0(dram_do_i0_158),
    .i1(dram_do_i1_158),
    .sel(raddr[4]),
    .o(do[158]));
  AL_MUX \dram_do_mux_b159/al_mux_b0_0_0  (
    .i0(dram_do_i0_159),
    .i1(dram_do_i1_159),
    .sel(raddr[4]),
    .o(do[159]));
  AL_MUX \dram_do_mux_b16/al_mux_b0_0_0  (
    .i0(dram_do_i0_016),
    .i1(dram_do_i1_016),
    .sel(raddr[4]),
    .o(do[16]));
  AL_MUX \dram_do_mux_b160/al_mux_b0_0_0  (
    .i0(dram_do_i0_160),
    .i1(dram_do_i1_160),
    .sel(raddr[4]),
    .o(do[160]));
  AL_MUX \dram_do_mux_b161/al_mux_b0_0_0  (
    .i0(dram_do_i0_161),
    .i1(dram_do_i1_161),
    .sel(raddr[4]),
    .o(do[161]));
  AL_MUX \dram_do_mux_b162/al_mux_b0_0_0  (
    .i0(dram_do_i0_162),
    .i1(dram_do_i1_162),
    .sel(raddr[4]),
    .o(do[162]));
  AL_MUX \dram_do_mux_b163/al_mux_b0_0_0  (
    .i0(dram_do_i0_163),
    .i1(dram_do_i1_163),
    .sel(raddr[4]),
    .o(do[163]));
  AL_MUX \dram_do_mux_b164/al_mux_b0_0_0  (
    .i0(dram_do_i0_164),
    .i1(dram_do_i1_164),
    .sel(raddr[4]),
    .o(do[164]));
  AL_MUX \dram_do_mux_b165/al_mux_b0_0_0  (
    .i0(dram_do_i0_165),
    .i1(dram_do_i1_165),
    .sel(raddr[4]),
    .o(do[165]));
  AL_MUX \dram_do_mux_b166/al_mux_b0_0_0  (
    .i0(dram_do_i0_166),
    .i1(dram_do_i1_166),
    .sel(raddr[4]),
    .o(do[166]));
  AL_MUX \dram_do_mux_b167/al_mux_b0_0_0  (
    .i0(dram_do_i0_167),
    .i1(dram_do_i1_167),
    .sel(raddr[4]),
    .o(do[167]));
  AL_MUX \dram_do_mux_b168/al_mux_b0_0_0  (
    .i0(dram_do_i0_168),
    .i1(dram_do_i1_168),
    .sel(raddr[4]),
    .o(do[168]));
  AL_MUX \dram_do_mux_b169/al_mux_b0_0_0  (
    .i0(dram_do_i0_169),
    .i1(dram_do_i1_169),
    .sel(raddr[4]),
    .o(do[169]));
  AL_MUX \dram_do_mux_b17/al_mux_b0_0_0  (
    .i0(dram_do_i0_017),
    .i1(dram_do_i1_017),
    .sel(raddr[4]),
    .o(do[17]));
  AL_MUX \dram_do_mux_b170/al_mux_b0_0_0  (
    .i0(dram_do_i0_170),
    .i1(dram_do_i1_170),
    .sel(raddr[4]),
    .o(do[170]));
  AL_MUX \dram_do_mux_b171/al_mux_b0_0_0  (
    .i0(dram_do_i0_171),
    .i1(dram_do_i1_171),
    .sel(raddr[4]),
    .o(do[171]));
  AL_MUX \dram_do_mux_b172/al_mux_b0_0_0  (
    .i0(dram_do_i0_172),
    .i1(dram_do_i1_172),
    .sel(raddr[4]),
    .o(do[172]));
  AL_MUX \dram_do_mux_b173/al_mux_b0_0_0  (
    .i0(dram_do_i0_173),
    .i1(dram_do_i1_173),
    .sel(raddr[4]),
    .o(do[173]));
  AL_MUX \dram_do_mux_b174/al_mux_b0_0_0  (
    .i0(dram_do_i0_174),
    .i1(dram_do_i1_174),
    .sel(raddr[4]),
    .o(do[174]));
  AL_MUX \dram_do_mux_b175/al_mux_b0_0_0  (
    .i0(dram_do_i0_175),
    .i1(dram_do_i1_175),
    .sel(raddr[4]),
    .o(do[175]));
  AL_MUX \dram_do_mux_b176/al_mux_b0_0_0  (
    .i0(dram_do_i0_176),
    .i1(dram_do_i1_176),
    .sel(raddr[4]),
    .o(do[176]));
  AL_MUX \dram_do_mux_b177/al_mux_b0_0_0  (
    .i0(dram_do_i0_177),
    .i1(dram_do_i1_177),
    .sel(raddr[4]),
    .o(do[177]));
  AL_MUX \dram_do_mux_b178/al_mux_b0_0_0  (
    .i0(dram_do_i0_178),
    .i1(dram_do_i1_178),
    .sel(raddr[4]),
    .o(do[178]));
  AL_MUX \dram_do_mux_b179/al_mux_b0_0_0  (
    .i0(dram_do_i0_179),
    .i1(dram_do_i1_179),
    .sel(raddr[4]),
    .o(do[179]));
  AL_MUX \dram_do_mux_b18/al_mux_b0_0_0  (
    .i0(dram_do_i0_018),
    .i1(dram_do_i1_018),
    .sel(raddr[4]),
    .o(do[18]));
  AL_MUX \dram_do_mux_b180/al_mux_b0_0_0  (
    .i0(dram_do_i0_180),
    .i1(dram_do_i1_180),
    .sel(raddr[4]),
    .o(do[180]));
  AL_MUX \dram_do_mux_b181/al_mux_b0_0_0  (
    .i0(dram_do_i0_181),
    .i1(dram_do_i1_181),
    .sel(raddr[4]),
    .o(do[181]));
  AL_MUX \dram_do_mux_b182/al_mux_b0_0_0  (
    .i0(dram_do_i0_182),
    .i1(dram_do_i1_182),
    .sel(raddr[4]),
    .o(do[182]));
  AL_MUX \dram_do_mux_b183/al_mux_b0_0_0  (
    .i0(dram_do_i0_183),
    .i1(dram_do_i1_183),
    .sel(raddr[4]),
    .o(do[183]));
  AL_MUX \dram_do_mux_b184/al_mux_b0_0_0  (
    .i0(dram_do_i0_184),
    .i1(dram_do_i1_184),
    .sel(raddr[4]),
    .o(do[184]));
  AL_MUX \dram_do_mux_b185/al_mux_b0_0_0  (
    .i0(dram_do_i0_185),
    .i1(dram_do_i1_185),
    .sel(raddr[4]),
    .o(do[185]));
  AL_MUX \dram_do_mux_b186/al_mux_b0_0_0  (
    .i0(dram_do_i0_186),
    .i1(dram_do_i1_186),
    .sel(raddr[4]),
    .o(do[186]));
  AL_MUX \dram_do_mux_b187/al_mux_b0_0_0  (
    .i0(dram_do_i0_187),
    .i1(dram_do_i1_187),
    .sel(raddr[4]),
    .o(do[187]));
  AL_MUX \dram_do_mux_b188/al_mux_b0_0_0  (
    .i0(dram_do_i0_188),
    .i1(dram_do_i1_188),
    .sel(raddr[4]),
    .o(do[188]));
  AL_MUX \dram_do_mux_b189/al_mux_b0_0_0  (
    .i0(dram_do_i0_189),
    .i1(dram_do_i1_189),
    .sel(raddr[4]),
    .o(do[189]));
  AL_MUX \dram_do_mux_b19/al_mux_b0_0_0  (
    .i0(dram_do_i0_019),
    .i1(dram_do_i1_019),
    .sel(raddr[4]),
    .o(do[19]));
  AL_MUX \dram_do_mux_b190/al_mux_b0_0_0  (
    .i0(dram_do_i0_190),
    .i1(dram_do_i1_190),
    .sel(raddr[4]),
    .o(do[190]));
  AL_MUX \dram_do_mux_b191/al_mux_b0_0_0  (
    .i0(dram_do_i0_191),
    .i1(dram_do_i1_191),
    .sel(raddr[4]),
    .o(do[191]));
  AL_MUX \dram_do_mux_b192/al_mux_b0_0_0  (
    .i0(dram_do_i0_192),
    .i1(dram_do_i1_192),
    .sel(raddr[4]),
    .o(do[192]));
  AL_MUX \dram_do_mux_b193/al_mux_b0_0_0  (
    .i0(dram_do_i0_193),
    .i1(dram_do_i1_193),
    .sel(raddr[4]),
    .o(do[193]));
  AL_MUX \dram_do_mux_b194/al_mux_b0_0_0  (
    .i0(dram_do_i0_194),
    .i1(dram_do_i1_194),
    .sel(raddr[4]),
    .o(do[194]));
  AL_MUX \dram_do_mux_b195/al_mux_b0_0_0  (
    .i0(dram_do_i0_195),
    .i1(dram_do_i1_195),
    .sel(raddr[4]),
    .o(do[195]));
  AL_MUX \dram_do_mux_b196/al_mux_b0_0_0  (
    .i0(dram_do_i0_196),
    .i1(dram_do_i1_196),
    .sel(raddr[4]),
    .o(do[196]));
  AL_MUX \dram_do_mux_b197/al_mux_b0_0_0  (
    .i0(dram_do_i0_197),
    .i1(dram_do_i1_197),
    .sel(raddr[4]),
    .o(do[197]));
  AL_MUX \dram_do_mux_b198/al_mux_b0_0_0  (
    .i0(dram_do_i0_198),
    .i1(dram_do_i1_198),
    .sel(raddr[4]),
    .o(do[198]));
  AL_MUX \dram_do_mux_b199/al_mux_b0_0_0  (
    .i0(dram_do_i0_199),
    .i1(dram_do_i1_199),
    .sel(raddr[4]),
    .o(do[199]));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_0  (
    .i0(dram_do_i0_002),
    .i1(dram_do_i1_002),
    .sel(raddr[4]),
    .o(do[2]));
  AL_MUX \dram_do_mux_b20/al_mux_b0_0_0  (
    .i0(dram_do_i0_020),
    .i1(dram_do_i1_020),
    .sel(raddr[4]),
    .o(do[20]));
  AL_MUX \dram_do_mux_b200/al_mux_b0_0_0  (
    .i0(dram_do_i0_200),
    .i1(dram_do_i1_200),
    .sel(raddr[4]),
    .o(do[200]));
  AL_MUX \dram_do_mux_b201/al_mux_b0_0_0  (
    .i0(dram_do_i0_201),
    .i1(dram_do_i1_201),
    .sel(raddr[4]),
    .o(do[201]));
  AL_MUX \dram_do_mux_b202/al_mux_b0_0_0  (
    .i0(dram_do_i0_202),
    .i1(dram_do_i1_202),
    .sel(raddr[4]),
    .o(do[202]));
  AL_MUX \dram_do_mux_b203/al_mux_b0_0_0  (
    .i0(dram_do_i0_203),
    .i1(dram_do_i1_203),
    .sel(raddr[4]),
    .o(do[203]));
  AL_MUX \dram_do_mux_b204/al_mux_b0_0_0  (
    .i0(dram_do_i0_204),
    .i1(dram_do_i1_204),
    .sel(raddr[4]),
    .o(do[204]));
  AL_MUX \dram_do_mux_b205/al_mux_b0_0_0  (
    .i0(dram_do_i0_205),
    .i1(dram_do_i1_205),
    .sel(raddr[4]),
    .o(do[205]));
  AL_MUX \dram_do_mux_b206/al_mux_b0_0_0  (
    .i0(dram_do_i0_206),
    .i1(dram_do_i1_206),
    .sel(raddr[4]),
    .o(do[206]));
  AL_MUX \dram_do_mux_b207/al_mux_b0_0_0  (
    .i0(dram_do_i0_207),
    .i1(dram_do_i1_207),
    .sel(raddr[4]),
    .o(do[207]));
  AL_MUX \dram_do_mux_b208/al_mux_b0_0_0  (
    .i0(dram_do_i0_208),
    .i1(dram_do_i1_208),
    .sel(raddr[4]),
    .o(do[208]));
  AL_MUX \dram_do_mux_b209/al_mux_b0_0_0  (
    .i0(dram_do_i0_209),
    .i1(dram_do_i1_209),
    .sel(raddr[4]),
    .o(do[209]));
  AL_MUX \dram_do_mux_b21/al_mux_b0_0_0  (
    .i0(dram_do_i0_021),
    .i1(dram_do_i1_021),
    .sel(raddr[4]),
    .o(do[21]));
  AL_MUX \dram_do_mux_b210/al_mux_b0_0_0  (
    .i0(dram_do_i0_210),
    .i1(dram_do_i1_210),
    .sel(raddr[4]),
    .o(do[210]));
  AL_MUX \dram_do_mux_b211/al_mux_b0_0_0  (
    .i0(dram_do_i0_211),
    .i1(dram_do_i1_211),
    .sel(raddr[4]),
    .o(do[211]));
  AL_MUX \dram_do_mux_b212/al_mux_b0_0_0  (
    .i0(dram_do_i0_212),
    .i1(dram_do_i1_212),
    .sel(raddr[4]),
    .o(do[212]));
  AL_MUX \dram_do_mux_b213/al_mux_b0_0_0  (
    .i0(dram_do_i0_213),
    .i1(dram_do_i1_213),
    .sel(raddr[4]),
    .o(do[213]));
  AL_MUX \dram_do_mux_b214/al_mux_b0_0_0  (
    .i0(dram_do_i0_214),
    .i1(dram_do_i1_214),
    .sel(raddr[4]),
    .o(do[214]));
  AL_MUX \dram_do_mux_b215/al_mux_b0_0_0  (
    .i0(dram_do_i0_215),
    .i1(dram_do_i1_215),
    .sel(raddr[4]),
    .o(do[215]));
  AL_MUX \dram_do_mux_b216/al_mux_b0_0_0  (
    .i0(dram_do_i0_216),
    .i1(dram_do_i1_216),
    .sel(raddr[4]),
    .o(do[216]));
  AL_MUX \dram_do_mux_b217/al_mux_b0_0_0  (
    .i0(dram_do_i0_217),
    .i1(dram_do_i1_217),
    .sel(raddr[4]),
    .o(do[217]));
  AL_MUX \dram_do_mux_b218/al_mux_b0_0_0  (
    .i0(dram_do_i0_218),
    .i1(dram_do_i1_218),
    .sel(raddr[4]),
    .o(do[218]));
  AL_MUX \dram_do_mux_b219/al_mux_b0_0_0  (
    .i0(dram_do_i0_219),
    .i1(dram_do_i1_219),
    .sel(raddr[4]),
    .o(do[219]));
  AL_MUX \dram_do_mux_b22/al_mux_b0_0_0  (
    .i0(dram_do_i0_022),
    .i1(dram_do_i1_022),
    .sel(raddr[4]),
    .o(do[22]));
  AL_MUX \dram_do_mux_b220/al_mux_b0_0_0  (
    .i0(dram_do_i0_220),
    .i1(dram_do_i1_220),
    .sel(raddr[4]),
    .o(do[220]));
  AL_MUX \dram_do_mux_b221/al_mux_b0_0_0  (
    .i0(dram_do_i0_221),
    .i1(dram_do_i1_221),
    .sel(raddr[4]),
    .o(do[221]));
  AL_MUX \dram_do_mux_b222/al_mux_b0_0_0  (
    .i0(dram_do_i0_222),
    .i1(dram_do_i1_222),
    .sel(raddr[4]),
    .o(do[222]));
  AL_MUX \dram_do_mux_b223/al_mux_b0_0_0  (
    .i0(dram_do_i0_223),
    .i1(dram_do_i1_223),
    .sel(raddr[4]),
    .o(do[223]));
  AL_MUX \dram_do_mux_b224/al_mux_b0_0_0  (
    .i0(dram_do_i0_224),
    .i1(dram_do_i1_224),
    .sel(raddr[4]),
    .o(do[224]));
  AL_MUX \dram_do_mux_b225/al_mux_b0_0_0  (
    .i0(dram_do_i0_225),
    .i1(dram_do_i1_225),
    .sel(raddr[4]),
    .o(do[225]));
  AL_MUX \dram_do_mux_b226/al_mux_b0_0_0  (
    .i0(dram_do_i0_226),
    .i1(dram_do_i1_226),
    .sel(raddr[4]),
    .o(do[226]));
  AL_MUX \dram_do_mux_b227/al_mux_b0_0_0  (
    .i0(dram_do_i0_227),
    .i1(dram_do_i1_227),
    .sel(raddr[4]),
    .o(do[227]));
  AL_MUX \dram_do_mux_b228/al_mux_b0_0_0  (
    .i0(dram_do_i0_228),
    .i1(dram_do_i1_228),
    .sel(raddr[4]),
    .o(do[228]));
  AL_MUX \dram_do_mux_b229/al_mux_b0_0_0  (
    .i0(dram_do_i0_229),
    .i1(dram_do_i1_229),
    .sel(raddr[4]),
    .o(do[229]));
  AL_MUX \dram_do_mux_b23/al_mux_b0_0_0  (
    .i0(dram_do_i0_023),
    .i1(dram_do_i1_023),
    .sel(raddr[4]),
    .o(do[23]));
  AL_MUX \dram_do_mux_b230/al_mux_b0_0_0  (
    .i0(dram_do_i0_230),
    .i1(dram_do_i1_230),
    .sel(raddr[4]),
    .o(do[230]));
  AL_MUX \dram_do_mux_b231/al_mux_b0_0_0  (
    .i0(dram_do_i0_231),
    .i1(dram_do_i1_231),
    .sel(raddr[4]),
    .o(do[231]));
  AL_MUX \dram_do_mux_b232/al_mux_b0_0_0  (
    .i0(dram_do_i0_232),
    .i1(dram_do_i1_232),
    .sel(raddr[4]),
    .o(do[232]));
  AL_MUX \dram_do_mux_b233/al_mux_b0_0_0  (
    .i0(dram_do_i0_233),
    .i1(dram_do_i1_233),
    .sel(raddr[4]),
    .o(do[233]));
  AL_MUX \dram_do_mux_b234/al_mux_b0_0_0  (
    .i0(dram_do_i0_234),
    .i1(dram_do_i1_234),
    .sel(raddr[4]),
    .o(do[234]));
  AL_MUX \dram_do_mux_b235/al_mux_b0_0_0  (
    .i0(dram_do_i0_235),
    .i1(dram_do_i1_235),
    .sel(raddr[4]),
    .o(do[235]));
  AL_MUX \dram_do_mux_b236/al_mux_b0_0_0  (
    .i0(dram_do_i0_236),
    .i1(dram_do_i1_236),
    .sel(raddr[4]),
    .o(do[236]));
  AL_MUX \dram_do_mux_b237/al_mux_b0_0_0  (
    .i0(dram_do_i0_237),
    .i1(dram_do_i1_237),
    .sel(raddr[4]),
    .o(do[237]));
  AL_MUX \dram_do_mux_b238/al_mux_b0_0_0  (
    .i0(dram_do_i0_238),
    .i1(dram_do_i1_238),
    .sel(raddr[4]),
    .o(do[238]));
  AL_MUX \dram_do_mux_b239/al_mux_b0_0_0  (
    .i0(dram_do_i0_239),
    .i1(dram_do_i1_239),
    .sel(raddr[4]),
    .o(do[239]));
  AL_MUX \dram_do_mux_b24/al_mux_b0_0_0  (
    .i0(dram_do_i0_024),
    .i1(dram_do_i1_024),
    .sel(raddr[4]),
    .o(do[24]));
  AL_MUX \dram_do_mux_b240/al_mux_b0_0_0  (
    .i0(dram_do_i0_240),
    .i1(dram_do_i1_240),
    .sel(raddr[4]),
    .o(do[240]));
  AL_MUX \dram_do_mux_b241/al_mux_b0_0_0  (
    .i0(dram_do_i0_241),
    .i1(dram_do_i1_241),
    .sel(raddr[4]),
    .o(do[241]));
  AL_MUX \dram_do_mux_b242/al_mux_b0_0_0  (
    .i0(dram_do_i0_242),
    .i1(dram_do_i1_242),
    .sel(raddr[4]),
    .o(do[242]));
  AL_MUX \dram_do_mux_b243/al_mux_b0_0_0  (
    .i0(dram_do_i0_243),
    .i1(dram_do_i1_243),
    .sel(raddr[4]),
    .o(do[243]));
  AL_MUX \dram_do_mux_b244/al_mux_b0_0_0  (
    .i0(dram_do_i0_244),
    .i1(dram_do_i1_244),
    .sel(raddr[4]),
    .o(do[244]));
  AL_MUX \dram_do_mux_b245/al_mux_b0_0_0  (
    .i0(dram_do_i0_245),
    .i1(dram_do_i1_245),
    .sel(raddr[4]),
    .o(do[245]));
  AL_MUX \dram_do_mux_b246/al_mux_b0_0_0  (
    .i0(dram_do_i0_246),
    .i1(dram_do_i1_246),
    .sel(raddr[4]),
    .o(do[246]));
  AL_MUX \dram_do_mux_b247/al_mux_b0_0_0  (
    .i0(dram_do_i0_247),
    .i1(dram_do_i1_247),
    .sel(raddr[4]),
    .o(do[247]));
  AL_MUX \dram_do_mux_b248/al_mux_b0_0_0  (
    .i0(dram_do_i0_248),
    .i1(dram_do_i1_248),
    .sel(raddr[4]),
    .o(do[248]));
  AL_MUX \dram_do_mux_b249/al_mux_b0_0_0  (
    .i0(dram_do_i0_249),
    .i1(dram_do_i1_249),
    .sel(raddr[4]),
    .o(do[249]));
  AL_MUX \dram_do_mux_b25/al_mux_b0_0_0  (
    .i0(dram_do_i0_025),
    .i1(dram_do_i1_025),
    .sel(raddr[4]),
    .o(do[25]));
  AL_MUX \dram_do_mux_b250/al_mux_b0_0_0  (
    .i0(dram_do_i0_250),
    .i1(dram_do_i1_250),
    .sel(raddr[4]),
    .o(do[250]));
  AL_MUX \dram_do_mux_b251/al_mux_b0_0_0  (
    .i0(dram_do_i0_251),
    .i1(dram_do_i1_251),
    .sel(raddr[4]),
    .o(do[251]));
  AL_MUX \dram_do_mux_b252/al_mux_b0_0_0  (
    .i0(dram_do_i0_252),
    .i1(dram_do_i1_252),
    .sel(raddr[4]),
    .o(do[252]));
  AL_MUX \dram_do_mux_b253/al_mux_b0_0_0  (
    .i0(dram_do_i0_253),
    .i1(dram_do_i1_253),
    .sel(raddr[4]),
    .o(do[253]));
  AL_MUX \dram_do_mux_b254/al_mux_b0_0_0  (
    .i0(dram_do_i0_254),
    .i1(dram_do_i1_254),
    .sel(raddr[4]),
    .o(do[254]));
  AL_MUX \dram_do_mux_b255/al_mux_b0_0_0  (
    .i0(dram_do_i0_255),
    .i1(dram_do_i1_255),
    .sel(raddr[4]),
    .o(do[255]));
  AL_MUX \dram_do_mux_b26/al_mux_b0_0_0  (
    .i0(dram_do_i0_026),
    .i1(dram_do_i1_026),
    .sel(raddr[4]),
    .o(do[26]));
  AL_MUX \dram_do_mux_b27/al_mux_b0_0_0  (
    .i0(dram_do_i0_027),
    .i1(dram_do_i1_027),
    .sel(raddr[4]),
    .o(do[27]));
  AL_MUX \dram_do_mux_b28/al_mux_b0_0_0  (
    .i0(dram_do_i0_028),
    .i1(dram_do_i1_028),
    .sel(raddr[4]),
    .o(do[28]));
  AL_MUX \dram_do_mux_b29/al_mux_b0_0_0  (
    .i0(dram_do_i0_029),
    .i1(dram_do_i1_029),
    .sel(raddr[4]),
    .o(do[29]));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_0  (
    .i0(dram_do_i0_003),
    .i1(dram_do_i1_003),
    .sel(raddr[4]),
    .o(do[3]));
  AL_MUX \dram_do_mux_b30/al_mux_b0_0_0  (
    .i0(dram_do_i0_030),
    .i1(dram_do_i1_030),
    .sel(raddr[4]),
    .o(do[30]));
  AL_MUX \dram_do_mux_b31/al_mux_b0_0_0  (
    .i0(dram_do_i0_031),
    .i1(dram_do_i1_031),
    .sel(raddr[4]),
    .o(do[31]));
  AL_MUX \dram_do_mux_b32/al_mux_b0_0_0  (
    .i0(dram_do_i0_032),
    .i1(dram_do_i1_032),
    .sel(raddr[4]),
    .o(do[32]));
  AL_MUX \dram_do_mux_b33/al_mux_b0_0_0  (
    .i0(dram_do_i0_033),
    .i1(dram_do_i1_033),
    .sel(raddr[4]),
    .o(do[33]));
  AL_MUX \dram_do_mux_b34/al_mux_b0_0_0  (
    .i0(dram_do_i0_034),
    .i1(dram_do_i1_034),
    .sel(raddr[4]),
    .o(do[34]));
  AL_MUX \dram_do_mux_b35/al_mux_b0_0_0  (
    .i0(dram_do_i0_035),
    .i1(dram_do_i1_035),
    .sel(raddr[4]),
    .o(do[35]));
  AL_MUX \dram_do_mux_b36/al_mux_b0_0_0  (
    .i0(dram_do_i0_036),
    .i1(dram_do_i1_036),
    .sel(raddr[4]),
    .o(do[36]));
  AL_MUX \dram_do_mux_b37/al_mux_b0_0_0  (
    .i0(dram_do_i0_037),
    .i1(dram_do_i1_037),
    .sel(raddr[4]),
    .o(do[37]));
  AL_MUX \dram_do_mux_b38/al_mux_b0_0_0  (
    .i0(dram_do_i0_038),
    .i1(dram_do_i1_038),
    .sel(raddr[4]),
    .o(do[38]));
  AL_MUX \dram_do_mux_b39/al_mux_b0_0_0  (
    .i0(dram_do_i0_039),
    .i1(dram_do_i1_039),
    .sel(raddr[4]),
    .o(do[39]));
  AL_MUX \dram_do_mux_b4/al_mux_b0_0_0  (
    .i0(dram_do_i0_004),
    .i1(dram_do_i1_004),
    .sel(raddr[4]),
    .o(do[4]));
  AL_MUX \dram_do_mux_b40/al_mux_b0_0_0  (
    .i0(dram_do_i0_040),
    .i1(dram_do_i1_040),
    .sel(raddr[4]),
    .o(do[40]));
  AL_MUX \dram_do_mux_b41/al_mux_b0_0_0  (
    .i0(dram_do_i0_041),
    .i1(dram_do_i1_041),
    .sel(raddr[4]),
    .o(do[41]));
  AL_MUX \dram_do_mux_b42/al_mux_b0_0_0  (
    .i0(dram_do_i0_042),
    .i1(dram_do_i1_042),
    .sel(raddr[4]),
    .o(do[42]));
  AL_MUX \dram_do_mux_b43/al_mux_b0_0_0  (
    .i0(dram_do_i0_043),
    .i1(dram_do_i1_043),
    .sel(raddr[4]),
    .o(do[43]));
  AL_MUX \dram_do_mux_b44/al_mux_b0_0_0  (
    .i0(dram_do_i0_044),
    .i1(dram_do_i1_044),
    .sel(raddr[4]),
    .o(do[44]));
  AL_MUX \dram_do_mux_b45/al_mux_b0_0_0  (
    .i0(dram_do_i0_045),
    .i1(dram_do_i1_045),
    .sel(raddr[4]),
    .o(do[45]));
  AL_MUX \dram_do_mux_b46/al_mux_b0_0_0  (
    .i0(dram_do_i0_046),
    .i1(dram_do_i1_046),
    .sel(raddr[4]),
    .o(do[46]));
  AL_MUX \dram_do_mux_b47/al_mux_b0_0_0  (
    .i0(dram_do_i0_047),
    .i1(dram_do_i1_047),
    .sel(raddr[4]),
    .o(do[47]));
  AL_MUX \dram_do_mux_b48/al_mux_b0_0_0  (
    .i0(dram_do_i0_048),
    .i1(dram_do_i1_048),
    .sel(raddr[4]),
    .o(do[48]));
  AL_MUX \dram_do_mux_b49/al_mux_b0_0_0  (
    .i0(dram_do_i0_049),
    .i1(dram_do_i1_049),
    .sel(raddr[4]),
    .o(do[49]));
  AL_MUX \dram_do_mux_b5/al_mux_b0_0_0  (
    .i0(dram_do_i0_005),
    .i1(dram_do_i1_005),
    .sel(raddr[4]),
    .o(do[5]));
  AL_MUX \dram_do_mux_b50/al_mux_b0_0_0  (
    .i0(dram_do_i0_050),
    .i1(dram_do_i1_050),
    .sel(raddr[4]),
    .o(do[50]));
  AL_MUX \dram_do_mux_b51/al_mux_b0_0_0  (
    .i0(dram_do_i0_051),
    .i1(dram_do_i1_051),
    .sel(raddr[4]),
    .o(do[51]));
  AL_MUX \dram_do_mux_b52/al_mux_b0_0_0  (
    .i0(dram_do_i0_052),
    .i1(dram_do_i1_052),
    .sel(raddr[4]),
    .o(do[52]));
  AL_MUX \dram_do_mux_b53/al_mux_b0_0_0  (
    .i0(dram_do_i0_053),
    .i1(dram_do_i1_053),
    .sel(raddr[4]),
    .o(do[53]));
  AL_MUX \dram_do_mux_b54/al_mux_b0_0_0  (
    .i0(dram_do_i0_054),
    .i1(dram_do_i1_054),
    .sel(raddr[4]),
    .o(do[54]));
  AL_MUX \dram_do_mux_b55/al_mux_b0_0_0  (
    .i0(dram_do_i0_055),
    .i1(dram_do_i1_055),
    .sel(raddr[4]),
    .o(do[55]));
  AL_MUX \dram_do_mux_b56/al_mux_b0_0_0  (
    .i0(dram_do_i0_056),
    .i1(dram_do_i1_056),
    .sel(raddr[4]),
    .o(do[56]));
  AL_MUX \dram_do_mux_b57/al_mux_b0_0_0  (
    .i0(dram_do_i0_057),
    .i1(dram_do_i1_057),
    .sel(raddr[4]),
    .o(do[57]));
  AL_MUX \dram_do_mux_b58/al_mux_b0_0_0  (
    .i0(dram_do_i0_058),
    .i1(dram_do_i1_058),
    .sel(raddr[4]),
    .o(do[58]));
  AL_MUX \dram_do_mux_b59/al_mux_b0_0_0  (
    .i0(dram_do_i0_059),
    .i1(dram_do_i1_059),
    .sel(raddr[4]),
    .o(do[59]));
  AL_MUX \dram_do_mux_b6/al_mux_b0_0_0  (
    .i0(dram_do_i0_006),
    .i1(dram_do_i1_006),
    .sel(raddr[4]),
    .o(do[6]));
  AL_MUX \dram_do_mux_b60/al_mux_b0_0_0  (
    .i0(dram_do_i0_060),
    .i1(dram_do_i1_060),
    .sel(raddr[4]),
    .o(do[60]));
  AL_MUX \dram_do_mux_b61/al_mux_b0_0_0  (
    .i0(dram_do_i0_061),
    .i1(dram_do_i1_061),
    .sel(raddr[4]),
    .o(do[61]));
  AL_MUX \dram_do_mux_b62/al_mux_b0_0_0  (
    .i0(dram_do_i0_062),
    .i1(dram_do_i1_062),
    .sel(raddr[4]),
    .o(do[62]));
  AL_MUX \dram_do_mux_b63/al_mux_b0_0_0  (
    .i0(dram_do_i0_063),
    .i1(dram_do_i1_063),
    .sel(raddr[4]),
    .o(do[63]));
  AL_MUX \dram_do_mux_b64/al_mux_b0_0_0  (
    .i0(dram_do_i0_064),
    .i1(dram_do_i1_064),
    .sel(raddr[4]),
    .o(do[64]));
  AL_MUX \dram_do_mux_b65/al_mux_b0_0_0  (
    .i0(dram_do_i0_065),
    .i1(dram_do_i1_065),
    .sel(raddr[4]),
    .o(do[65]));
  AL_MUX \dram_do_mux_b66/al_mux_b0_0_0  (
    .i0(dram_do_i0_066),
    .i1(dram_do_i1_066),
    .sel(raddr[4]),
    .o(do[66]));
  AL_MUX \dram_do_mux_b67/al_mux_b0_0_0  (
    .i0(dram_do_i0_067),
    .i1(dram_do_i1_067),
    .sel(raddr[4]),
    .o(do[67]));
  AL_MUX \dram_do_mux_b68/al_mux_b0_0_0  (
    .i0(dram_do_i0_068),
    .i1(dram_do_i1_068),
    .sel(raddr[4]),
    .o(do[68]));
  AL_MUX \dram_do_mux_b69/al_mux_b0_0_0  (
    .i0(dram_do_i0_069),
    .i1(dram_do_i1_069),
    .sel(raddr[4]),
    .o(do[69]));
  AL_MUX \dram_do_mux_b7/al_mux_b0_0_0  (
    .i0(dram_do_i0_007),
    .i1(dram_do_i1_007),
    .sel(raddr[4]),
    .o(do[7]));
  AL_MUX \dram_do_mux_b70/al_mux_b0_0_0  (
    .i0(dram_do_i0_070),
    .i1(dram_do_i1_070),
    .sel(raddr[4]),
    .o(do[70]));
  AL_MUX \dram_do_mux_b71/al_mux_b0_0_0  (
    .i0(dram_do_i0_071),
    .i1(dram_do_i1_071),
    .sel(raddr[4]),
    .o(do[71]));
  AL_MUX \dram_do_mux_b72/al_mux_b0_0_0  (
    .i0(dram_do_i0_072),
    .i1(dram_do_i1_072),
    .sel(raddr[4]),
    .o(do[72]));
  AL_MUX \dram_do_mux_b73/al_mux_b0_0_0  (
    .i0(dram_do_i0_073),
    .i1(dram_do_i1_073),
    .sel(raddr[4]),
    .o(do[73]));
  AL_MUX \dram_do_mux_b74/al_mux_b0_0_0  (
    .i0(dram_do_i0_074),
    .i1(dram_do_i1_074),
    .sel(raddr[4]),
    .o(do[74]));
  AL_MUX \dram_do_mux_b75/al_mux_b0_0_0  (
    .i0(dram_do_i0_075),
    .i1(dram_do_i1_075),
    .sel(raddr[4]),
    .o(do[75]));
  AL_MUX \dram_do_mux_b76/al_mux_b0_0_0  (
    .i0(dram_do_i0_076),
    .i1(dram_do_i1_076),
    .sel(raddr[4]),
    .o(do[76]));
  AL_MUX \dram_do_mux_b77/al_mux_b0_0_0  (
    .i0(dram_do_i0_077),
    .i1(dram_do_i1_077),
    .sel(raddr[4]),
    .o(do[77]));
  AL_MUX \dram_do_mux_b78/al_mux_b0_0_0  (
    .i0(dram_do_i0_078),
    .i1(dram_do_i1_078),
    .sel(raddr[4]),
    .o(do[78]));
  AL_MUX \dram_do_mux_b79/al_mux_b0_0_0  (
    .i0(dram_do_i0_079),
    .i1(dram_do_i1_079),
    .sel(raddr[4]),
    .o(do[79]));
  AL_MUX \dram_do_mux_b8/al_mux_b0_0_0  (
    .i0(dram_do_i0_008),
    .i1(dram_do_i1_008),
    .sel(raddr[4]),
    .o(do[8]));
  AL_MUX \dram_do_mux_b80/al_mux_b0_0_0  (
    .i0(dram_do_i0_080),
    .i1(dram_do_i1_080),
    .sel(raddr[4]),
    .o(do[80]));
  AL_MUX \dram_do_mux_b81/al_mux_b0_0_0  (
    .i0(dram_do_i0_081),
    .i1(dram_do_i1_081),
    .sel(raddr[4]),
    .o(do[81]));
  AL_MUX \dram_do_mux_b82/al_mux_b0_0_0  (
    .i0(dram_do_i0_082),
    .i1(dram_do_i1_082),
    .sel(raddr[4]),
    .o(do[82]));
  AL_MUX \dram_do_mux_b83/al_mux_b0_0_0  (
    .i0(dram_do_i0_083),
    .i1(dram_do_i1_083),
    .sel(raddr[4]),
    .o(do[83]));
  AL_MUX \dram_do_mux_b84/al_mux_b0_0_0  (
    .i0(dram_do_i0_084),
    .i1(dram_do_i1_084),
    .sel(raddr[4]),
    .o(do[84]));
  AL_MUX \dram_do_mux_b85/al_mux_b0_0_0  (
    .i0(dram_do_i0_085),
    .i1(dram_do_i1_085),
    .sel(raddr[4]),
    .o(do[85]));
  AL_MUX \dram_do_mux_b86/al_mux_b0_0_0  (
    .i0(dram_do_i0_086),
    .i1(dram_do_i1_086),
    .sel(raddr[4]),
    .o(do[86]));
  AL_MUX \dram_do_mux_b87/al_mux_b0_0_0  (
    .i0(dram_do_i0_087),
    .i1(dram_do_i1_087),
    .sel(raddr[4]),
    .o(do[87]));
  AL_MUX \dram_do_mux_b88/al_mux_b0_0_0  (
    .i0(dram_do_i0_088),
    .i1(dram_do_i1_088),
    .sel(raddr[4]),
    .o(do[88]));
  AL_MUX \dram_do_mux_b89/al_mux_b0_0_0  (
    .i0(dram_do_i0_089),
    .i1(dram_do_i1_089),
    .sel(raddr[4]),
    .o(do[89]));
  AL_MUX \dram_do_mux_b9/al_mux_b0_0_0  (
    .i0(dram_do_i0_009),
    .i1(dram_do_i1_009),
    .sel(raddr[4]),
    .o(do[9]));
  AL_MUX \dram_do_mux_b90/al_mux_b0_0_0  (
    .i0(dram_do_i0_090),
    .i1(dram_do_i1_090),
    .sel(raddr[4]),
    .o(do[90]));
  AL_MUX \dram_do_mux_b91/al_mux_b0_0_0  (
    .i0(dram_do_i0_091),
    .i1(dram_do_i1_091),
    .sel(raddr[4]),
    .o(do[91]));
  AL_MUX \dram_do_mux_b92/al_mux_b0_0_0  (
    .i0(dram_do_i0_092),
    .i1(dram_do_i1_092),
    .sel(raddr[4]),
    .o(do[92]));
  AL_MUX \dram_do_mux_b93/al_mux_b0_0_0  (
    .i0(dram_do_i0_093),
    .i1(dram_do_i1_093),
    .sel(raddr[4]),
    .o(do[93]));
  AL_MUX \dram_do_mux_b94/al_mux_b0_0_0  (
    .i0(dram_do_i0_094),
    .i1(dram_do_i1_094),
    .sel(raddr[4]),
    .o(do[94]));
  AL_MUX \dram_do_mux_b95/al_mux_b0_0_0  (
    .i0(dram_do_i0_095),
    .i1(dram_do_i1_095),
    .sel(raddr[4]),
    .o(do[95]));
  AL_MUX \dram_do_mux_b96/al_mux_b0_0_0  (
    .i0(dram_do_i0_096),
    .i1(dram_do_i1_096),
    .sel(raddr[4]),
    .o(do[96]));
  AL_MUX \dram_do_mux_b97/al_mux_b0_0_0  (
    .i0(dram_do_i0_097),
    .i1(dram_do_i1_097),
    .sel(raddr[4]),
    .o(do[97]));
  AL_MUX \dram_do_mux_b98/al_mux_b0_0_0  (
    .i0(dram_do_i0_098),
    .i1(dram_do_i1_098),
    .sel(raddr[4]),
    .o(do[98]));
  AL_MUX \dram_do_mux_b99/al_mux_b0_0_0  (
    .i0(dram_do_i0_099),
    .i1(dram_do_i1_099),
    .sel(raddr[4]),
    .o(do[99]));
  EG_LOGIC_DRAM16X4 dram_r0_c0 (
    .di(di[3:0]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_003,dram_do_i0_002,dram_do_i0_001,dram_do_i0_000}));
  EG_LOGIC_DRAM16X4 dram_r0_c1 (
    .di(di[7:4]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_007,dram_do_i0_006,dram_do_i0_005,dram_do_i0_004}));
  EG_LOGIC_DRAM16X4 dram_r0_c10 (
    .di(di[43:40]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_043,dram_do_i0_042,dram_do_i0_041,dram_do_i0_040}));
  EG_LOGIC_DRAM16X4 dram_r0_c11 (
    .di(di[47:44]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_047,dram_do_i0_046,dram_do_i0_045,dram_do_i0_044}));
  EG_LOGIC_DRAM16X4 dram_r0_c12 (
    .di(di[51:48]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_051,dram_do_i0_050,dram_do_i0_049,dram_do_i0_048}));
  EG_LOGIC_DRAM16X4 dram_r0_c13 (
    .di(di[55:52]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_055,dram_do_i0_054,dram_do_i0_053,dram_do_i0_052}));
  EG_LOGIC_DRAM16X4 dram_r0_c14 (
    .di(di[59:56]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_059,dram_do_i0_058,dram_do_i0_057,dram_do_i0_056}));
  EG_LOGIC_DRAM16X4 dram_r0_c15 (
    .di(di[63:60]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_063,dram_do_i0_062,dram_do_i0_061,dram_do_i0_060}));
  EG_LOGIC_DRAM16X4 dram_r0_c16 (
    .di(di[67:64]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_067,dram_do_i0_066,dram_do_i0_065,dram_do_i0_064}));
  EG_LOGIC_DRAM16X4 dram_r0_c17 (
    .di(di[71:68]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_071,dram_do_i0_070,dram_do_i0_069,dram_do_i0_068}));
  EG_LOGIC_DRAM16X4 dram_r0_c18 (
    .di(di[75:72]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_075,dram_do_i0_074,dram_do_i0_073,dram_do_i0_072}));
  EG_LOGIC_DRAM16X4 dram_r0_c19 (
    .di(di[79:76]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_079,dram_do_i0_078,dram_do_i0_077,dram_do_i0_076}));
  EG_LOGIC_DRAM16X4 dram_r0_c2 (
    .di(di[11:8]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_011,dram_do_i0_010,dram_do_i0_009,dram_do_i0_008}));
  EG_LOGIC_DRAM16X4 dram_r0_c20 (
    .di(di[83:80]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_083,dram_do_i0_082,dram_do_i0_081,dram_do_i0_080}));
  EG_LOGIC_DRAM16X4 dram_r0_c21 (
    .di(di[87:84]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_087,dram_do_i0_086,dram_do_i0_085,dram_do_i0_084}));
  EG_LOGIC_DRAM16X4 dram_r0_c22 (
    .di(di[91:88]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_091,dram_do_i0_090,dram_do_i0_089,dram_do_i0_088}));
  EG_LOGIC_DRAM16X4 dram_r0_c23 (
    .di(di[95:92]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_095,dram_do_i0_094,dram_do_i0_093,dram_do_i0_092}));
  EG_LOGIC_DRAM16X4 dram_r0_c24 (
    .di(di[99:96]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_099,dram_do_i0_098,dram_do_i0_097,dram_do_i0_096}));
  EG_LOGIC_DRAM16X4 dram_r0_c25 (
    .di(di[103:100]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_103,dram_do_i0_102,dram_do_i0_101,dram_do_i0_100}));
  EG_LOGIC_DRAM16X4 dram_r0_c26 (
    .di(di[107:104]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_107,dram_do_i0_106,dram_do_i0_105,dram_do_i0_104}));
  EG_LOGIC_DRAM16X4 dram_r0_c27 (
    .di(di[111:108]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_111,dram_do_i0_110,dram_do_i0_109,dram_do_i0_108}));
  EG_LOGIC_DRAM16X4 dram_r0_c28 (
    .di(di[115:112]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_115,dram_do_i0_114,dram_do_i0_113,dram_do_i0_112}));
  EG_LOGIC_DRAM16X4 dram_r0_c29 (
    .di(di[119:116]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_119,dram_do_i0_118,dram_do_i0_117,dram_do_i0_116}));
  EG_LOGIC_DRAM16X4 dram_r0_c3 (
    .di(di[15:12]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_015,dram_do_i0_014,dram_do_i0_013,dram_do_i0_012}));
  EG_LOGIC_DRAM16X4 dram_r0_c30 (
    .di(di[123:120]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_123,dram_do_i0_122,dram_do_i0_121,dram_do_i0_120}));
  EG_LOGIC_DRAM16X4 dram_r0_c31 (
    .di(di[127:124]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_127,dram_do_i0_126,dram_do_i0_125,dram_do_i0_124}));
  EG_LOGIC_DRAM16X4 dram_r0_c32 (
    .di(di[131:128]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_131,dram_do_i0_130,dram_do_i0_129,dram_do_i0_128}));
  EG_LOGIC_DRAM16X4 dram_r0_c33 (
    .di(di[135:132]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_135,dram_do_i0_134,dram_do_i0_133,dram_do_i0_132}));
  EG_LOGIC_DRAM16X4 dram_r0_c34 (
    .di(di[139:136]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_139,dram_do_i0_138,dram_do_i0_137,dram_do_i0_136}));
  EG_LOGIC_DRAM16X4 dram_r0_c35 (
    .di(di[143:140]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_143,dram_do_i0_142,dram_do_i0_141,dram_do_i0_140}));
  EG_LOGIC_DRAM16X4 dram_r0_c36 (
    .di(di[147:144]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_147,dram_do_i0_146,dram_do_i0_145,dram_do_i0_144}));
  EG_LOGIC_DRAM16X4 dram_r0_c37 (
    .di(di[151:148]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_151,dram_do_i0_150,dram_do_i0_149,dram_do_i0_148}));
  EG_LOGIC_DRAM16X4 dram_r0_c38 (
    .di(di[155:152]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_155,dram_do_i0_154,dram_do_i0_153,dram_do_i0_152}));
  EG_LOGIC_DRAM16X4 dram_r0_c39 (
    .di(di[159:156]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_159,dram_do_i0_158,dram_do_i0_157,dram_do_i0_156}));
  EG_LOGIC_DRAM16X4 dram_r0_c4 (
    .di(di[19:16]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_019,dram_do_i0_018,dram_do_i0_017,dram_do_i0_016}));
  EG_LOGIC_DRAM16X4 dram_r0_c40 (
    .di(di[163:160]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_163,dram_do_i0_162,dram_do_i0_161,dram_do_i0_160}));
  EG_LOGIC_DRAM16X4 dram_r0_c41 (
    .di(di[167:164]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_167,dram_do_i0_166,dram_do_i0_165,dram_do_i0_164}));
  EG_LOGIC_DRAM16X4 dram_r0_c42 (
    .di(di[171:168]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_171,dram_do_i0_170,dram_do_i0_169,dram_do_i0_168}));
  EG_LOGIC_DRAM16X4 dram_r0_c43 (
    .di(di[175:172]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_175,dram_do_i0_174,dram_do_i0_173,dram_do_i0_172}));
  EG_LOGIC_DRAM16X4 dram_r0_c44 (
    .di(di[179:176]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_179,dram_do_i0_178,dram_do_i0_177,dram_do_i0_176}));
  EG_LOGIC_DRAM16X4 dram_r0_c45 (
    .di(di[183:180]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_183,dram_do_i0_182,dram_do_i0_181,dram_do_i0_180}));
  EG_LOGIC_DRAM16X4 dram_r0_c46 (
    .di(di[187:184]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_187,dram_do_i0_186,dram_do_i0_185,dram_do_i0_184}));
  EG_LOGIC_DRAM16X4 dram_r0_c47 (
    .di(di[191:188]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_191,dram_do_i0_190,dram_do_i0_189,dram_do_i0_188}));
  EG_LOGIC_DRAM16X4 dram_r0_c48 (
    .di(di[195:192]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_195,dram_do_i0_194,dram_do_i0_193,dram_do_i0_192}));
  EG_LOGIC_DRAM16X4 dram_r0_c49 (
    .di(di[199:196]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_199,dram_do_i0_198,dram_do_i0_197,dram_do_i0_196}));
  EG_LOGIC_DRAM16X4 dram_r0_c5 (
    .di(di[23:20]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_023,dram_do_i0_022,dram_do_i0_021,dram_do_i0_020}));
  EG_LOGIC_DRAM16X4 dram_r0_c50 (
    .di(di[203:200]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_203,dram_do_i0_202,dram_do_i0_201,dram_do_i0_200}));
  EG_LOGIC_DRAM16X4 dram_r0_c51 (
    .di(di[207:204]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_207,dram_do_i0_206,dram_do_i0_205,dram_do_i0_204}));
  EG_LOGIC_DRAM16X4 dram_r0_c52 (
    .di(di[211:208]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_211,dram_do_i0_210,dram_do_i0_209,dram_do_i0_208}));
  EG_LOGIC_DRAM16X4 dram_r0_c53 (
    .di(di[215:212]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_215,dram_do_i0_214,dram_do_i0_213,dram_do_i0_212}));
  EG_LOGIC_DRAM16X4 dram_r0_c54 (
    .di(di[219:216]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_219,dram_do_i0_218,dram_do_i0_217,dram_do_i0_216}));
  EG_LOGIC_DRAM16X4 dram_r0_c55 (
    .di(di[223:220]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_223,dram_do_i0_222,dram_do_i0_221,dram_do_i0_220}));
  EG_LOGIC_DRAM16X4 dram_r0_c56 (
    .di(di[227:224]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_227,dram_do_i0_226,dram_do_i0_225,dram_do_i0_224}));
  EG_LOGIC_DRAM16X4 dram_r0_c57 (
    .di(di[231:228]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_231,dram_do_i0_230,dram_do_i0_229,dram_do_i0_228}));
  EG_LOGIC_DRAM16X4 dram_r0_c58 (
    .di(di[235:232]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_235,dram_do_i0_234,dram_do_i0_233,dram_do_i0_232}));
  EG_LOGIC_DRAM16X4 dram_r0_c59 (
    .di(di[239:236]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_239,dram_do_i0_238,dram_do_i0_237,dram_do_i0_236}));
  EG_LOGIC_DRAM16X4 dram_r0_c6 (
    .di(di[27:24]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_027,dram_do_i0_026,dram_do_i0_025,dram_do_i0_024}));
  EG_LOGIC_DRAM16X4 dram_r0_c60 (
    .di(di[243:240]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_243,dram_do_i0_242,dram_do_i0_241,dram_do_i0_240}));
  EG_LOGIC_DRAM16X4 dram_r0_c61 (
    .di(di[247:244]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_247,dram_do_i0_246,dram_do_i0_245,dram_do_i0_244}));
  EG_LOGIC_DRAM16X4 dram_r0_c62 (
    .di(di[251:248]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_251,dram_do_i0_250,dram_do_i0_249,dram_do_i0_248}));
  EG_LOGIC_DRAM16X4 dram_r0_c63 (
    .di(di[255:252]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_255,dram_do_i0_254,dram_do_i0_253,dram_do_i0_252}));
  EG_LOGIC_DRAM16X4 dram_r0_c7 (
    .di(di[31:28]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_031,dram_do_i0_030,dram_do_i0_029,dram_do_i0_028}));
  EG_LOGIC_DRAM16X4 dram_r0_c8 (
    .di(di[35:32]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_035,dram_do_i0_034,dram_do_i0_033,dram_do_i0_032}));
  EG_LOGIC_DRAM16X4 dram_r0_c9 (
    .di(di[39:36]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0),
    .do({dram_do_i0_039,dram_do_i0_038,dram_do_i0_037,dram_do_i0_036}));
  EG_LOGIC_DRAM16X4 dram_r1_c0 (
    .di(di[3:0]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_003,dram_do_i1_002,dram_do_i1_001,dram_do_i1_000}));
  EG_LOGIC_DRAM16X4 dram_r1_c1 (
    .di(di[7:4]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_007,dram_do_i1_006,dram_do_i1_005,dram_do_i1_004}));
  EG_LOGIC_DRAM16X4 dram_r1_c10 (
    .di(di[43:40]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_043,dram_do_i1_042,dram_do_i1_041,dram_do_i1_040}));
  EG_LOGIC_DRAM16X4 dram_r1_c11 (
    .di(di[47:44]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_047,dram_do_i1_046,dram_do_i1_045,dram_do_i1_044}));
  EG_LOGIC_DRAM16X4 dram_r1_c12 (
    .di(di[51:48]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_051,dram_do_i1_050,dram_do_i1_049,dram_do_i1_048}));
  EG_LOGIC_DRAM16X4 dram_r1_c13 (
    .di(di[55:52]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_055,dram_do_i1_054,dram_do_i1_053,dram_do_i1_052}));
  EG_LOGIC_DRAM16X4 dram_r1_c14 (
    .di(di[59:56]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_059,dram_do_i1_058,dram_do_i1_057,dram_do_i1_056}));
  EG_LOGIC_DRAM16X4 dram_r1_c15 (
    .di(di[63:60]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_063,dram_do_i1_062,dram_do_i1_061,dram_do_i1_060}));
  EG_LOGIC_DRAM16X4 dram_r1_c16 (
    .di(di[67:64]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_067,dram_do_i1_066,dram_do_i1_065,dram_do_i1_064}));
  EG_LOGIC_DRAM16X4 dram_r1_c17 (
    .di(di[71:68]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_071,dram_do_i1_070,dram_do_i1_069,dram_do_i1_068}));
  EG_LOGIC_DRAM16X4 dram_r1_c18 (
    .di(di[75:72]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_075,dram_do_i1_074,dram_do_i1_073,dram_do_i1_072}));
  EG_LOGIC_DRAM16X4 dram_r1_c19 (
    .di(di[79:76]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_079,dram_do_i1_078,dram_do_i1_077,dram_do_i1_076}));
  EG_LOGIC_DRAM16X4 dram_r1_c2 (
    .di(di[11:8]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_011,dram_do_i1_010,dram_do_i1_009,dram_do_i1_008}));
  EG_LOGIC_DRAM16X4 dram_r1_c20 (
    .di(di[83:80]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_083,dram_do_i1_082,dram_do_i1_081,dram_do_i1_080}));
  EG_LOGIC_DRAM16X4 dram_r1_c21 (
    .di(di[87:84]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_087,dram_do_i1_086,dram_do_i1_085,dram_do_i1_084}));
  EG_LOGIC_DRAM16X4 dram_r1_c22 (
    .di(di[91:88]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_091,dram_do_i1_090,dram_do_i1_089,dram_do_i1_088}));
  EG_LOGIC_DRAM16X4 dram_r1_c23 (
    .di(di[95:92]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_095,dram_do_i1_094,dram_do_i1_093,dram_do_i1_092}));
  EG_LOGIC_DRAM16X4 dram_r1_c24 (
    .di(di[99:96]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_099,dram_do_i1_098,dram_do_i1_097,dram_do_i1_096}));
  EG_LOGIC_DRAM16X4 dram_r1_c25 (
    .di(di[103:100]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_103,dram_do_i1_102,dram_do_i1_101,dram_do_i1_100}));
  EG_LOGIC_DRAM16X4 dram_r1_c26 (
    .di(di[107:104]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_107,dram_do_i1_106,dram_do_i1_105,dram_do_i1_104}));
  EG_LOGIC_DRAM16X4 dram_r1_c27 (
    .di(di[111:108]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_111,dram_do_i1_110,dram_do_i1_109,dram_do_i1_108}));
  EG_LOGIC_DRAM16X4 dram_r1_c28 (
    .di(di[115:112]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_115,dram_do_i1_114,dram_do_i1_113,dram_do_i1_112}));
  EG_LOGIC_DRAM16X4 dram_r1_c29 (
    .di(di[119:116]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_119,dram_do_i1_118,dram_do_i1_117,dram_do_i1_116}));
  EG_LOGIC_DRAM16X4 dram_r1_c3 (
    .di(di[15:12]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_015,dram_do_i1_014,dram_do_i1_013,dram_do_i1_012}));
  EG_LOGIC_DRAM16X4 dram_r1_c30 (
    .di(di[123:120]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_123,dram_do_i1_122,dram_do_i1_121,dram_do_i1_120}));
  EG_LOGIC_DRAM16X4 dram_r1_c31 (
    .di(di[127:124]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_127,dram_do_i1_126,dram_do_i1_125,dram_do_i1_124}));
  EG_LOGIC_DRAM16X4 dram_r1_c32 (
    .di(di[131:128]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_131,dram_do_i1_130,dram_do_i1_129,dram_do_i1_128}));
  EG_LOGIC_DRAM16X4 dram_r1_c33 (
    .di(di[135:132]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_135,dram_do_i1_134,dram_do_i1_133,dram_do_i1_132}));
  EG_LOGIC_DRAM16X4 dram_r1_c34 (
    .di(di[139:136]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_139,dram_do_i1_138,dram_do_i1_137,dram_do_i1_136}));
  EG_LOGIC_DRAM16X4 dram_r1_c35 (
    .di(di[143:140]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_143,dram_do_i1_142,dram_do_i1_141,dram_do_i1_140}));
  EG_LOGIC_DRAM16X4 dram_r1_c36 (
    .di(di[147:144]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_147,dram_do_i1_146,dram_do_i1_145,dram_do_i1_144}));
  EG_LOGIC_DRAM16X4 dram_r1_c37 (
    .di(di[151:148]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_151,dram_do_i1_150,dram_do_i1_149,dram_do_i1_148}));
  EG_LOGIC_DRAM16X4 dram_r1_c38 (
    .di(di[155:152]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_155,dram_do_i1_154,dram_do_i1_153,dram_do_i1_152}));
  EG_LOGIC_DRAM16X4 dram_r1_c39 (
    .di(di[159:156]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_159,dram_do_i1_158,dram_do_i1_157,dram_do_i1_156}));
  EG_LOGIC_DRAM16X4 dram_r1_c4 (
    .di(di[19:16]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_019,dram_do_i1_018,dram_do_i1_017,dram_do_i1_016}));
  EG_LOGIC_DRAM16X4 dram_r1_c40 (
    .di(di[163:160]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_163,dram_do_i1_162,dram_do_i1_161,dram_do_i1_160}));
  EG_LOGIC_DRAM16X4 dram_r1_c41 (
    .di(di[167:164]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_167,dram_do_i1_166,dram_do_i1_165,dram_do_i1_164}));
  EG_LOGIC_DRAM16X4 dram_r1_c42 (
    .di(di[171:168]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_171,dram_do_i1_170,dram_do_i1_169,dram_do_i1_168}));
  EG_LOGIC_DRAM16X4 dram_r1_c43 (
    .di(di[175:172]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_175,dram_do_i1_174,dram_do_i1_173,dram_do_i1_172}));
  EG_LOGIC_DRAM16X4 dram_r1_c44 (
    .di(di[179:176]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_179,dram_do_i1_178,dram_do_i1_177,dram_do_i1_176}));
  EG_LOGIC_DRAM16X4 dram_r1_c45 (
    .di(di[183:180]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_183,dram_do_i1_182,dram_do_i1_181,dram_do_i1_180}));
  EG_LOGIC_DRAM16X4 dram_r1_c46 (
    .di(di[187:184]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_187,dram_do_i1_186,dram_do_i1_185,dram_do_i1_184}));
  EG_LOGIC_DRAM16X4 dram_r1_c47 (
    .di(di[191:188]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_191,dram_do_i1_190,dram_do_i1_189,dram_do_i1_188}));
  EG_LOGIC_DRAM16X4 dram_r1_c48 (
    .di(di[195:192]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_195,dram_do_i1_194,dram_do_i1_193,dram_do_i1_192}));
  EG_LOGIC_DRAM16X4 dram_r1_c49 (
    .di(di[199:196]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_199,dram_do_i1_198,dram_do_i1_197,dram_do_i1_196}));
  EG_LOGIC_DRAM16X4 dram_r1_c5 (
    .di(di[23:20]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_023,dram_do_i1_022,dram_do_i1_021,dram_do_i1_020}));
  EG_LOGIC_DRAM16X4 dram_r1_c50 (
    .di(di[203:200]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_203,dram_do_i1_202,dram_do_i1_201,dram_do_i1_200}));
  EG_LOGIC_DRAM16X4 dram_r1_c51 (
    .di(di[207:204]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_207,dram_do_i1_206,dram_do_i1_205,dram_do_i1_204}));
  EG_LOGIC_DRAM16X4 dram_r1_c52 (
    .di(di[211:208]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_211,dram_do_i1_210,dram_do_i1_209,dram_do_i1_208}));
  EG_LOGIC_DRAM16X4 dram_r1_c53 (
    .di(di[215:212]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_215,dram_do_i1_214,dram_do_i1_213,dram_do_i1_212}));
  EG_LOGIC_DRAM16X4 dram_r1_c54 (
    .di(di[219:216]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_219,dram_do_i1_218,dram_do_i1_217,dram_do_i1_216}));
  EG_LOGIC_DRAM16X4 dram_r1_c55 (
    .di(di[223:220]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_223,dram_do_i1_222,dram_do_i1_221,dram_do_i1_220}));
  EG_LOGIC_DRAM16X4 dram_r1_c56 (
    .di(di[227:224]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_227,dram_do_i1_226,dram_do_i1_225,dram_do_i1_224}));
  EG_LOGIC_DRAM16X4 dram_r1_c57 (
    .di(di[231:228]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_231,dram_do_i1_230,dram_do_i1_229,dram_do_i1_228}));
  EG_LOGIC_DRAM16X4 dram_r1_c58 (
    .di(di[235:232]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_235,dram_do_i1_234,dram_do_i1_233,dram_do_i1_232}));
  EG_LOGIC_DRAM16X4 dram_r1_c59 (
    .di(di[239:236]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_239,dram_do_i1_238,dram_do_i1_237,dram_do_i1_236}));
  EG_LOGIC_DRAM16X4 dram_r1_c6 (
    .di(di[27:24]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_027,dram_do_i1_026,dram_do_i1_025,dram_do_i1_024}));
  EG_LOGIC_DRAM16X4 dram_r1_c60 (
    .di(di[243:240]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_243,dram_do_i1_242,dram_do_i1_241,dram_do_i1_240}));
  EG_LOGIC_DRAM16X4 dram_r1_c61 (
    .di(di[247:244]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_247,dram_do_i1_246,dram_do_i1_245,dram_do_i1_244}));
  EG_LOGIC_DRAM16X4 dram_r1_c62 (
    .di(di[251:248]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_251,dram_do_i1_250,dram_do_i1_249,dram_do_i1_248}));
  EG_LOGIC_DRAM16X4 dram_r1_c63 (
    .di(di[255:252]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_255,dram_do_i1_254,dram_do_i1_253,dram_do_i1_252}));
  EG_LOGIC_DRAM16X4 dram_r1_c7 (
    .di(di[31:28]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_031,dram_do_i1_030,dram_do_i1_029,dram_do_i1_028}));
  EG_LOGIC_DRAM16X4 dram_r1_c8 (
    .di(di[35:32]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_035,dram_do_i1_034,dram_do_i1_033,dram_do_i1_032}));
  EG_LOGIC_DRAM16X4 dram_r1_c9 (
    .di(di[39:36]),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1),
    .do({dram_do_i1_039,dram_do_i1_038,dram_do_i1_037,dram_do_i1_036}));
  not \waddr[4]_inv  (\waddr[4]_neg , waddr[4]);
  and we_0i (we_0, we, \waddr[4]_neg );
  and we_1i (we_1, we, waddr[4]);

endmodule 

