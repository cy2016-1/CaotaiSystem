clc;
clear all;
close all;
data_path = 'dataset_draw.txt';
% dataset_draw.txt存放了脚尖位置解算的数据集，每一行都是一条单独的数据，第一列
% 是草太脚尖的x轴坐标，第二列是脚尖的y轴坐标，第三列是z轴坐标减220（这里减220
% 的意思是如果草太脚尖z轴坐标是247，则只存放27，使得脚尖的x轴、y轴、z轴坐标数
% 值大小差不多，从而提升神经网络的精度），第四列是当草太脚尖处在该位置时的A点高
% 度，第五列和第六列则分别是B点和C点高度，单位都是毫米mm
%% 读数据
fid = fopen(data_path,'r');
data1 = cell2mat(textscan(fid,'%.4f'));
data1 = reshape(data1,[6 length(data1)/6]);
data1 = data1';
data1(:,3) = data1(:,3);
fclose(fid);
%% 预测
pred_data1 = data1(:,1:3);
real_label1 = data1(:,4:6);
[pred_label1] = function_predict(pred_data1, 2);
[pred_label2] = function_predict_fpga(pred_data1,2);
%% 画图
figure;
% 展示数据集的覆盖范围，是半径为100mm的圆形
scatter3(pred_data1(:,1),pred_data1(:,2),pred_data1(:,3));
axis([-150 150 -150 150 0 50]);
title('数据集里草太脚尖的范围');
figure;
% 把这两幅图画在一起，贴得越紧说明运动逆解算精度越高
scatter3(pred_label1(:,1),pred_label1(:,2),pred_label1(:,3));hold on;
scatter3(real_label1(:,1),real_label1(:,2),real_label1(:,3));hold on;
title('逆解算值和实际精确值对比');
%% 计算mse
mse = sqrt(mean((real_label1-pred_label1).^2))
mse = sqrt(mean((real_label1-pred_label2).^2))
%    0.1392    0.1088    0.1190 % 浮点神经网络的mse
%    0.2505    0.1941    0.2090 % FPGA定点化神经网络的mse
aaa = real_label1-pred_label1;
figure;
plot(aaa(:,1));hold on;
plot(aaa(:,2));hold on;
plot(aaa(:,3));hold on;

