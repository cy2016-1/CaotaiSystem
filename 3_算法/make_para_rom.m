clc;
clear all;
close all;
% 本代码的作用是生成供FPGA使用的查找表，查找表的内容是神经网络的参数
FL_IN = 7;
FL_WE = 12;
FL_OU = 7;
PE_NUM = 16;
DEPTH = 512;
coe_data = zeros(DEPTH,PE_NUM*2);
coe_hexs = zeros(DEPTH,PE_NUM*2*4);
k = 1;
%% 第一个神经网络
filename = 'model_weights_angle.h5';
dens0_bias = h5read(filename,'/dense/dense/bias:0');
dens0_wght = h5read(filename,'/dense/dense/kernel:0');
dens1_bias = h5read(filename,'/dense_1/dense_1/bias:0');
dens1_wght = h5read(filename,'/dense_1/dense_1/kernel:0');
dens2_bias = h5read(filename,'/dense_2/dense_2/bias:0');
dens2_wght = h5read(filename,'/dense_2/dense_2/kernel:0');
[coe_data, k] = make_coe_layer(dens0_wght, dens0_bias, coe_data, k, PE_NUM);
[coe_data, k] = make_coe_layer(dens1_wght, dens1_bias, coe_data, k, PE_NUM);
[coe_data, k] = make_coe_layer(dens2_wght, dens2_bias, coe_data, k, PE_NUM);
%% 第二个神经网络
filename = 'model_weights_draw.h5';
dens0_bias = h5read(filename,'/dense/dense/bias:0');
dens0_wght = h5read(filename,'/dense/dense/kernel:0');
dens1_bias = h5read(filename,'/dense_1/dense_1/bias:0');
dens1_wght = h5read(filename,'/dense_1/dense_1/kernel:0');
dens2_bias = h5read(filename,'/dense_2/dense_2/bias:0');
dens2_wght = h5read(filename,'/dense_2/dense_2/kernel:0');
dens3_bias = h5read(filename,'/dense_3/dense_3/bias:0');
dens3_wght = h5read(filename,'/dense_3/dense_3/kernel:0');
[coe_data, k] = make_coe_layer(dens0_wght, dens0_bias, coe_data, k, PE_NUM);
[coe_data, k] = make_coe_layer(dens1_wght, dens1_bias, coe_data, k, PE_NUM);
[coe_data, k] = make_coe_layer(dens2_wght, dens2_bias, coe_data, k, PE_NUM);
[coe_data, k] = make_coe_layer(dens3_wght, dens3_bias, coe_data, k, PE_NUM);
%% 写入文件
dec_data = floor(coe_data*2^FL_WE);
dec_data(dec_data<0) = dec_data(dec_data<0) + 65536;
for i=1:DEPTH
    for j=1:PE_NUM*2
        sss = dec2hex(dec_data(i,j),4);
        coe_hexs(i,j*4-3:j*4) = sss;
    end
end
fid = fopen('para.coe','w');
fprintf(fid,'memory_initialization_radix = 16;\n');
fprintf(fid,'memory_initialization_vector = ');
fprintf(fid,'%s',coe_hexs(1,:));
for i=2:DEPTH
    fprintf(fid,',\n%s',coe_hexs(i,:));
end
fprintf(fid,';\n');
fclose(fid);
%% 写mif
fid = fopen('para.mif','w');
fprintf(fid,'DEPTH=512;\n');
fprintf(fid,'WIDTH=512;\n');
fprintf(fid,'ADDRESS_RADIX=HEX;\n');
fprintf(fid,'DATA_RADIX=HEX;\n');
fprintf(fid,'CONTENT\n');
fprintf(fid,'BEGIN\n');
for i=1:512
    addr = dec2hex(i-1,3);
    data = coe_hexs(i,:);
    fprintf(fid,'%s:%s;\n',addr,data);
end
fprintf(fid,'END;\n');
fclose(fid);
%% 函数定义
function [coe_data, k] = make_coe_layer(dens0_wght, dens0_bias, coe_data, k, PE_NUM)
    sss = size(dens0_wght);
    nin = sss(2);
    nout = sss(1);
    tiling = ceil(nout / PE_NUM);
    for i=1:tiling
        wnum = min((nout - (i-1)*PE_NUM), PE_NUM);
        coe_data(k,1:wnum) = dens0_bias((i-1)*PE_NUM+1:(i-1)*PE_NUM+wnum,1);k = k + 1;
        for j=1:2:nin
            coe_data(k,1:wnum) = dens0_wght((i-1)*PE_NUM+1:(i-1)*PE_NUM+wnum,j);
            if (j+1>nin),k = k + 1;continue;end
            coe_data(k,PE_NUM+1:PE_NUM+wnum) = dens0_wght((i-1)*PE_NUM+1:(i-1)*PE_NUM+wnum,j+1);k = k + 1;
        end
    end
end
